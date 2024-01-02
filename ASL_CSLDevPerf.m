%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Intrinsic delay and energy for ASL and CSL devices
%   Title:      ASL_CSLDevPerf.m
%   Author:     Chenyun Pan
%   Last modified: 1/15/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bey = ASL_CSLDevPerf(bey,cop)
fundcon
switch cop.name(1:3)
    case 'ASL'
        [td, energy] = analytics_ASL(bey.volt,4*cop.F,cop);
        [td1, energy1] = analytics_ASL(bey.volt,cop.licsp,cop);
		bey.tint = td/1e9; bey.Eint = energy/1e15;    
        bey.tic = td1/1e9;      % interconnect delay
        bey.Eic = energy1/1e15;
    case 'CSL'
		lmax = 10e-6;   % max length w/o repeaters
        [td, energy] = analytics_CSL(bey.volt,4*cop.F,cop);
		[td1, energy1] = analytics_CSL(bey.volt,lmax,cop);
		bey.tint = td/1e9; bey.Eint = energy/1e15;
		bey.tic = (td1-td)/(lmax-cop.licsp)*cop.licsp/1e9;              % interconnect delay, s
		bey.Eic = cop.facEcap*cop.Cic*bey.volt^2;                       % interconnect energy, J
        bey.Eic = bey.Eic+(energy1-energy)/(lmax-4*cop.F)*4*cop.F/1e15;
end
bey.Sic = bey.Sint;                         % leakage power, W
end
