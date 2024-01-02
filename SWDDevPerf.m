function bey = SWDDevPerf(bey,cop)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function bey = SWDSimCirc(bey,cop)
% Obtain performance of devices with spin waves
% Assumption - an RLC circuit drives the magnetoelectric cell, 
% intrinsic switching time ~10 periods, Q~10, 
% therefore dissipated energy ~= maximum energy stored in the capacitor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Title:      SWDDevPerf.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%   Author:     Dmitri E Nikonov
%   Date:       04/06/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fundcon
cop.liccu = cop.licsp;                      % unit is the spin interconnect unit
csw = 650;              % S. Dutta, IEEE nano, 2016
tsw = 4*cop.F/csw;      % propagation delay
tmag = .5e-9;           % magnet switching from metastable
bey.volt = .1;          % ME cell driving voltage
bey.tint = tsw+tmag;
Eclock = 1.6e-18;       % CMOS driving transistor energy per ME cell, S. Dutta, IEEE nano, 2016
Eme = 4.5e-18;          % ME cell switching energy, S. Dutta, IEEE nano, 2016
bey.Eint = Eclock + Eme;

bey.tic = bey.tint + cop.liccu/csw;         % interconnect delay, s, driving devices and spin wave propagation
bey.Eic = bey.Eint;                         % interconnect energy, J
bey.Sic = bey.Sint;                         % leakage power, W

end
