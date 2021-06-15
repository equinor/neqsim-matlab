data = struct('feedGasFlowRate', (117000.0+90000.0)*24.0/1.0e6, ...
  'feedGasTemperature', 28.5, ...
  'feedGasPressure', 42.4, ...
  'absorberFeedGasTemperature', 30.5, ...
  'absorberFeedGasPressure', 42.4, ...
  'leanTEGFlowRate', 5432.0*1.1, ...
  'leanTEGTemperature', 36.3, ...
  'flashDrumPressure', 5.0, ...
  'reboilerPressure', 1.23, ...
  'condenserTemperature', 94.0, ...
  'condenserPressure', 1.0, ...
  'reboilerTemperature', 200.3, ...
  'strippingGasRate', 100.0, ...
  'strippingGasFeedTemperature', 120.0, ...
  'regenerationGasCoolerTemperature', 35.0, ...
  'TEGpumpIsentropicEfficiency', 0.75, ...
  'finefilterdeltaP', 0.01, ...
  'carbonfilterdeltaP', 0.01, ... 
  'numberOfEquilibriumStagesTEGabsorber', 5, ...
  'stageEfficiencyTEGabsorber', 0.55, ...
  'stageEfficiencyStripper', 0.5, ...
  'numberOfEquilibriumStagesStripper', 4, ...
  'UAvalueLeanRichTEGHeatExchanger', 16100.0);
% headers = {'Content-type': 'application/json', 'Accept': 'application/json', 'Ocp-Apim-Subscription-Key':'xxxxxxxxxxxx'}
% Ocp-Apim-Subscription-Key available from: https://api-test.portal.equinor.com/products/neqsim-live

% response = requests.post('https://jsv-neqsim-live-api.playground.radix.equinor.com/jsv/dehydSim', data=json.dumps(data), headers=headers)
% response = requests.post('http://localhost:8080/jsv/dehydSim', data=json.dumps(data), params=params, headers=headers) #used for running local

% Get token: https://se.mathworks.com/matlabcentral/answers/737172-how-can-i-obtain-azure-ad-tokens-in-matlab-r2020b
options = weboptions('KeyName','Ocp-Apim-Subscription-Key','KeyValue','xxx');
response = webwrite('https://api-test.gateway.equinor.com/neqsim/jsv/dehydSim',jsonencode(data),options)