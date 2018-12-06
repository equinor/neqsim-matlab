%point dialog.m

%*'This .m file is to be used in conjunction with inputsdlg.m which is a file
%copy written by Takeshi Ikuma 2009-2015 and Luke Reisner 2010
%(note the S in inputSdlg, i.e. not inputdlg)
%source: http://www.mathworks.com/matlabcentral/fileexchange/25862- inputsdlg--enhanced-input-dialog-box
%This document is created by Akul Vis

clear; 
close all;
point_model=1; %used in wax calc..m file to determine if point model values are to be used or not
Title = 'Akul''s Wax Deposition Program';

%%%% SETTING DIALOG OPTIONS
% Options.WindowStyle = 'modal';
Options.Resize = 'on';
Options.CancelButton = 'on';
Options.Interpreter = 'tex';
Options.ButtonNames = {'OK','Cancel'}; %<- default names, included here just for illustration
Option.Dim = 4; % Horizontal dimension in fields

Prompt = {};
Formats = {};
DefAns = struct([]);

Prompt(1,:) = {['This Program is Creaded by Akul Viswanathan and should only be used or made public with the concent of the creator. Creator''s e-mail address: akul1291@outlook.com. NB! Use period "." as decimal mark'],[],[]};
Formats(1,1).type = 'text';
Formats(1,1).size = [-1 0];
Formats(1,1).span = [1 1]; % item is 1 field x 4 fields %changed from [1 2]
Prompt(2,:) = {' Choose a Wax Model:','model',[]};
Formats(2,1).type = 'list';
Formats(2,1).format = 'text';
Formats(2,1).style = 'radiobutton';
Formats(2,1).items = {'Singh et. al.' 'RRR' 'Heat Analogy' ...
'Matzain' }; %can use ; for new line and '' for empty space have to have space between 'test' 'test2'
Formats(2,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).model = 'RRR'; %first DefAns needs to have ()

%%%
Prompt(end+1,:) = {' Use constant fluid properties or NeqSim','neqsim',[]};
Formats(end+1,1).type = 'list';
Formats(end,1).format = 'text';
Formats(end,1).style = 'radiobutton';
Formats(end,1).items = {'No NeqSim' 'NeqSim'}; %can use ; for new line and '' for empty space have to have space between 'test' 'test2'
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).neqsim = 'NeqSim'; %first DefAns needs to have ()

Prompt(end+1,:) = {' Length of pipesegment : ','dz','[m]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).dz = '0.5'; %first DefAns needs to have ()

Prompt(end+1,:) = {' Length of fluid segment: ','l dz','[m]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).l_dz = '50'; %first DefAns needs to have ()

Prompt(end+1,:) = {' Number of fluid segments: ','total num FLUID seg','[ - ]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height

Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).total_num_FLUID_seg = '15700'; %first DefAns needs to have ()

Prompt(end+1,:) = {' Pipeline length: ','total length','[m]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).total_length = '0.5'; %first DefAns needs to have ()
%%%

%%%%
Prompt(end+1,:) = {'','Table',[]};
Formats(end+1,1).type = 'table';
Formats(end,1).format = {'char' 'logical'}; % table (= table in main dialog) / window (= table in separate dialog)
Formats(end,1).items = {'Chose plot(s) to display' ''};
Formats(end,1).size = [255 73];
Formats(end,2).span = [1 1]; % item is 2 field x 1 fields
DefAns.Table = {'Deposition Thickness' true
'Temperature Profile' false
'Pressure Drop' false
'' false};

Prompt(end+1,:) = {' Hot product mass flow rate: ','m h','[kg/s]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).m_h = '5.678'; %first DefAns needs to have ()
Prompt(end+1,:) = {' Cold seawater annulus mass flow rate: ','m c','[kg/s]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).m_c = '4.167'; %first DefAns needs to have ()

Prompt(end+1,:) = {' Hot product inlet temperature: ' ,'T hin','[C]'}; %convert to [K] afterwards
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';

Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns.T_hin = '20'; %first DefAns needs to have ()

Prompt(end+1,:) = {' Cold seawater annulus inlet temperature, i.e. ambient seawater:' ,'T cin','[C]'}; %convert to [K] afterwards
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).T_cin = '10'; %first DefAns needs to have ()


Prompt(end+1,:) = {' Inner flow diameter: ','D h','[m]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(end,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).D_h = '0.0525'; %first DefAns needs to have ()

Prompt(end+1,:) = {' Outer annulus flow diameter, i.e. without wall thickness included: ','D cout','[m]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).D_cout = '0.1023'; %first DefAns needs to have ()

Prompt(end+1,:) = {' WAT: ','T wat','[C]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).T_wat = '46.75'; %first DefAns needs to have ()

Prompt(end+1,:) = {' Hot fluid pipe wall surface roughness: ','epsi','[mm]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location

% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).epsi = '0.015'; %first DefAns needs to have ()

Prompt(end+1,:) = {' Hot fluid pressure inlet: ','P h inlet','[Bar]'};
Formats(end+1,1).type = 'edit';
Formats(end,1).format = 'text';
Formats(end,1).size = 333; % automatically assign the height
Formats(end,1).labelloc= 'topleft'; %shifts input cell down one
Formats(end,1).unitsloc='rightmiddle'; %unit location
% Formats(7,1).span = [2 1]; % item is 2 field x 1 fields
DefAns(1).P_h_inlet = '1.0132'; %first DefAns needs to have ()

Prompt(end+1,:) = {'Click for more information','',''};
Formats(end+1,1).type = 'button';
Formats(end,1).size = 200;
Formats(end,1).callback = @('','',handles,k)msgbox(sprintf('This Program is created by Akul Viswanathan as part of a Master Thesis',get(handles(k),'String')),'modal');

[Answer,Cancelled] = inputsdlg(Prompt,Title,Formats,DefAns,Options);
%DISPLAYS input values:
Answer

%Check if program is cancelled or not
if Cancelled==1
    disp('Program execution was cancelled!');
    break;
end

%%%
%isequal checks if values are equal, 1-> equal 0-> NOT equal
%check which radio button is chosen
singh= isequal(Answer.model,'Singh et. al.');
rrr= isequal(Answer.model,'RRR');
heatAnalogy=isequal(Answer.model,'Heat Analogy');
matzain= isequal(Answer.model,'Matzain');
%
no neq= isequal(Answer.neqsim,'No NeqSim');
yes neq= isequal(Answer.neqsim,'NeqSim');
%%%

%convert Answeres to numbers and assign a variable name to be used in wax
%program
dz = str2num(Answer.dz);
dz = str2num(Answer.l_dz);
total num FLUID seg= str2num(Answer.total num FLUID seg);
total length= str2num(Answer.total length);
%

m h= str2num(Answer.m h); %str2double converts array to number, here str2num is used because only single value
m c= str2num(Answer.m c);
T hin = str2num(Answer.T hin)+273.15; %273.15 to convert from [C] [K]
T cin = str2num(Answer.T cin)+273.15; %273.15 to convert from [C] to [K]
% del T = str2num(Answer.del T);
D h = str2num(Answer.D h);
D cout= str2num(Answer.D cout);
T wat= str2num(Answer.T wat)+273.15; %273.15 to convert from [C] to [K]
epsi= str2num(Answer.epsi)*10^-3; % 10ˆ-3 to convert from [m] to [mm]
P h inlet= str2num(Answer.P h inlet)*10ˆ5; %10ˆ5 to convert from [Bar] to [Pa]
%%%
%Call Wax model.m program. with or without NeqSim
if no neq==1
 wax calc ediproject heat transfer NO neqsim
 elseif yes neq==1
% CALL PROGRAM WITH NEQSIM
NEQSIM wax calc ediproject heat transfer;
end

%Call plot.m files if checkbox is selected
if cell2mat((Answer.Table(1,2)))==1 %cell2mat is used because the table output value given in a cell array.
%*'callplot.m
disp('plot1');
end
if cell2mat((Answer.Table(2,2)))==1
%*'callplot.m
disp('plot2');
end

if cell2mat((Answer.Table(3,2)))==1
%*'callplot.m
disp('plot3');
end
if cell2mat((Answer.Table(4,2)))==1
%*'callplot.m
disp('plot4');
end
%%%