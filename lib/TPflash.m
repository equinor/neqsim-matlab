function [thermoSystem, hFig] = TPflash(thermoSystem, display)
% Run TP (temperature, pressure) flash on thermoSystem
% function [thermoSystem, hFig] = TPflash(thermoSystem,display)
%
% INPUT:
%  - thermoSystem - NeqSim Thermodynamic system (Java) object
%
% OPTIONAL INPUT:
%  - display      - true to show result (default: nargout>1)
%
% OUTPUT:
%  - thermoSystem - The flashed system (updated in-place)
%  - hFig         - Figure handle if shown (empty/gobject if not)
%
% EXAMPLE:
% thermoSystem = TPflash(thermoSystem);
% [thermoSystem, h] = TPflash(thermoSystem, true);

narginchk(1,2);

% Default outputs
hFig = gobjects(1);

% Optional path bootstrap (safe if missing)
if exist('pathNeqSim','file') == 2
    pathNeqSim();
end

% Default display behavior
if nargin < 2
    display = (nargout > 1);
end

% Basic checks
if ~usejava('jvm')
    error('neqsim:TPflash:noJVM','Java Virtual Machine is not available in MATLAB.');
end
if ~isjava(thermoSystem) || ~isa(thermoSystem, 'neqsim.thermo.system.SystemInterface')
    error('neqsim:TPflash:invalidType', ...
        'Expected a NeqSim SystemInterface Java object, got %s.', class(thermoSystem));
end

% Perform TP flash
try
    ops = neqsim.thermodynamicoperations.ThermodynamicOperations(thermoSystem);
    ops.TPflash();
catch ME
    error('neqsim:TPflash:flashFailed','TPflash failed: %s', ME.message);
end

% Re-initialize properties (level 3 = full init)
try
    thermoSystem.init(3);
catch ME
    warning('neqsim:TPflash:initWarning','System init(3) after TPflash warned: %s', ME.message);
end

% Optional display
if display
    try
        % Use robust generic show() you implemented earlier
        if nargout > 1
            [hFig, ~] = show(thermoSystem);
        else
            show(thermoSystem);
        end
    catch ME
        % Graceful fallback to built-in NeqSim displays
        fns = string(methods(thermoSystem));
        if any(fns=="displayResult")
            thermoSystem.displayResult();
        elseif any(fns=="display")
            thermoSystem.display();
        else
            warning('neqsim:TPflash:displayFailed','Display failed: %s', ME.message);
        end
    end
end
end
