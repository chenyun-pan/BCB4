%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Intrinsic delay and energy for mLogic device
%   Title:      mLogicDevPerf.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bey = mLogicDevPerf(bey,cop)

lmax = 10e-6;
[td, energy] = analytics_mLogic(bey.volt,cop.lic,cop);
td2 = analytics_mLogic(bey.volt,lmax,cop);
bey.tint = td/2/1e9;
bey.Eint = energy/2/1e15;
Ile1 = cop.Jg*cop.Lch+cop.Ileak;
Ile = Ile1*bey.volt/cop.vTran;
Sint = Ile*bey.wTran*bey.volt;
bey.Sint = Sint;
% electrical interconnects
bey.tic = (td2-td)/(lmax-cop.licsp)*cop.licsp/1e9;
bey.Eic = cop.facEcap*cop.Cic*bey.volt^2;

end


