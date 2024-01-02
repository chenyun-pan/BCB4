%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% spin torque parameters for perpendicular magnetization
%   Title:      perpMag.m
%   Author:     Dmitri E Nikonov
%   Date:       04/06/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aspect = 1;
area = aspect*bey.wMagn*bey.wMagn;
vol = area*cop.thFM;
Delta = cop.Ku*vol/kbT;                     % stability factor
Ns = cop.Mspe*vol/muB;
% critical current density for perpendicular anisotropy,  A/m^2
Jc = 2*eelec*cop.alpha*cop.Ku*cop.thFM/hbar/cop.sppol;
Icle = Jc*bey.wMagn;                        % critical current per length, A/m
Ic = Jc*area;                               % critical current, A
factcur = 3;                                % switching current is 3x critical current
bey.Ionle = factcur*Icle;                   % on current, A/m, 
Ion = factcur*Ic;                           % current per input, A
theta = sqrt(0.5./Delta);                   % thermal angle
timfact = 3*log(pi./2./theta);                % time factor
tstt = timfact*eelec*cop.Mspe*vol/cop.gLande/muB/cop.sppol/(Ion-Ic);
Rcurr = 0;                                  % start calculating resistance in the current path
rescaleTorqueVolt
Ile1 = cop.Jg*cop.Lch+cop.Ileak;
Ile = Ile1*bey.volt/cop.vTran;
Sint = Ile*bey.wTran*bey.volt;