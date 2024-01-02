%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Intrinsic delay and energy for CoMET device
%   Title:      CoMETDevPerf.m
%   Author:     Chenyun Pan
%   Date:       1/15/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bey = CoMETDevPerf(bey,cop)
vdd = .15;
Ron = cop.Rtranlin/4/cop.F;
wSHM = 15e-9;
tSHM = 1e-9;
vfe = .15;
cg = cop.Ctole*cop.F*4;
vrst = vfe+.2;
vprop = vrst;
vout = 2*vdd;
Jc = 5e11;
RSHM = 424;
tnucleate = 30e-12;
tpropagate = 38.7e-12;
ttransfer = 8.2e-12;
bey.tint = (tnucleate + tpropagate + ttransfer)*2;
Ejoule = (Jc*wSHM*tSHM)^2*(Ron+RSHM)*tpropagate;
Eleak = 22.8e-18;
ETX = cg/2*(4*vrst^2+vprop^2+2*(vout)^2);
bey.Eint = (ETX+Ejoule+Eleak)*2;
bey.volt = vdd*2;       % +-Vfe
Rtran = 5e3;
bey.tic = cop.factic*cop.Cic*Rtran;
bey.Eic = cop.facEcap*cop.Cic*bey.volt^2;
end