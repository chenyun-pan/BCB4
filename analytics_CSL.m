%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Analytical approach for CSL device delay and energy
% Title:      analytics_CSL.m
% Author:     Chenyun Pan
% Last modified: 1/15/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [tint, energy, Ics, Delta, SHEC, CC, Is] = analytics_CSL(volt,lw,cop)
fundcon
aspect = 3; wMagn = 15e-9; 
rr = 1;     % overhead of using copper collector
CC = 1;     % spin injection enhancement
if strcmp(cop.name,'CSL-CC')
    CC = 2;
end
if strcmp(cop.name,'CSL-New')
    rr = 2; aspect = 2; CC = 2; cop.SHEC = .5;
end
if strcmp(cop.name,'CSL-YIG')  % extra CC w/o shunting current
    rr = 2; aspect = 2; CC = 3; cop.SHEC = .5;
end
SHEC = cop.SHEC;
area = aspect*wMagn*wMagn;
vol = area*cop.thFM;
area_MTJ = wMagn*wMagn;
% spin Hall effect parameters for perpendicular magnetization
[Nxx,Nyy,~] = demagnetiz(aspect*wMagn,wMagn,cop.thFM,'cuboid');
deltaN = Nyy-Nxx;                    % difference of demagnetization factors                                  
Kmag = mu0*cop.Msat^2/2;             % magnetic energy, J/m^3
Delta = deltaN*Kmag*vol/kbT;         % stability factorNs = cop.Mspe*vol/muB;                      % number of spins
% critical SPIN current density for perpendicular anisotropy,  A/m^2
Jc = 2*eelec*cop.alpha*Kmag*cop.thFM/hbar;
Ics = Jc*area;                              % critical current, A
theta = sqrt(0.5./Delta);                   % thermal angle
timfact = 3*log(pi./2./theta);              % time factor
RSH = rr*cop.rhoSH*((aspect+2)*wMagn)/(wMagn*cop.thSH);                 % resistance of the spin Hall wire, Ohm
Rjunc = cop.RAspinvalve/area_MTJ;
Rp = Rjunc; Rap = (1+cop.TMR)*Rp; rw = 3e7;
Rp = Rp+cop.Rwiring/2; Rap = Rap+cop.Rwiring/2;
G1 = 1/Rp; G2 = 1/Rap; RL = RSH+cop.Rwiring/2+lw*rw;
Icharge = volt/2*(G1-G2)./(1+RL*(G1+G2));
if nargin > 5; Icharge = volt/cop.Rwiring; end
Is = Icharge*cop.SHEC*wMagn/cop.thSH;
Is = Is*CC;
tstt = timfact*eelec*cop.Msat*vol/cop.gLande/muB/(Is-Ics);
if Is-Ics < 0; tstt = Inf; end
tint = tstt;
vmid = Icharge*RL;
I1 = (volt/2-vmid)*G1;
I2 = (vmid+volt/2)*G2;
Ewire = .5*lw*cop.Cicle*(2*vmid)^2*1e15;
energy = (I1^2*Rp+I2^2*Rap+Icharge^2*RL)*tint*1e15+Ewire;
tint = tint*1e9;




