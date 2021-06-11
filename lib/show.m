function hFig = show(obj)
% Show summary table of NEQSIM object if available
% function hFig = show(obj)
%
% INPUT:
%  - thermoSystem - NEQSIM object
%
% OUTPUT:
%  - hFig         - Figure handle if display is a matlab GUI
%
% DESCRIPTION:
% Show summary table of NEQSIM object if available
%
% EXAMPLE:
% show(thermoSystem);
% show(valve)

try
    if isa(obj,'neqsim.thermo.system.SystemInterface')
        C = cell(obj.createTable("test"));
        T = cell2table(C);
        if nargout > 0
            hFig = uitableplot(T);
        end
        return
    end
catch
end

if ismember('display',methods(obj))
    obj.display();
elseif ismember('displayResult',methods(obj))
    obj.displayResult();
else
    warning('show:notPossibleToShow','No display function available for object of type %s',class(obj));
end

if nargout > 0
    hFig = gobjects(1);
end