function [hFig, T] = show(obj)
% Show summary table of a NeqSim Java object if available
% function [hFig,T] = show(obj)
%
% INPUT:
%  - obj  - NeqSim Java object
%
% OUTPUT:
%  - hFig - Figure handle if a MATLAB GUI is created (empty if not)
%  - T    - Table that was displayed (empty if not)
%
% EXAMPLE:
% show(thermoSystem);
% show(valve);

hFig = gobjects(1);
T    = table.empty;

% --- Basic checks ---------------------------------------------------------
if ~usejava('jvm')
    error('neqsim:show:noJVM','Java Virtual Machine is not available in MATLAB.');
end
if ~isjava(obj)
    error('neqsim:show:noJavaObject','Input obj is not a Java object (and thus not a NeqSim object).');
end
objClass = class(obj);
if ~(startsWith(objClass,'neqsim') || strncmp(objClass,'neqsim',6))
    error('neqsim:show:noNeqSim','Input object (%s) is not a NeqSim class.', objClass);
end

% Discover available methods once
fnames = string(methods(obj));

% --- Try to obtain a result table in a robust order -----------------------
C = [];
lastErr = [];

try
    if any(fnames == "getResultTable")
        C = toCell2D(obj.getResultTable());
    end
catch ME
    lastErr = ME;
end

if isempty(C)
    try
        if any(fnames == "calcResultTable")
            C = toCell2D(obj.calcResultTable());
        end
    catch ME
        lastErr = ME;
    end
end

if isempty(C)
    try
        if any(fnames == "createTable") || isa(obj,'neqsim.thermo.system.SystemInterface')
            % Some NeqSim types expect a name argument; use class short name
            [~, simpleName] = fileparts(strrep(objClass,'.',filesep));
            C = toCell2D(obj.createTable(java.lang.String(simpleName)));
        end
    catch ME
        lastErr = ME;
    end
end

% --- If we have a cell table, clean and display it ------------------------
if ~isempty(C)
    % Remove all-empty columns (robust to mixed types)
    try
        isEmptyCol = true(1,size(C,2));
        for j = 1:size(C,2)
            col = C(:,j);
            isEmptyCol(j) = all(cellfun(@(x) isempty(x) || (isstring(x)&&strlength(x)==0) || ...
                (ischar(x)&&isempty(strtrim(x))) , col));
        end
        C(:,isEmptyCol) = [];
    catch
        % If anything goes wrong, keep columns as-is
    end

    % Build table: first row = header if nonempty; else autogenerate
    headers = C(1,:);
    hasHeader = any(~cellfun(@isempty, headers));
    if hasHeader
        data = C(2:end,:);
        varNames = headers;
    else
        data = C;
        varNames = arrayfun(@(k) sprintf('Var%d',k), 1:size(C,2), 'UniformOutput', false);
    end

    % Make valid & unique variable names
    varNames = matlab.lang.makeValidName(string(varNames));
    varNames = matlab.lang.makeUniqueStrings(varNames);

    % Heuristic: if first/last names are missing, set common labels
    if ~hasHeader
        if ~isempty(varNames); varNames(1) = "Property"; end
        if ~isempty(varNames); varNames(end) = "Unit"; end
    end

    % Convert any Java scalars in data to MATLAB types
    data = cellfun(@j2m, data, 'UniformOutput', false);

    T = cell2table(data, 'VariableNames', cellstr(varNames));

    % Try to display using uitable in a figure (works in MATLAB/desktop)
    try
        f = figure('Name', sprintf('NeqSim: %s', objClass), 'NumberTitle','off', ...
                   'Units','normalized','Position',[0.2 0.2 0.6 0.6]);
        h = uitable('Parent', f, 'Data', T{:,:}, ...
                    'ColumnName', T.Properties.VariableNames, ...
                    'Units','normalized', 'Position',[0 0 1 1]);
        hFig = f;
    catch
        % If GUI not available (e.g., headless), just print a preview
        disp(T);
    end
    return
end

% --- If no table could be produced, fall back to built-in displays --------
if any(fnames == "display")
    obj.display();
    return
elseif any(fnames == "displayResult")
    obj.displayResult();
    return
else
    if ~isempty(lastErr)
        warning('show:fallback','No table method worked (%s). Falling back; no display method available for %s.', ...
            lastErr.message, objClass);
    else
        warning('show:notPossibleToShow','No display function available for object of type %s', objClass);
    end
end

end % function show

% ======================================================================
% Helpers
% ======================================================================

function C = toCell2D(A)
% Convert a Java 2-D array (e.g., Object[][] or String[][]) to a MATLAB cell matrix.
    if iscell(A)
        C = A;
        return;
    end
    % If already a MATLAB matrix or table-like, wrap to cell
    if isnumeric(A) || isstring(A) || ischar(A)
        C = num2cell(A);
        return;
    end
    % Expect a Java array-of-arrays
    try
        nRow = A.length;
        if nRow == 0
            C = cell(0,0); return;
        end
        firstRow = A(1);
        nCol = firstRow.length;
        C = cell(nRow, nCol);
        for i = 1:nRow
            row = A(i);
            for j = 1:nCol
                C{i,j} = j2m(row(j));
            end
        end
    catch ME
        error('neqsim:show:convert','Could not convert Java result table to cell: %s', ME.message);
    end
end

function x = j2m(v)
% Convert common Java scalar types into MATLAB native types.
    if isa(v,'java.lang.Number')
        x = double(v.doubleValue());
    elseif isa(v,'java.lang.Boolean')
        x = logical(v.booleanValue());
    elseif isa(v,'java.lang.Character')
        x = char(v.charValue());
    elseif isjava(v)
        x = char(v.toString());
    else
        x = v; % already MATLAB type
    end
end
