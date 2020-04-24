%calculate the interfacial tension of methane + n-butane at310.95K and
%108 Bar
%reference comp. : highest boiling point
%javaclasspath('NeqSimSource.jar')
% system1 = SystemSrkEos(273.15+50, 120); %
%system1 = SystemPrEos(273.15+21,20.25);
    %system1 = SystemSrkCPAs(273.15+50, 120); %
  testSystem = neqsim.thermo.system.SystemSrkEos(273.15-0.9,85.1); 
 testSystem.getCharacterization().setTBPModel('PedersenSRK');
        testSystem.addComponent('nitrogen',1.11008);
         testSystem.addComponent('CO2', 3.44907);
        testSystem.addComponent('methane', 84.81746);
        testSystem.addComponent('ethane', 6.43178);
             testSystem.addComponent('propane', 2.58019);
             testSystem.addComponent('i-butane', 0.34323);
             testSystem.addComponent('n-butane', 0.67274);
             testSystem.addComponent('22-dim-C3', 0.00966);
               testSystem.addComponent('iC5', 0.15992);
               testSystem.addComponent('n-pentane', 0.16462);
             testSystem.addComponent('c-C5', 0.00868);
             testSystem.addComponent('22-dim-C4',0.00322);
             testSystem.addComponent('23-dim-C4',0.00578);
              testSystem.addComponent('2-m-C5', 0.03526);
             testSystem.addComponent('3-m-C5', 0.01817);
             testSystem.addComponent('n-hexane', 0.04755);
             testSystem.addComponent('benzene ', 0.02048);
             testSystem.addComponent('c-hexane', 0.04492);
             testSystem.addComponent('n-heptane', 0.03112);
             testSystem.addComponent('toluene',0.01094);
             testSystem.addComponent('c-C7', 0.02161);
             testSystem.addComponent('n-octane', 0.00693);
             testSystem.addComponent('m-Xylene', 0.00257);
             testSystem.addComponent('c-C8', 0.00141);
            testSystem.addComponent('n-nonane ', 0.00195);
        testSystem.addPlusFraction('C10', 0.00063, 134/ 1000.0, 0.7920);
        testSystem.addTBPfraction('C11', 0.00002, 147/ 1000.0, 0.7960);
%    
     %20110803  Amenas - V-101
%      system1.addComponent('CO2', 3.664248);
%      system1.addComponent('nitrogen', 0.486330);
%      system1.addComponent('methane', 81.639644);
%       system1.addComponent('ethane', 7.346435);
%       system1.addComponent('propane', 3.147652);
%         system1.addComponent('i-butane', 0.545693);
%          system1.addComponent('n-butane', 0.948682);
%          system1.addComponent('iC5',0.383671);
%          system1.addComponent('n-pentane', 0.306472);
% system1.addComponent('n-hexane', 0.336484);
%  system1.addComponent('M-cy-C5', 0.044106);
%    system1.addComponent('benzene', 0.010497);
%   system1.addComponent('c-hexane', 0.046501);
%   system1.addComponent('n-heptane ', 0.170392);
%    system1.addComponent('toluene', 0.074898);
%   system1.addComponent('n-octane', 0.115846);
%     system1.addComponent('ethylbenzene', 0.009827);
%     system1.addComponent('p-Xylene', 0.016907);
%      system1.addComponent('o-Xylene', 0.003673); 
%      system1.addComponent('n-nonane', 0.056128);
%       system1.addComponent('nC10', 0.031058);
%        system1.addComponent('nC11', 0.012630);
%         system1.addComponent('nC12', 0.005124);
%        system1.addComponent('nC13', 0.001771);
%        system1.addComponent('nC14', 0.000640);
%        system1.addComponent('nC15', 0.000305);
%        system1.addComponent('nC16', 0.000114);
%        system1.addComponent('nC17', 0.000054);
%        system1.addComponent('nC18', 0.000025);
%        system1.addComponent('nC19', 0.000018);
%        system1.addComponent('nC20', 0.000006);

  %20110803  Amenas - V-102
%      system1.addComponent('CO2', 1.7082978032);
%      system1.addComponent('nitrogen', 0.5019710797);
%      system1.addComponent('methane', 84.1448567750);
%       system1.addComponent('ethane', 7.5277710999);
%       system1.addComponent('propane', 3.1878530574);
%         system1.addComponent('i-butane', 0.5428756463);
%          system1.addComponent('n-butane', 0.9337470828);
%          system1.addComponent('iC5',0.3628065112);
%          system1.addComponent('n-pentane', 0.2842868504);
% system1.addComponent('n-hexane', 0.2774703118);
%  system1.addComponent('M-cy-C5', 0.0355669111);
%    system1.addComponent('benzene', 0.0083049769);
%   system1.addComponent('c-hexane', 0.0359408430);
%   system1.addComponent('n-heptane ', 0.1143078368);
%    system1.addComponent('toluene', 0.0455624085);
%   system1.addComponent('n-octane', 0.0557236040);
%     system1.addComponent('ethylbenzene', 0.0040604248);
%     system1.addComponent('p-Xylene', 0.0065659758);
%      system1.addComponent('o-Xylene', 0.0013513612); 
%      system1.addComponent('n-nonane', 0.0171064328);
%       system1.addComponent('nC10', 0.0055866694);
%        system1.addComponent('nC11', 0.0012070014);
%         system1.addComponent('nC12', 0.0002812249);
%        system1.addComponent('nC13', 0.0000459691);
%        system1.addComponent('nC14', 0.0000074815);
%        system1.addComponent('nC15', 0.0000022344);
%        system1.addComponent('nC16', 0.0000004410);
%        system1.addComponent('nC17', 0.0000001452);
%        system1.addComponent('nC18', 0.0000000460);
%        system1.addComponent('nC19', 0.0000000245);
%        system1.addComponent('nC20', 0.0000000024);

  
    % 20101005 IFT EXPERIMENT TEST -- November
%      system1.addComponent('methane', 50.61);
%      system1.addComponent('ethane', 8.93);
%      system1.addComponent('n-pentane', 40.46);
% %     
% % %  
%         system1.addComponent('methane', 34.20);
%      system1.addComponent('ethane', 6.04);
%      system1.addComponent('n-pentane', 59.76);
% 
%          system1.addComponent('methane', 17.46);
%      system1.addComponent('ethane', 3.08);
%      system1.addComponent('n-pentane', 79.46);

    % Gudrun-15-3-8ssTC1 without H2S
% 
%         system1.addComponent('nitrogen', 0.49);
%         system1.addComponent('CO2', 10.517);
%         system1.addComponent('methane', 52.165);
%         system1.addComponent('ethane', 9.076);
%         system1.addComponent('propane', 6.124);
%         system1.addComponent('i-butane', 0.751);
%         system1.addComponent('n-butane', 2.422);
%         system1.addComponent('iC5', 0.74);
%         system1.addComponent('n-pentane', 1.101);
%           system1.addTBPfraction('C6', 1.301,86.183/1000.0,0.6638);
%           system1.addTBPfraction('C7', 2.231, 94.847/1000.0, 0.7371);
%           system1.addTBPfraction('C8', 2.442, 106.22/1000.0, 0.7627);
%           system1.addTBPfraction('C9', 1.741, 120.457/1000.0,0.7788);
%           system1.addTBPfraction('C10-C11', 1.856, 140.369/1000.0,0.795);
%            system1.addTBPfraction('C12-C13', 1.469, 167.562/1000.0,0.8135);
%             system1.addTBPfraction('C14-C15', 1.163, 197.501/1000.0,0.8295);
%              system1.addTBPfraction('C16-C17', 0.92, 229.034/1000.0,0.8433); 
%              system1.addTBPfraction('C18-C20', 1.033, 262.011/1000.0,0.8582);
%  system1.addTBPfraction('C21-C23', 0.728, 303.559/1000.0,0.874);
%   system1.addTBPfraction('C24-C28', 0.767, 355.92/1000.0,0.8917);
%    system1.addTBPfraction('C29-C35', 0.539, 437.281/1000.0,0.9132);
%     system1.addTBPfraction('C36-C80', 0.423, 608.036/1000.0,0.9492);

%Gudrun-15-3-8ssTC1 with H2S
%        system1.addComponent('H2S', 0.002);
%         system1.addComponent('nitrogen', 0.594234);
%         system1.addComponent('CO2', 11.7973);
%         system1.addComponent('methane', 63.360102);
%         system1.addComponent('ethane', 9.878181);
%         system1.addComponent('propane', 5.818754);
%         system1.addComponent('i-butane', 0.641047);
%         system1.addComponent('n-butane', 1.899092);
%         system1.addComponent('iC5', 0.490090);
%         system1.addComponent('n-pentane', 0.677043);
%           system1.addTBPfraction('C6', 0.850580,86.183/1000.0,0.6638);
%           system1.addTBPfraction('C7', 0.805458, 94.847/1000.0, 0.7371);
%           system1.addTBPfraction('C8', 0.684532, 106.22/1000.0, 0.7627);
%           system1.addTBPfraction('C9', 0.352787, 120.457/1000.0,0.7788);
%           system1.addTBPfraction('C10-C11', 0.242165, 140.369/1000.0,0.795);
%            system1.addTBPfraction('C12-C13', 0.102325, 167.562/1000.0,0.8135);
%             system1.addTBPfraction('C14-C15', 0.043452, 197.501/1000.0,0.8295);
%              system1.addTBPfraction('C16-C17', 0.020665, 229.034/1000.0,0.8433); 
%              system1.addTBPfraction('C18-C20', 0.016611, 262.011/1000.0,0.8582);
%  system1.addTBPfraction('C21-C23', 0.009709, 303.559/1000.0,0.874);
%   system1.addTBPfraction('C24-C28', 0.009630, 355.92/1000.0,0.8917);
%    system1.addTBPfraction('C29-C35', 0.006581, 437.281/1000.0,0.9132);
%     system1.addTBPfraction('C36-C80', 0.005007, 608.036/1000.0,0.9492);
%     
    %Gudrun PDS MAX GAS RATE
%     system1.addComponent('H2S', 0.002);
%         system1.addComponent('nitrogen', 0.432);
%         system1.addComponent('CO2', 9.089);
%         system1.addComponent('methane', 68.760);
%         system1.addComponent('ethane', 8.762);
%         system1.addComponent('propane', 4.867);
%         system1.addComponent('i-butane', 0.559);
%         system1.addComponent('n-butane', 1.637);
%         system1.addComponent('iC5', 0.445);
%         system1.addComponent('n-pentane', 0.615);
%           system1.addTBPfraction('C6', 0.774,86.183/1000.0,0.6638);
%           system1.addTBPfraction('C7', 0.816, 94.847/1000.0, 0.7371);
%           system1.addTBPfraction('C8', 0.688, 106.22/1000.0, 0.7627);
%           system1.addTBPfraction('C9', 0.353, 120.457/1000.0,0.7788);
%           system1.addTBPfraction('C10-C11', 0.241, 140.369/1000.0,0.795);
%            system1.addTBPfraction('C12-C13', 0.1, 167.562/1000.0,0.8135);
%             system1.addTBPfraction('C14-C15', 0.042, 197.501/1000.0,0.8295);
%              system1.addTBPfraction('C16-C17', 0.020, 229.034/1000.0,0.8433); 
%              system1.addTBPfraction('C18-C20', 0.017, 262.011/1000.0,0.8582);
%  system1.addTBPfraction('C21-C23', 0.010, 303.559/1000.0,0.874);
%   system1.addTBPfraction('C24-C28', 0.010, 355.92/1000.0,0.8917);
%    system1.addTBPfraction('C29-C35', 0.007, 437.281/1000.0,0.9132);
%     system1.addTBPfraction('C36-C80', 0.005, 608.036/1000.0,0.9492);
    
%Gudrun15-3-8 SST2
%     
%         system1.addComponent('nitrogen', 0.392);
%         system1.addComponent('CO2', 10.231);
%         system1.addComponent('methane', 48.272);
%         system1.addComponent('ethane', 8.293);
%         system1.addComponent('propane', 6.466);
%         system1.addComponent('i-butane', 0.673);
%         system1.addComponent('n-butane', 2.63);
%         system1.addComponent('iC5', 0.753);
%         system1.addComponent('n-pentane', 1.175);
%           system1.addTBPfraction('C6', 1.406,86.183/1000.0,0.6638);
%           system1.addTBPfraction('C7', 2.57, 94.847/1000.0, 0.7371);
%           system1.addTBPfraction('C8', 2.841, 106.22/1000.0, 0.7627);
%           system1.addTBPfraction('C9', 2.088, 120.457/1000.0,0.7788);
%           system1.addTBPfraction('C10-C11', 2.416, 140.369/1000.0,0.795);
%            system1.addTBPfraction('C12-C13', 1.938, 167.562/1000.0,0.8135);
%             system1.addTBPfraction('C14-C15', 1.555, 197.501/1000.0,0.8295);
%              system1.addTBPfraction('C16-C17', 1.247, 229.034/1000.0,0.8433); 
%              system1.addTBPfraction('C18-C20', 1.424, 262.011/1000.0,0.8582);
%  system1.addTBPfraction('C21-C23', 1.023, 303.559/1000.0,0.874);
%   system1.addTBPfraction('C24-C28', 1.106, 355.92/1000.0,0.8914);
%    system1.addTBPfraction('C29-C35', 0.809, 437.281/1000.0,0.9132);
%     system1.addTBPfraction('C36-C80', 0.691, 608.036/1000.0,0.9492);
%     
    
%Gudrun15-3-8 SST3
%     
%         system1.addComponent('nitrogen', 0.41);
%         system1.addComponent('CO2', 8.085);
%         system1.addComponent('methane', 61.035);
%         system1.addComponent('ethane', 9.315);
%         system1.addComponent('propane', 5.493);
%         system1.addComponent('i-butane', 0.72);
%         system1.addComponent('n-butane', 2.041);
%         system1.addComponent('iC5', 0.63);
%         system1.addComponent('n-pentane', 0.85);
%           system1.addTBPfraction('C6', 1.001,86.183/1000.0,0.6638);
%           system1.addTBPfraction('C7', 1.791, 94.847/1000.0, 0.7371);
%           system1.addTBPfraction('C8', 1.881, 106.22/1000.0, 0.7627);
%           system1.addTBPfraction('C9', 1.231, 120.457/1000.0,0.7788);
%           system1.addTBPfraction('C10-C11', 1.433, 140.369/1000.0,0.795);
%            system1.addTBPfraction('C12-C13', 1.061, 167.562/1000.0,0.8135);
%             system1.addTBPfraction('C14-C15', 0.785, 197.501/1000.0,0.8295);
%              system1.addTBPfraction('C16-C17', 0.581, 229.034/1000.0,0.8433); 
%              system1.addTBPfraction('C18-C20', 0.601, 262.011/1000.0,0.8582);
%  system1.addTBPfraction('C21-C23', 0.383, 303.559/1000.0,0.874);
%   system1.addTBPfraction('C24-C28', 0.355, 355.92/1000.0,0.8914);
%    system1.addTBPfraction('C29-C35', 0.206, 437.281/1000.0,0.9132);
%     system1.addTBPfraction('C36-C80', 0.11, 608.036/1000.0,0.9492);

%Gudrun kvittbjørn
%     
%         system1.addComponent('nitrogen', 0.181962);
%         system1.addComponent('CO2', 3.599903);
%         system1.addComponent('methane', 82.40229);
%         system1.addComponent('ethane', 7.007135);
%         system1.addComponent('propane', 2.991469);
%         system1.addComponent('i-butane', 0.438073);
%         system1.addComponent('n-butane', 0.922457);
%         system1.addComponent('iC5', 0.294432);
%         system1.addComponent('n-pentane', 0.331434);
%           system1.addTBPfraction('C6', 0.368681,86.183/1000.0,0.6638);
%           system1.addTBPfraction('C7', 0.51077, 94.847/1000.0, 0.7371);
%           system1.addTBPfraction('C8', 0.45878, 106.22/1000.0, 0.7627);
%           system1.addTBPfraction('C9', 0.223387, 120.457/1000.0,0.7788);
%           system1.addTBPfraction('C10-C11', 0.155354, 140.369/1000.0,0.795);
%            system1.addTBPfraction('C12-C13', 0.070806, 167.562/1000.0,0.8135);
%             system1.addTBPfraction('C14-C15', 0.01825, 197.501/1000.0,0.8295);
%              system1.addTBPfraction('C16-C17', 0.017039, 229.034/1000.0,0.8433); 
%              system1.addTBPfraction('C18-C20', 0.005666, 262.011/1000.0,0.8582);
%  system1.addTBPfraction('C21-C23', 0.002012, 303.559/1000.0,0.874);
%   system1.addTBPfraction('C24-C28', 0.0001, 355.92/1000.0,0.8914);
  

    %pedersen et al., 1989, gas condensate 1 
%      system1.setTBPFractionModel('PedersenSRK');
%         system1.addComponent('ethane', 0.42);
%         system1.addComponent('propane', 2.22);
%         system1.addComponent('i-butane', 1.21);
%         system1.addComponent('n-butane', 4.48);
%         system1.addComponent('iC5',3.15);
%         system1.addComponent('n-pentane', 4.92);
%          system1.addTBPfraction('C6', 8.42, 85/1000.0,0.684);
%         system1.addTBPfraction('C7', 15.31, 93/1000.0,0.743);
%          system1.addTBPfraction('C8', 16.67, 107/1000.0,0.753);
%          system1.addTBPfraction('C9',10.96, 220/1000.0,0.776);
%          system1.addTBPfraction('C10', 32.24,226/1000.0,0.848);
%     

%
%Fawcett et al., 1994
%         system1.addComponent('methane', 76);
%         system1.addComponent('ethane', 8);
%         system1.addComponent('propane', 6);
%          system1.addComponent('n-pentane', 4);
%          system1.addComponent('n-nonane', 2.8);
%          system1.addComponent('nC16', 3.2);

 %Sequeira et al 2008 0.893 CO2 + 0.107 recombined reservoir oil @ 387.6K  
%       system1.setTBPFractionModel('PedersenSRK');
%         system1.addComponent('nitrogen', 0.013);
%         system1.addComponent('CO2',45.015);
%         system1.addComponent('methane', 0.651);
%             system1.addComponent('ethane', 0.004);
%         system1.addComponent('propane', 0.012);
%         system1.addComponent('i-butane', 0.026);
%         system1.addComponent('n-butane', 0.088);
%         system1.addComponent('iC5',0.247);
%         system1.addComponent('n-pentane', 0.264);
%          system1.addComponent('C6TOTAL', 1.048);
%        system1.addTBPfraction('C7-001', 52.632, 218/1000.0,0.8351);


        %Sequeira et al 2008 0.893 CO2 + 0.107 recombined reservoir oil @ 387.6K  
%       system1.setTBPFractionModel('PedersenSRK');
%         system1.addComponent('nitrogen', 0.002);
%         system1.addComponent('CO2',0.719);
%         system1.addComponent('methane', 7.265);
%         system1.addComponent('ethane', 0.003);
%         system1.addComponent('propane', 0.006);
%         system1.addComponent('i-butane', 0.020);
%         system1.addComponent('n-butane', 0.057);
%         system1.addComponent('iC5',0.191);
%         system1.addComponent('n-pentane', 0.179);
%          system1.addComponent('C6TOTAL', 0.706);
%        system1.addTBPfraction('C7-001', 21.551, 220.7/1000.0,0.839);
       
      
%Gasem et al. 1993 CO2/Synthetic oil @ 120 F
%         system1.addComponent('CO2',91.681);
%         system1.addComponent('methane', 2.874);
%         system1.addComponent('ethane', 0.251);
%         system1.addComponent('propane', 0.332);
%         system1.addComponent('n-butane', 0.515);
%         system1.addComponent('n-pentane', 0.344);
%           system1.addComponent('n-hexane', 0.272);
%           system1.addComponent('n-heptane',0.412);
%         system1.addComponent('n-octane', 0.419);
%        system1.addComponent('nC10', 2.477);
%         system1.addComponent('nC14', 0.424);

%Gasem et al. 1993 CO2/Synthetic oil @ 150 F
%         system1.addComponent('CO2',83.31);
%         system1.addComponent('methane', 5.046);
%         system1.addComponent('ethane', 0.453);
%         system1.addComponent('propane', 0.592);
%         system1.addComponent('n-butane', 0.905);
%         system1.addComponent('n-pentane', 0.613);
%           system1.addComponent('n-hexane', 0.493);
%           system1.addComponent('n-heptane',0.748);
%         system1.addComponent('n-octane', 0.759);
%        system1.addComponent('nC10', 4.325);
%         system1.addComponent('nC14', 0.758);
        
      %Gasem et al. 1993 CO2/Reservoir oil @ 130 F  
%       system1.setTBPFractionModel('PedersenSRK');
%         system1.addComponent('nitrogen', 0.1);
%         system1.addComponent('CO2',55.55);
%         system1.addComponent('methane', 13.74);
%         system1.addComponent('ethane', 4.77);
%         system1.addComponent('propane', 4.480);
%         system1.addComponent('i-butane', 0.2);
%         system1.addComponent('n-butane', 2.8);
%         system1.addComponent('iC5',0.56);
%         system1.addComponent('n-pentane', 1.28);
%          system1.addComponent('C6TOTAL', 1.23);
%        system1.addTBPfraction('C7-001', 14.97, 180.5/1000.0,0.8336);

%Firoozabadi et al 1988, crude A
%        system1.setTBPFractionModel('PedersenSRK');%Also available models//RiaziDaubert//PedersenSRK
%        
%         system1.addComponent('nitrogen', 0.02);
%         system1.addComponent('CO2',1);
%         system1.addComponent('methane', 36.13);
%         system1.addComponent('ethane', 5.95);
%         system1.addComponent('propane', 4.44);
%         system1.addComponent('i-butane', 0.79);
%         system1.addComponent('n-butane', 2.12);
%         system1.addComponent('iC5',1.03);
%         system1.addComponent('n-pentane', 1.25);
%         system1.addComponent('C6TOTAL', 1.97);
%       system1.addTBPfraction('C7-001', 45.30, 227.4/1000.0,0.87);

%         
  % Firoozabadi et al 1988, crude C
%        system1.setTBPFractionModel('PedersenSRK');%Also available models//RiaziDaubert//PedersenSRK
% %        
%         system1.addComponent('nitrogen', 0.03);
%         system1.addComponent('CO2',2.02);
%         system1.addComponent('methane', 51.53);
%         system1.addComponent('ethane', 8.07);
%         system1.addComponent('propane', 5.04);
%         system1.addComponent('i-butane', 0.83);
%         system1.addComponent('n-butane', 2.04);
%         system1.addComponent('iC5',0.84);
%         system1.addComponent('n-pentane', 1.05);
%         system1.addComponent('C6TOTAL', 1.38);
%        system1.addTBPfraction('C7-001', 27.17, 217/1000.0,0.87);

 % Firoozabadi et al 1988, crude D
%       system1.setTBPFractionModel('PedersenSRK');%Also available models//RiaziDaubert//PedersenSRK
%        
%         system1.addComponent('nitrogen', 0.45);
%         system1.addComponent('CO2',0.16);
%         system1.addComponent('methane', 36.71);
%         system1.addComponent('ethane', 8.44);
%         system1.addComponent('propane', 6.03);
%         system1.addComponent('i-butane', 1.24);
%         system1.addComponent('n-butane', 3.67);
%         system1.addComponent('iC5',1.80);
%         system1.addComponent('n-pentane', 2.36);
%         system1.addComponent('C6TOTAL', 3.03);
%       system1.addTBPfraction('C7-001', 36.11, 234.3/1000.0,0.868);

% Firoozabadi et al 1988, AF OIL
%       system1.setTBPFractionModel('PedersenSRK');%Also available models//RiaziDaubert//PedersenSRK
%        
%         system1.addComponent('nitrogen', 0.12);
%         system1.addComponent('CO2',2.98);
%         system1.addComponent('methane', 66.87);
%         system1.addComponent('ethane', 6.86);
%         system1.addComponent('propane', 3.96);
%         system1.addComponent('i-butane', 0.73);
%         system1.addComponent('n-butane', 1.82);
%         system1.addComponent('iC5',0.83);
%         system1.addComponent('n-pentane', 1.03);
%         system1.addComponent('C6TOTAL', 1.40);
%       system1.addTBPfraction('C7-001', 13.40, 164.7/1000.0,0.810);
%       
  %Firoozabadi et al 1988, AF OIL + LEAN GAS
%       system1.setTBPFractionModel('PedersenSRK');%Also available models//RiaziDaubert//PedersenSRK
%        
%         system1.addComponent('nitrogen', 0.11);
%         system1.addComponent('CO2',1.46);
%         system1.addComponent('methane', 54.83);
%         system1.addComponent('ethane', 8.08);
%         system1.addComponent('propane', 9.10);
%         system1.addComponent('i-butane', 2.23);
%         system1.addComponent('n-butane', 5.90);
%         system1.addComponent('iC5',2.38);
%         system1.addComponent('n-pentane', 2.8);
%         system1.addComponent('C6TOTAL', 2.53);
%       system1.addTBPfraction('C7-001', 10.58, 151/1000.0,0.79);
%       
 % Danesh el al 1991, fluid A
%     system1.addComponent('methane',82.05)
%     system1.addComponent('propane', 8.95);
%     system1.addComponent('n-pentane', 5);
%      system1.addComponent('nC10', 1.99);
%      system1.addComponent('nC16', 2.01);
%     

% Danesh el al 1991, fluid B
%     system1.addComponent('methane',82.32)
%     system1.addComponent('propane', 8.71);
%     system1.addComponent('n-pentane', 5.05);
%      system1.addComponent('nC10', 1.98);
%      system1.addComponent('nC16', 1.94);
     
%Danesh el al 1991, fluid c
%     system1.addComponent('methane',80.11)
%     system1.addComponent('ethane', 8.23);
%     system1.addComponent('propane', 2.11);
%      system1.addComponent('n-butane', 1.07);
%      system1.addComponent('n-pentane', 0.80);
%      system1.addComponent('n-hexane', 1.20);
%      system1.addComponent('n-heptane', 0.96);
%      system1.addComponent('n-octane', 0.55);
%      system1.addComponent('n-nonane', 0.49);
%      system1.addComponent('nC10', 0.48);
%      system1.addComponent('nC11', 0.45);
%      system1.addComponent('nC12', 0.44);
%      system1.addComponent('nC13', 0.44);
%      system1.addComponent('nC14', 0.41);
%      system1.addComponent('nC15', 0.41);
%      system1.addComponent('nC16', 0.39);
%      system1.addComponent('nC17', 0.38);
%      system1.addComponent('nC18', 0.37);
%      system1.addComponent('nC19', 0.36);
%       system1.addComponent('nC20', 0.35);
%       
  %Huygens et al 1993 N2/3HC,position
%    system1.addComponent('nitrogen', 93.4)
%     system1.addComponent('nC14', 6.6);
    
%Smørbukk well 6506-12-08
% system1 = SystemPrEos(273.15+141,280);
%         system1.addComponent('nitrogen', 0.546);
%         system1.addComponent('CO2', 2.826);
%         system1.addComponent('methane', 55.565);
%         system1.addComponent('ethane', 8.594);
%         system1.addComponent('propane', 5.745);
%         system1.addComponent('i-butane', 1.009);
%         system1.addComponent('n-butane', 2.435);
%         system1.addComponent('iC5', 0.895);
%         system1.addComponent('n-pentane', 1.24);
%           system1.addTBPfraction('C6', 1.581,85.04/1000.0,0.668);
%           system1.addTBPfraction('C7', 2.552, 91.50/1000.0, 0.738);
%           system1.addTBPfraction('C8', 2.747, 101.20/1000.0, 0.765);
%           system1.addTBPfraction('C9', 1.699, 119.10/1000.0,0.781);
%           system1.addTBPfraction('C10', 12.565, 254.90/1000.0,0.87);
%           
       %    nr_comp=2;
            
% %Christin well 6506-11-06
% system1 = SystemPrEos(273.15+164,330);
%         system1.addComponent('nitrogen', 0.343);
%         system1.addComponent('CO2', 3.691);
%         system1.addComponent('methane', 67.391);
%         system1.addComponent('ethane', 8.381);
%         system1.addComponent('propane', 4.527);
%         system1.addComponent('i-butane', 0.963);
%         system1.addComponent('n-butane', 1.811);
%         system1.addComponent('22-dim-C3', 0.012);
%         system1.addComponent('iC5', 0.752);
%         system1.addComponent('n-pentane', 0.838);
%           system1.addTBPfraction('C6', 1.166,85.4/1000.0,0.6647);
%           system1.addTBPfraction('C7', 1.685, 91.7/1000.0, 0.7346);
%           system1.addTBPfraction('C8', 1.677, 104.6/1000.0, 0.7651);
%           system1.addTBPfraction('C9', 1.07, 119.10/1000.0,0.7756);
%           system1.addTBPfraction('C10', 5.692, 231/1000.0,0.844);

%   system1.addComponent('methane',2)
%   system1.addComponent('n-butane',1)

%   system1.addComponent('ethane',0.9)
%   system1.addComponent('n-pentane',0.1)

 
%   system1.addComponent('methane',5)
%  system1.addComponent('n-heptane',1)

%   system1.addComponent('methane',8)
%  system1.addComponent('nC10',1)

%    system1.addComponent('methane',1)
%    system1.addComponent('propane',1)
%   
%  system1.addComponent('methane',0.5)
%   system1.addComponent('propane',1)

%     system1.addComponent('methane',0.717)
%     system1.addComponent('propane',0.209)
%     system1.addComponent('nC10',0.074)
%pablo CO2+ C10
%  system1.addComponent('CO2',0.95)
% system1.addComponent('nC10',0.05)

%   system1.addComponent('nitrogen',0.95)
%   system1.addComponent('nC10',0.05)
%  nr_comp=4;

% Exxsol + nitrogen
% system1.addComponent('nitrogen', 48)
% system1.addComponent('n-nonane', 0.1*1.2424)
% system1.addComponent('nC10', 0.1*20.1849)
% system1.addComponent('nC11', 0.1*41.9108)
% system1.addComponent('nC12', 0.1*28.9341)
% system1.addComponent('nC13', 0.1*7.7278)
% % 
% % 
%  nr_comp=6;

% system1 = SystemPrEos(360.93,96.53); %
% system1.addComponent('methane', 0.5)
% system1.addComponent('n-butane', 0.5)
%  nr_comp=2;
 
% system1 = SystemPrEos(344.3,100);
% system1.addComponent('CO2', 0.902)
% system1.addComponent('n-butane', 0.059)
% system1.addComponent('nC10', 0.039)

%Robert Amin et al 1997
%           system1 = SystemPrEos(355.37,220);
%         system1.addComponent('nitrogen', 0.14);
%         system1.addComponent('CO2', 2.35);
%         system1.addComponent('methane', 47.22);
%         system1.addComponent('ethane', 5.07);
%         system1.addComponent('propane', 2.96);
%         system1.addComponent('i-butane', 0.73);
%         system1.addComponent('n-butane', 0.99);
%         system1.addComponent('iC5', 0.65);
%         system1.addComponent('n-pentane', 0.50);
%         system1.addComponent('n-hexane', 1.24);
%           system1.addTBPfraction('C7', 1.39, 99/1000.0, 0.7476);
%           system1.addTBPfraction('C8', 1.89, 101/1000.0, 0.7803);
%           system1.addTBPfraction('C9', 2, 109/1000.0,0.8014);
%           system1.addTBPfraction('C10', 1.71, 126/1000.0,0.8005);
%           system1.addTBPfraction('C11', 31.16, 241/1000.0,0.8438);
        

%ormenlange oil 
%         system1 = SystemPrEos(25+273.15,120);
%         system1.addComponent('nitrogen', 0.35);
%         system1.addComponent('CO2', 0.26);
%         system1.addComponent('methane', 92.304);
%         system1.addComponent('ethane', 3.402);
%         system1.addComponent('propane', 1.278);
%         system1.addComponent('i-butane', 0.24);
%         system1.addComponent('n-butane', 0.34);
%         system1.addComponent('iC5', 0.14);
%         system1.addComponent('n-pentane', 0.15);
%         system1.addComponent('6305-01', 0.211);
%         system1.addComponent('6305-02', 0.429);
%         system1.addComponent('6305-03', 0.547);
%         system1.addComponent('6305-04', 0.278);
%         system1.addComponent('6305-05', 0.065);
%         system1.addComponent('6305-06', 0.005);

% system1 = SystemPrEos(313.15,201);
% system1.addComponent('methane', 0.8); %mole frac like feed
% system1.addComponent('n-butane',0.14);
% system1.addComponent('n-heptane',0.04);
% system1.addComponent('nC10',0.014);
% system1.addComponent('nC14',0.006);
% nr_comp=5;

%    testSystem.addTBPfraction("6305-01", 0.209, 86.18/1000.0, 0.664); //to creat new pseudocomponent: name, molenumber, mol mass/1000, density

%   Gasem, K. A. M. ; Dickson, K. B. ; Shaver, R. D. ; Robinson,  R. L. J.,
%   Experimental phase densities and interfacial tensions for a CO2 synthetic oil and a CO2 /reservior oil system. SPE Res.Eng. 1993, 170
% system1.addComponent('methane', 2.874)
% system1.addComponent('CO2', 91.681)
% system1.addComponent('ethane', 0.251)
% system1.addComponent('propane', 0.332)
% system1.addComponent('n-butane',0.515);
% system1.addComponent('n-pentane',0.344);
% system1.addComponent('n-hexane',0.272);
% system1.addComponent('n-heptane',0.412);
% system1.addComponent('n-octane',0.419);
% system1.addComponent('nC10',2.477);
% system1.addComponent('nC14',0.424)


testSystem.createDatabase(1);%0 mean keep database , 1 update kij from intertemp
testSystem.setMixingRule(2); %1 mean: all kij=0; 2= use kij value from database
testSystem.useVolumeCorrection(1) %Default value is "1" - use volume correction
testSystem.getInterphaseProperties().setInterfacialTensionModel(1); % GT == 1  Parac==0 LGT==2
testSystem.initPhysicalProperties();
 TPflash(testSystem,1); %how to close the report

%  mole_number_COMP0 = system1.getPhase(0).getComponent(0).getx()
%  system1.getPhase(1).getComponent(0).getx()
%  mole_number_COMP1 = system1.getPhase(0).getComponent(1).getx()
%  
% system1.getPhase(1).getComponent(1).getx()
%  mole_number_COMP2 = system1.getPhase(0).getComponent(2).getx()
%  system1.getPhase(1).getComponent(2).getx()
% pause
% 
% testOps = ThermodynamicOperations(system1);
% testOps.bubblePointPressureFlash(0) %"0 deravative"
% system1.getPressure()
% pause
% 
%  testOps = ThermodynamicOperations(system1);
% %        testOps.dewPointPressureFlash()
%       
% testOps.calcPTphaseEnvelope();
% bubT=testOps.getOperation.get('bubT');
% bubP=testOps.getOperation.get('bubP');
% dewT=testOps.getOperation.get('dewT');
% dewP=testOps.getOperation.get('dewP');
% testOps.displayResult();


testSystem.getInterphaseProperties().setInterfacialTensionModel(1); % GT == 1  Parac==0 LGT==2
testSystem.initPhysicalProperties();

% if (system1.getNumberOfPhases()>1)
%     for i=1:3
%       dens(i,1:500)  = system1.getInterphaseProperties().getSurfaceTensionModel(0).getMolarDensity(i-1);
% %       chemP(i,1:500)  = system1.getInterphaseProperties().getSurfaceTensionModel(0).getChemicalPotential(i-1);
%     end
 
% todo: this fails
    zsurf = (testSystem.getInterphaseProperties().getSurfaceTensionModel(0).getz()).*1e9;
    
   int_tension=1e3*testSystem.getInterphaseProperties().getSurfaceTension(0)%unit of interfacial tension mN\m

%     m=2;
%     n=2;
%     nr=1;
%     subplot(m,n,nr);
%     plot(dens2 , dens1); %density methane verus n-butane
%     xlabel('Mole Density of reference componet');
%     ylabel('Mole Density ');
%     hold on
%     nr=nr+1;
%     subplot(m,n,nr);
%     colordef white 
% for i=1:nr_comp
% plot(zsurf,  chemP(i,:),'color','r'); %interface thickness verus methane density
% hold on
% end
%     
%      xlabel('Interface thickness [nm]');
%      % xlabel('interface thickness [nm]','fontsize',12,'fontweight','b');
% %     ylabel('Chemical potential [J/mol]'); 
%      ylabel('Mole Density [mol/m3]'); 
        
%       plot(zsurf,dens(1,:),'g','LineWidth',2);%interface thickness verus butane density
%        hold on
% %    plot(zsurf,dens(2,:),'r','LineWidth',2);%interface thickness verus butane density
% %      hold on 
% %       plot(zsurf,dens(3,:),'k','LineWidth',2);%interface thickness verus butane density
% %       hold on 
%          plot(zsurf,dens(4,:),'m','LineWidth',2);%interface thickness verus butane density
%          hold on 
%     legend('Nitrogen','n-C14'); 
%      ylabel('Mole Density [mol/m3]','fontsize',16,'fontweight','b');
%     xlabel('Interface thickness [nm]','fontsize',16,'fontweight','b');    
%     plot(zsurf,chemP(1,:),'k')
%     hold on
%     plot(zsurf,chemP(2,:),'m')
%     hold on
%     plot(zsurf,chemP(3,:),'b')
%     hold on
%     plot(zsurf,chemP(4,:),'--g');%interface thickness verus butane density
%     hold on
%     plot(zsurf,chemP(5,:),'--k')
%     hold on
%     plot(zsurf,dens8,'--m')
%     hold on
%     plot(zsurf,dens9,'--b')
%     hold on
%     plot(zsurf,dens10,'g');%interface thickness verus butane density
%     hold on
%     plot(zsurf,dens11,'k')
%     hold on
%     plot(zsurf,dens12,'m')
%     hold on
%     plot(zsurf,dens13,'b')
%     hold on
%     plot(zsurf,dens14,'b')
%     hold on
%     plot(zsurf,dens15,'b')
%     hold on
%     legend('methane','n-butane','n-heptane','n-decane','n-C14'); 
%     title('Chemical potential profiles through the interface for CH4/Hydrocarbon mixture at 313.15 K and 142Bar: interfacial tension = 1.75mN/m');

%     title('Density profiles through the interface for CH4/Hydrocarbon mixture at 313.15 K and 142Bar: interfacial tension = 1.83mN/m');

    
    
   %output the composition,volume and density into data_check.txt
%    
%    dens=dens';
%    
%    dlmwrite('Interface Density.txt', dens, 'delimiter', '\t', ...
%          'precision', 6);
%      
%      dlmwrite('Interface Thickness.txt', zsurf, 'delimiter', '\t', ...
%          'precision', 6);
     
     

%     fid = fopen('data_check.txt', 'wt');fprintf(fid, 'X= ');fprintf(fid, '%6.4f %6.4f\n',system1.getPhase(1).getComponent(0).getx(),system1.getPhase(1).getComponent(1).getx());
%     fprintf(fid, 'Y= ');fprintf(fid, '%6.4f %6.4f\n',system1.getPhase(0).getComponent(0).getx(),system1.getPhase(0).getComponent(1).getx());
%     for i=1:2
%     fprintf(fid,'Mole Density in vapor phase =  '); fprintf(fid, '%6.3f\n', 1e5*system1.getPhase(0).getComponent(i-1).getx()/system1.getPhase(0).getMolarVolume());
%     end
% 
%      fprintf(fid,'Interface tension [mN/m]=  '); fprintf(fid, '%6.3f\n', system1.getPhase(0).getDensity());
% 
% %     for n= 1:500
% %     fprintf(fid, '%3i\t', n);fprintf(fid,'Den_int 1 =  ');fprintf(fid, '%6.3f\t',  dens1(n));
% %     fprintf(fid,'Den_int 2  =  ');fprintf(fid, '%6.3f\t',  dens2(n));
% %     fprintf(fid,'Den_int3  =  ');fprintf(fid, '%6.3f\n',  dens3(n));
% %     end
%     for i=1:2
%     fprintf(fid,'Mole Density in  liquid phase =  '); fprintf(fid, '%6.3f\n', 1e5*system1.getPhase(1).getComponent(i-1).getx()/system1.getPhase(1).getMolarVolume());
%     end
%     fclose(fid);

% else 
%     disp('only one phase'); 
% end

% pressure_ini=86; %plot pressure verus interfacial tension
% for i=1:14
%     pressure_gt(i)=pressure_ini + i*1;
%     system1.setPressure(pressure_gt(i));
%     system1.init;
%     TPflash(system1,0);
%     if (system1.getNumberOfPhases()>1)
%     system1.initPhysicalProperties();
%     int_tension_gt(i)=1e3*system1.getInterphaseProperties().getSurfaceTension(0)%unit of interfacial tension mN\m  
% else 
%     disp('only one phase'); 
%     j=i;
% end
% end
% % 
% % 
%  plot(pressure(j+1:i),int_tension(j+1:i),'g');
%  hold on
%  
%  fid = fopen('data_IFT_ORMENLANGE_273k.dat', 'wt');
%  for n=1:56
%  fprintf(fid, '%6.3f\t',pressure(n));
%  fprintf(fid, '%6.3f\n',int_tension(n));
%  end
%  fclose(fid)
% %system1
%     


% temp=[60.71;67.98;73.33;79.36;85.56;91.91;98.41;105.04;111.76;118.52;125.26;131.88; 138.24;
%     145.2;151.36;153.87;154.08;153.72;151.73;148.55;144.34;135.93;121.07;102.49;94.83;87.81;
%     70.91;52.08;35.09;26.85;22.85;20;18.85;14.85;10.85;6.85;6.72;2.85];
% 
% pre=[5;6.21;7.23;8.56;10.13;11.99;14.18;16.78;19.86;23.5;27.81;32.91;38.95;47.66;59.75;
% 70.64;74.76;80.06;87.95;94.41;100.01;107.17;114.15;117.63;117.91;117.69;115.46;110.44;
% 103.79;99.87;97.81;96.29;95.65;93.39;91.04;88.58;88.5;86.04];
% 
% ift=[11.29;10.41;9.77;9.04;8.29;7.53;6.76;5.98;5.19;4.41;3.64;2.89;2.18;1.41;0.69;
% 0.3;0.21;0.12;0.04;0.01;0.0062;0.02;0.14;0.45;0.62;0.8;1.31;2;2.7;3.11;3.3;3.44;
% 3.5;3.7;3.9;4.11;4.12;4.32];
% 
% plot3(temp,pre,ift)
% grid on
% hold on
% scatter3(X,Y,Z)
% plot(pre,ift,'r')
% plot(temp,ift)
% scatter3(temp,pre,ift)
% hold on 
% plot(temp,pre)
% hold on
% plot3(temp,pre,ift)
% scatter3(X,Y,Z)
% stem3(X,Y,Z)
















