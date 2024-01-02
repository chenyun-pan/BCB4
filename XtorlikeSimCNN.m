%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% CNN benchmarking for Charge-based FETs
% Title:      XtorlikeSimCNN.m
% Author:     Chenyun Pan
% Last modified: 1/15/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function bey = XtorlikeSimCNN(bey,cop)
    F = cop.F; E0 = 1; wmax = .23; wsum = 1.26;     % from Hebbian learning
% % parameters from numerical simulation    
    Nb = 4; Ns = 40;            % number of bits and synapses
    tref = 8.4e-9;              % reference analog CNN delay @ Rf*Cf = 1e-9, 
    tstep = 3;                  % number of steps for digital CNN
    ion = bey.Ionle; ioff = bey.Iofle;      % device on and off current
    vdd = bey.volt; c0 = bey.Cdev/4;        % device vdd and cap
    win = 10*F; wup = 5*F; wout = 10*F;     % input, pull-up, output transistor width
    vsat = min([vdd .3]);       % saturation voltage for calculating SS
    cOTA = c0*2*wout/F;         % OTA output capacitance
    SS = vsat/log10(ion/ioff)*1e3;   % SS (V) remains the same as bias current increases for larger weights
    ib = sqrt(ion*ioff)*win;   % assume geo mean of ion and ioff (for minimum weight) 
    if bey.SS > 0; SS = bey.SS; ib = bey.ib*win; end    % inputs from LEAST
    gm = ib*log(10)/SS/1e-3*wout/wup;       % transconductance of the OTA
    Gm = E0/(wmax/2)*gm;        % sum Gm of input OTA
    Rs = 1/Gm*2; Rf = 2*Rs;     % 2X overhead due to nonlinearity of OTA, 2X Rf for output stability
    Cf = Nb*cOTA*Ns*2;          % summation of all OTA capacitance
    tCNN = Rf*Cf/1e-9;          % relative CNN delay to the reference delay
    td = tref*tCNN;
    iOTA = (2+2*wout/wup)*ib*wsum/(wmax/2);          % OTA bias current @ MSB ~ wmax/2
    iamp = vdd/Rf;              % amplifier bias current
    power = vdd*(iamp+iOTA);    % total power
    energy = power*td;          % total energy
    bey.tcnn = td; bey.Ecnn = energy;
    
    switch cop.name             % NA for NDR
        case {'BisFET','ITFET'}
            bey.tcnn = Inf; bey.Ecnn = Inf;
    end
    Ecnn_dig = (bey.Ese+bey.Enan+bey.Einv1+bey.Ese)*Nb+(bey.E1+bey.Ese)*(Nb+ceil(log2(Ns)));     % energy per synpase: weight,nand,inv,reg | adder,reg | state
    Ecnn_dig = (Ecnn_dig*Ns*2+bey.Ese)*tstep;           % 2Ns number of synapses + 1-bit state
    tcnn_dig = tstep*(bey.tse+bey.tnan+bey.tinv1+(bey.tse+bey.t1*(Nb+ceil(log2(Ns))))*(Ns*2+1)+bey.tse);    % delay: weight,nand,inv,reg | adder,reg | state

    bey.Ecnn_dig = Ecnn_dig; bey.tcnn_dig = tcnn_dig;

end















