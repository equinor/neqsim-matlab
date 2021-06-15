function [hFig,T] = show(obj)
% Show summary table of NEQSIM object if available
% function [hFig,T] = show(obj)
%
% INPUT:
%  - thermoSystem - NEQSIM object
%
% OUTPUT:
%  - hFig         - Figure handle if display is a matlab GUI
%  - T            - Table data displayed if available.
%
% DESCRIPTION:
% Show summary table of NEQSIM object if available
%
% EXAMPLE:
% show(thermoSystem);
% show(valve)

if isjava(obj)
    objClass = class(obj);
    if ~startsWith(objClass,'neqsim')
        error('neqsim:show:noJavaObject','Input obj is not a NeqSim object');
    end
else
    error('neqsim:show:noJavaObject','Input obj is not a java object, and then not a NeqSim object');
end

functions = methods(obj);

try
    if ismember('getResultTable',functions)
        C = cell(obj.getResultTable());
    elseif ismember('calcResultTable',functions)
        C = cell(obj.calcResultTable());
    elseif isa(obj,'neqsim.thermo.system.SystemInterface')
        C = cell(obj.createTable("test"));
    end
    T = cell2table(C(2:end,:));
    indHasColumnName = ~cellfun(@isempty,C(1,:));
    T.Properties.VariableNames(indHasColumnName) = C(1,indHasColumnName);
    T.Properties.VariableNames{1} = 'Property';
    T.Properties.VariableNames{end} = 'Unit';
    
    if isfunction('uitableplot')
        hFig = uitableplot(T);
    else
        hFig = gobjects(1);
    end
    return
catch
end

if ismember('display',functions)
    obj.display();
elseif ismember('displayResult',functions)
    obj.displayResult();
else
    warning('show:notPossibleToShow','No display function available for object of type %s',class(obj));
end

if nargout > 0
    hFig = gobjects(1);
    T = table.empty;
end