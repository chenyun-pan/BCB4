function bey = GpnJDevPerf(bey,cop)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function bey = GpnJDevPerf(bey,cop)
% Obtain performance of simple circuits with graphene pn-junction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Title:      GpnJDevPerf.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%   Author:     Dmitri E Nikonov
%   Date:       04/06/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lengate = 2*cop.F;
Rcon = cop.Rcont/bey.wTran; R0 = bey.volt/(bey.Ionle*bey.wTran); 
Rdev = Rcon+R0;
Rleak = bey.volt/(bey.Iofle*bey.wTran);
% only the gates in the middle and on the sides are switched
bey.Cdev = cop.Cgale*cop.parasitC*bey.wTran + cop.Cgaar*bey.wTran*lengate;
bey.Craw = cop.Cgaar*lengate*1e9;
bey.Ionle = bey.volt/Rdev/bey.wTran;            % on current per length, A/m
bey.Iofle = bey.volt/Rleak/bey.wTran;           % off current, A
bey.Iofle = cop.Jg*cop.Lch + bey.Iofle;
bey.tint = bey.Cdev*Rdev;                       % intrinsic device delay, s 
bey.Eint = bey.Cdev*bey.volt^2;                 % device energy, J
bey.Idev = bey.volt./Rdev;                      % device current, A
end
