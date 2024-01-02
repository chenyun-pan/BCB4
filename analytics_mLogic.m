%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Intrinsic delay and energy for mLogic device
%   Title:      analytics_mLogic.m
%   Author:     Chenyun Pan
%   Date:       1/15/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [tinv, Einv] = analytics_mLogic(volt,lw,cop)
wMagn = cop.F; tdw = 2e-9;
area_MTJ = wMagn*wMagn;
Isc = 2.5e6*1e4*wMagn*tdw;
Rjunc = cop.RAspinvalve/area_MTJ;
Rp = Rjunc; Rap = (1+cop.TMR)*Rp;
Rt = cop.Rwiring/2; Rg = cop.Rwiring/2;
Rp = Rp+Rt; Rap = Rap+Rg;
rho = 7.5e-8; w = wMagn; l = 3*4*cop.F;
Rdw = rho*l/tdw/w;
rw = cop.rho/2/cop.F/4/cop.F;
RL = Rg+lw*rw+2*Rdw;
A = wMagn*tdw;
G1 = 1/Rp; G2 = 1/Rap; 
Idev = volt/2*(G1-G2)./(1+RL*(G1+G2));
Jdw = Idev/A/1e4;
if Jdw>2.5e6 && Jdw<5e6; cdw = 10*Jdw*1e-6-25;
elseif Jdw>=5e6 && Jdw<20e6; cdw = 5*Jdw*1e-6;
elseif Jdw>20e6; cdw = 3*Jdw*1e-6+40;
else cdw = 0;
end
Rtemp = Rp*Rap/(Rp+Rap);
R = Rtemp*RL/(Rtemp+RL);
trc_wire = R*lw*cop.Cicle;

tint = 2*4*cop.F./cdw+trc_wire;
vmid = Idev*RL;
Ewire = .5*lw*cop.Cicle*(2*vmid)^2;
I1 = (volt/2-vmid)*G1;
I2 = (vmid+volt/2)*G2;
energy = (I1^2/G1+I2^2/G2+Idev^2*RL)*tint+Ewire;
tinv = tint*1e9; Einv = energy*1e15;








