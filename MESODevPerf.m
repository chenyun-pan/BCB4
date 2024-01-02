function bey = MESODevPerf(bey,cop)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function bey = SMGDevPerf(bey,cop)
% Obtain performance of magneto-electric spin-orbital devices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Title:      MESODevPerf.m
%   Author:     Dmitri E Nikonov
%   Date:       03/20/2015
%   (C) Dmitri E. Nikonov 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fundcon
cop.liccu = cop.licsp;                      % unit is the spin interconnect unit
switch cop.spindriv
    case 'current'
    case 'voltage'
magnetoElectric
inverseRashba
bey.Idev = Irash;
bey.tint = tcomb;                           % intrinsic device delay, s
bey.Eint = Edriv;                           % device energy, J
bey.Sint = Sint;                            % leakage power, W
end
% electrical interconnects
bey.tic = cop.factic*cop.Cic*bey.volt/bey.Idev;         % interconnect delay, s
bey.Eic = cop.facEcap*cop.Cic*bey.volt^2;               % interconnect energy, J
end
