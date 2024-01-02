%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Title:      inverseRashba.m
%   Author:     Dmitri E Nikonov
%   Date:       05/23/2015
%   (C) Dmitri E. Nikonov 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bey.wTran = cop.elecwidth*cop.F;            % width of the driving transistor, m
% in MESO configuration
vrash = bey.volt;                           % need to generate ME voltage by Rashba
Irash = vrash/cop.Rrash;                    % needed current in the rashba circuit
Idriv = Irash/cop.coefrash;                 % needed driving current
bey.Ionle = Idriv/bey.wTran;                % needed current density
bey.volt = bey.Ionle*cop.Rtranlin;          % needed driving voltage
% neglecting the wire resistance to the ground
% tme = time the pulse needs to be 'on' to switch the magnetoelectric
tdriv = cop.Rrash*Qtot/vrash;               % time to steady in the Rashba circuit
Edriv = bey.volt*Idriv*tme;                  % energy in the driving circuit

