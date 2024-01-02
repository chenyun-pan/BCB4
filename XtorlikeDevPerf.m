function bey = XtorlikeDevPerf(bey,cop)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function bey = XtorlikeDevPerf(bey,cop)
% Obtain intrinsic device characteristics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Title:      XtorlikeDevPerf.m
%   Author:     Dmitri E Nikonov
%   Date:       04/06/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
capadj = cop.Ctole + cop.Cgale*(bey.Cadj-1);   % adjusted capacitance per width
% for full device width
bey.Cdev = capadj*bey.wTran;                    % capacitance of the device, F
bey.Idev = bey.Ionle*bey.wTran;             % current in the device, A
bey.tint = capadj*bey.volt/bey.Ionle;       % intrinsic delay, s
bey.Eint = bey.Cdev*bey.volt^2;                 % intrinsic switching energy, J
end
