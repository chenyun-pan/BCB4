%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Title:      NRIrev7.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%   Author:     Dmitri E Nikonov
%   Date:       01/01/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear
cop.ver = '2015';
% nomenclature
caey = {
    'CMOS HP'; ...  
    'CMOS LV'; ...  
    'HomJTFET'; ... % LEAST
    'HetJTFET'; ... % LEAST
    'ThinTFET'; ... % LEAST
    'GaNTFET'; ...  % LEAST
    'TMDTFET'; ...  % LEAST
    'FEFET'; ...    % BCB3.0
    'NCFET'; ...    % LEAST
    'MITFET'; ...   % FAME
    'ITFET'; ...    % SWAN
    'BisFET'; ...   % SWAN
    'GpnJ-Vg2'; ... % INDEX
    'GpnJ-Vg3'; ... % INDEX
    'vdWFET-BP';... % FAME
    'ASL'; ...      % Datta spin current
    'ASL-PMA'; ... 	
    'ASL-HA'; ...	% CSPIN
    'ASL-HAs'; ...	% CSPIN
    'CSL'; ...      % Datta spin Hall
    'CSL-CC'; ...   
    'CSL-New'; ...  
    'CSL-YIG'; ...  
    'MEMTJ'; ...    
    'MEMTJs';...        
    'MEMTJ-Pres';...    
    'mLogic'; ...       % CMU Domain Wall Logic
    'SWD'; ...          % Naeemi
    'CoMET';...         % Sapatnekar
%     'MEMTJ-Sep';...   
%     'MEMTJ-Pre';...   
%     'vdWFET-WS2';...
%     'CMOS14nm'; ...  
%     'vdWFET  '; ...   % archived
%     'gnrTFET '; ...   % archived
%     'PiezoFET'; ...   % archived
%     'ExFET   '; ...   % archived
%     'SpinFET '; ...     % Sugahara-Tanaka
%     'STT/DW  '; ...     % Ross, aka MTJ logic switch; also CMU mLogic
%     'SMG     '; ...     % Nikonov
%     'STOlogic'; ...     % Krivorotov, aka Spin Torque Majority Logic
%     'NML     '; ...     % Porod and Niemier
%     'MESO'          % Sasikanth Manipatruni
    };
% caey = cellstr(aey);    %cell array of names
saey = cell2struct(caey,'name',2);  % cell array to structure
ndev = size(caey,1);
if(~isfield(cop,'spindriv'))
% current or voltage driven magnetization switching
%cop.spindriv = 'current';
cop.spindriv = 'voltage';
% mechanism for current switching for SMG, STTtriad, STO, and ADL
%cop.sptortype = 'STTinp';
cop.sptortype = 'STToop';
%cop.sptortype = 'precess'
%cop.sptortype = 'SHE'
% Note: NML and SWD have specific current switching: Oersted field, not
% spin torque. STT/DW is siwtched by domain wall motion with current along
% the ferromagnetic wire. CSL is switched by spin Hall effect.
% mechanism for voltage switching
cop.mageltype = 'magnetostrictive';
%cop.mageltype = 'multiferroic';
%cop.mageltype = 'magnetoelectric';
%cop.mageltype = 'surfanisotropy';
end
% Voltage initialized depending on current or voltage driven magnetization
% switching
cop.vspinST = 0.01;                     % spin torque voltage
cop.vspinME = 0.1;                      % magnetoelectric voltage
switch cop.spindriv
    case 'current'
        vspin = cop.vspinST;
    case 'voltage'
        vspin = cop.vspinME;
end
bey(1:ndev,1) = struct(...
    'aint',0,'tint',0,'Eint',0,'aic',0,'tic',0,'Eic',0,...              % intrinsic device / short interconnect
    'ainv4',0,'tinv4',0,'Einv4',0,'anan',0,'tnan',0,'Enan',0,...        % FO4 inverter / NAND2
    'a1',0,'t1',0,'E1',0,'aadd',0,'tadd',0,'Eadd',0,...                 % 1-bit adder / 32-bit adder
    'ainv1',0,'tinv1',0,'Einv1',0,'axor',0,'txor',0,'Exor',0,...        % FO1 inverter / XOR
    'anan3',0,'tnan3',0,'Enan3',0,'anan4',0,'tnan4',0,'Enan4',0,...     % NAND3 / NAND4
    'amux',0,'tmux',0,'Emux',0,'adem',0,'tdem',0,'Edem',0,...           % MUX / DEMUX 1:4
    'ase',0,'tse',0,'Ese',0,'aram',0,'tram',0,'Eram',0,...              % state elelment / RAM
    'aao',0,'tao',0,'Eao',0,'aalu',0,'talu',0,'Ealu',0,...              % arithmetic operation / arithmetic logic unit
    'Sint',0,'Sic',0,'Sinv4',0,'Snan',0,'S1',0,'Sadd',0,...             % Standby powers for all devices
    'Sinv1',0,'Sxor',0,'Snan3',0,'Snan4',0,'Smux',0,'Sdem',0,...        
    'Sse',0,'Sram',0,'Sao',0,'Salu',0,...
    'volt',vspin,'width',0,'length',0,'Ionle',0,'Iofle',0,'Cadj',1,'Cdev',0,...
    'wTran',4,'mgates',3,'Qeff',0,'Idev',0,'Reff',0,'Ceff',0,...
    'invlen',2,'invwid',5,'nandlen',3,'nandwid',6,'majcrit',1,'wMagn',0,...
    'twire',0,'Ewire',0,'domino',1,'ainv2',0,'tinv2',0,'Einv2',0,'Sinv2',0,...
    'Nspan',0,'tcnn',0,'Ecnn',0,'tFC',0,'EFC',0,'SS',0,'ib',0,'tcnn_dig',0,'Ecnn_dig',0,...
    'Iraw',0,'Craw',0,'temp1',0,'temp2',0);
for k=1:ndev
    switch saey(k).name     % these can only be spin torque      
        case {'STT/DW','STOlogic','ASL'}
            bey(k).volt = cop.vspinST;
    end
end
materialParameters
beyondInputs7
 for k=1:ndev
    cop.name = saey(k).name;
    n = cop.name;
    switch saey(k).name
% Charge-based FETs
        case {'CMOS HP','CMOS LV','vdWFET','vdWFET-BP','vdWFET-WS2','HomJTFET','HetJTFET','gnrTFET',...
                'ITFET','ThinTFET','GaNTFET','TMDTFET','BisFET','ExFET','CMOS14nm'}
            bey(k) = XtorlikeArea(bey(k),cop);
            bey(k) = XtorlikeDevPerf(bey(k),cop);
            bey(k) = XtorlikeSimCirc(bey(k),cop);
            bey(k) = XtorlikeSimInt(bey(k),cop);
            bey(k) = XtorlikeSimCNN(bey(k),cop);
        case {'SpinFET'}
            bey(k) = XtorlikeArea(bey(k),cop);
            bey(k) = XtorlikeDevPerf(bey(k),cop);
            bey(k) = XtorlikeSimInt(bey(k),cop);
            bey(k) = XtorlikeSimCirc(bey(k),cop);
            bey(k) = NVmemory(bey(k),cop);
        case {'NCFET','PiezoFET'}
            bey(k) = XtorlikeArea(bey(k),cop);
            bey(k) = XtorlikeDevPerf(bey(k),cop);
%             bey(k).tint = bey(k).tint + cop.tPZint;           % add ferroelectric material resoponse time
            bey(k) = XtorlikeSimCirc(bey(k),cop);
            bey(k) = XtorlikeSimInt(bey(k),cop);
            bey(k) = XtorlikeSimCNN(bey(k),cop);
        case {'MITFET','FEFET'} % non-volatile transistors
            bey(k) = XtorlikeArea(bey(k),cop);
            bey(k) = FerroelDevPerf(bey(k),cop);
            bey(k) = XtorlikeSimCirc(bey(k),cop);
            bey(k) = XtorlikeSimInt(bey(k),cop);
            bey(k) = XtorlikeSimCNN(bey(k),cop);
        case {'GpnJ-Vg2','GpnJ-Vg3'}
            bey(k) = XtorlikeArea(bey(k),cop);
            bey(k) = GpnJDevPerf(bey(k),cop);  
            bey(k) = XtorlikeSimCirc(bey(k),cop);
            bey(k) = XtorlikeSimInt(bey(k),cop);
            bey(k) = XtorlikeSimCNN(bey(k),cop);
% % % % % spintronics
        case {'ASL','CSL','ASL-PMA','ASL-HA','ASL-HAs','CSL-CC','CSL-New','CSL-YIG'}
            bey(k) = MajGateArea(bey(k),cop);
%             bey(k) = ASLDevPerf(bey(k),cop);
            bey(k) = ASL_CSLDevPerf(bey(k),cop);
            bey(k) = MajGateSimCirc(bey(k),cop);
            bey(k) = SpinSimInt(bey(k),cop);
            bey(k) = SpinSimCNN(bey(k),cop);
        case 'SWD'          % Khitun
            bey(k) = MajGateArea(bey(k),cop);
            bey(k) = SWDDevPerf(bey(k),cop);
            bey(k) = MajGateSimCirc(bey(k),cop);
            bey(k) = SpinSimInt(bey(k),cop);
        case 'mLogic'       % CMU
            bey(k) = XtorlikeArea(bey(k),cop);
            bey(k) = mLogicDevPerf(bey(k),cop);  
            bey(k) = XtorlikeSimCirc(bey(k),cop);
            bey(k) = SpinSimInt(bey(k),cop);
            bey(k) = SpinSimCNN(bey(k),cop);
        case {'MEMTJ','MEMTJ-Sep','MEMTJ-Pre','MEMTJs','MEMTJ-Pres'}
            bey(k) = MajGateArea(bey(k),cop);
            bey(k) = MEMTJDevPerf(bey(k),cop);
            bey(k) = MajGateSimCirc(bey(k),cop);  
            bey(k) = SpinSimInt(bey(k),cop);
        case {'CoMET'}       % CSPIN
            bey(k) = MajGateArea(bey(k),cop);
            bey(k) = CoMETDevPerf(bey(k),cop);
            bey(k) = MajGateSimCirc(bey(k),cop);
            bey(k) = SpinSimInt(bey(k),cop);
        case 'NML'          % Porod and Niemier
            bey(k) = MajGateArea(bey(k),cop);
            bey(k) = NMLDevPerf(bey(k),cop);
            bey(k) = MajGateSimCirc(bey(k),cop);
        case 'STT/DW'       % Ross, aka MTJ logic switch; also CMU mLogic
            bey(k) = XtorlikeArea(bey(k),cop);
            bey(k) = STTDWPerf(bey(k),cop);
            bey(k) = XtorlikeSimCirc(bey(k),cop);    
            bey(k) = SpinSimInt(bey(k),cop);
        case 'SMG'         % Nikonov
            bey(k) = MajGateArea(bey(k),cop);
            bey(k) = SMGDevPerf(bey(k),cop);
            bey(k) = MajGateSimCirc(bey(k),cop);
        case 'STOlogic'     % Krivorotov, aka Spin Torque Majority Logic
            cop.majsize = 2;                    % adjustment to majority gate size
            bey(k) = MajGateArea(bey(k),cop);
            bey(k) = STODevPerf(bey(k),cop);
            bey(k) = MajGateSimCirc(bey(k),cop);
            cop.majsize = 1;                    % adjustment to majority gate size
        case 'MESO'         % Nikonov
            bey(k) = MajGateArea(bey(k),cop);
            bey(k) = MESODevPerf(bey(k),cop);
            bey(k) = MajGateSimCirc(bey(k),cop);
    end
    bey(k) = adder1toMany(bey(k),cop);
    bey(k) = alu(bey(k),cop);
    bey(k).Qeff = bey(k).Eint./bey(k).volt;
    bey(k).Reff = bey(k).volt./bey(k).Idev;
    bey(k).Ceff = bey(k).Qeff./bey(k).volt;
end
cey = struct2cell(bey);     % cell array of numbers
mey = cell2mat(cey);        % simple array of numbers
dn = caey;




















