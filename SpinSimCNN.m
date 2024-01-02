%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   CNN benchmarking for spintronic devices
%   Title:      SpinSimCNN.m
%   Author:     Chenyun Pan
%   Last modified: 1/15/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bey = SpinSimCNN(bey,cop)
    r0 = 20e3; c0 = 30e-18; vread = .5;         % CMOS data
    Rg = 50; Rmtj = 4e6; 
    wmax = .23; activity = 0.1; wavg = 0.63;    % from Hebbian learning
    t0 = 35; Ns = 40;                           % relative delay and number of synapses from numerical simulation
        
    if strcmp(cop.name(1:3),'ASL')
        cop.Rwiring = Rg;
        [tmag,~,i0,~,beta,is] = analytics_ASL(bey.volt/8,10*cop.F,cop); drive = is/i0; wcmos = 800;
        if strcmp(cop.name,'ASL'); wcmos = 800; end
        if strcmp(cop.name,'ASL-PMA'); wcmos = 500; end
        if strcmp(cop.name,'ASL-HA'); wcmos = 300; end
        if strcmp(cop.name,'ASL-HAs'); wcmos = 100; end
        tcnn = tmag*t0*1e-9;
        Is = wmax*drive*i0; Ic = Is/beta;   % spin->charge beta
        Em = Ic.^2.*(r0/wcmos+Rg).*tcnn;    % energy per synapse
    end
    if strcmp(cop.name(1:3),'CSL') || strcmp(cop.name,'mLogic')
        if strcmp(cop.name,'mLogic')
            rhoDW = 7.5e-8; ldw = 10*cop.F; Wdw = 30e-9; tdw = 2e-9;
            Rdw = rhoDW*ldw/tdw/Wdw; r = Rg+Rdw;
            Jdw = bey.volt/15/r/tdw/Wdw/1e4;
            if Jdw>2.5e6 && Jdw<5e6; cdw = 10*Jdw*1e-6-25;
            elseif Jdw>=5e6 && Jdw<20e6; cdw = 5*Jdw*1e-6;
            elseif Jdw>20e6; cdw = 3*Jdw*1e-6+40;
            else cdw = 0;
            end
            tmag = 5*cop.F/cdw*1e9; 
            tcnn = tmag*t0/2*1e-9;
            drive = Jdw/5e6; 
            Inet = drive*5e6*Wdw*tdw*1e4;
        else
            wSH = 4*cop.F; thSH = 2e-9; lSH = 10*cop.F; lmag = cop.F; 
            RSHE = cop.rhoSH*lSH/wSH/thSH; r = Rg+RSHE;
            [tmag,~,i0,~,beta,CC,is] = analytics_CSL(bey.volt*10,10*cop.F,cop); drive = is/i0;
            tcnn = tmag*t0*1e-9;
            Is = drive*i0; Inet = Is/beta*thSH/lmag/CC;    % %%%%
        end
        on_off = 2; Rs_Ro = 5;              % max resistance diff determined by TMR, minimum synapse/output res ratio assumed to be 5
        vdd = Inet*wmax*Rs_Ro*r;           % required driving voltage
        Rdrive = 100; wcmos = r0/Rdrive;    % driving transistor size
        Em = (wavg+wmax/on_off)*vdd*Inet*tcnn;  % energy per synapse
    end
    Emtj = vread.^2/Rmtj.*tcnn;
    Esynap = Em*Ns*2; 
    Ecmos = .5*(vread*2).^2*wcmos*c0*activity*Ns*2; % no Nb
    Ecnn = Esynap+Emtj+Ecmos;
    bey.tcnn = tcnn; bey.Ecnn = Ecnn;

    
end























