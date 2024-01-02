%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs for individual Beyond-CMOS devices
%   Title:      beyondInputs6.m
%   Author:     Dmitri E Nikonov
%   Date:       01/01/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cop.tunnel = 'n';                   % non -tunneling FETs

% 'CMOS HP '; ...
% from ITRS 2013 edition; 2016 column
k=find(strcmp(deblank('CMOS HP '),caey));
if(~isempty(k))
bey(k).volt = 0.73;
%cop.vTran = bey(k).volt;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
In = 1805;
Ip = In/1.19;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
cop.Ionle = bey(k).Ionle;           % save the on-current
bey(k).Iofle = cop.Ileak;           % off-current, A/m
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
% ITRS already has Rsd included !!
%Rchan = Ron/3;                      % resistance of the channel, small Vds
%cop.Rtranlin = Rchan;
%bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% 'CMOS LP '; ...
% from U. E. Avci VLSI'11
k=find(strcmp(deblank('CMOS LP '),caey));
if(~isempty(k))
bey(k).volt = 0.3;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m  
bey(k).Ionle = 7;                   % on current, A/m
bey(k).Iofle = 4e-3;                % off current, A/m
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
end

% 'CMOS LV '; ... Raseong low voltage
k=find(strcmp(deblank('CMOS LV '),caey));
if(~isempty(k))
bey(k).volt = 0.3;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m  
bey(k).Ionle = 53;                  % on current, A/m
bey(k).Iofle = 1.5e-3;              % off current, A/m
bey(k).Cadj = 0.14;                 % much smaller channel capacitance
% Raseong has Rsd included !!
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% '350nm   '; ...
% Intel's 350nm
k=find(strcmp(deblank('350nm   '),caey));
if(~isempty(k))
bey(k).volt = 2.5;                  % supply voltage, V
In = 670;
Ip = 330;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.033e-3*0.55;       % off-current, A/m
bey(k).metpitch = 880e-9;           % metal pitch, m
bey(k).Lg = 175e-9;                  % gate length, m
bey(k).EOT = 6.0e-9;                % oxide thickness, m
end

% '250nm   '; ...
% Intel's 250nm
k=find(strcmp(deblank('250nm   '),caey));
if(~isempty(k))
bey(k).volt = 1.8;                  % supply voltage, V
In = 700;
Ip = 320;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.4e-3;                % off-current, A/m
bey(k).metpitch = 640e-9;           % metal pitch, m
bey(k).Lg = 180e-9;                  % gate length, m
bey(k).EOT = 4.5e-9;                % oxide thickness, m
end

% '180nm   '; ...
% Intel's 180nm
k=find(strcmp(deblank('180nm   '),caey));
if(~isempty(k))
bey(k).volt = 1.5;                  % supply voltage, V
In = 1040;
Ip = 460;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 3e-3;                % off-current, A/m
bey(k).metpitch = 500e-9;           % metal pitch, m
bey(k).Lg = 140e-9;                  % gate length, m
bey(k).EOT = 2.0e-9;                % oxide thickness, m
end

% '130nm   '; ...
% Intel's 130nm
k=find(strcmp(deblank('130nm   '),caey));
if(~isempty(k))
bey(k).volt = 1.3;                  % supply voltage, V
In = 1020;
Ip = 500;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.01;                % off-current, A/m
bey(k).metpitch = 350e-9;           % metal pitch, m
bey(k).Lg = 70e-9;                  % gate length, m
bey(k).EOT = 1.5e-9;                % oxide thickness, m
end

% 'i90nm   '; ...
% Intel's 90nm
k=find(strcmp(deblank('i90nm   '),caey));
if(~isempty(k))
bey(k).volt = 1.2;                  % supply voltage, V
In = 1260;
Ip = 630;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.04;                % off-current, A/m
bey(k).metpitch = 220e-9;           % metal pitch, m
bey(k).Lg = 50e-9;                  % gate length, m
bey(k).EOT = 1.2e-9;                % oxide thickness, m
end

% 'i65nm   '; ...
% Intel's 65nm
k=find(strcmp(deblank('i65nm   '),caey));
if(~isempty(k))
bey(k).volt = 1.2;                  % supply voltage, V
In = 1460;
Ip = 880;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.1;                 % off-current, A/m
bey(k).metpitch = 210e-9;           % metal pitch, m
bey(k).Lg = 35e-9;                  % gate length, m
bey(k).EOT = 1.2e-9;                % oxide thickness, m
end

% 'i45nm   '; ...
% Intel's 45nm
k=find(strcmp(deblank('i45nm   '),caey));
if(~isempty(k))
bey(k).volt = 1;                   % supply voltage, V
In = 1360;
Ip = 1070;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.1;                 % off-current, A/m
bey(k).metpitch = 160e-9;           % metal pitch, m
bey(k).Lg = 35e-9;                  % gate length, m
bey(k).EOT = 1e-9;                  % oxide thickness, m
end

% 'i32nm   '; ...
% Intel's 32nm
k=find(strcmp(deblank('i32nm   '),caey));
if(~isempty(k))
bey(k).volt = 1;                    % supply voltage, V
In = 1550;
Ip = 1210;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.1;                 % off-current, A/m
bey(k).metpitch = 112.5e-9;         % metal pitch, m
bey(k).Lg = 30e-9;                  % gate length, m
bey(k).EOT = 0.9e-9;                % oxide thickness, m
end

% 'i22nm   '; ...
% Intel's 22nm
k=find(strcmp(deblank('i22nm   '),caey));
if(~isempty(k))
bey(k).volt = 0.8;                  % supply voltage, V
In = 1260;
Ip = 1100;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.02;                % off-current, A/m
bey(k).metpitch = 80e-9;            % metal pitch, m
bey(k).Lg = 26e-9;                  % gate length, m
bey(k).EOT = 0.9e-9;                % oxide thickness, m
end

% 'i14nm   '; ...
% Intel's 14nm
k=find(strcmp(deblank('i14nm   '),caey));
if(~isempty(k))
bey(k).volt = 0.7;                  % supply voltage, V
In = 1040;
Ip = 1040;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.01;                % off-current, A/m
bey(k).metpitch = 52e-9;            % metal pitch, m
bey(k).Lg = 20e-9;                  % gate length, m
bey(k).EOT = 0.9e-9;                % oxide thickness, m
end

% 'r2011   '; ...
% ITRS 2011
k=find(strcmp(deblank('r2011   '),caey));
if(~isempty(k))
bey(k).volt = 0.9;                  % supply voltage, V
In = 1320;
Ip = In/1.27;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.1;                 % off-current, A/m
bey(k).metpitch = 2*38e-9;          % metal pitch, m
bey(k).Lg = 24e-9;                  % gate length, m
bey(k).EOT = 1.2e-9;                % oxide thickness, m
end

% 'r2013   '; ...
% ITRS 2013
k=find(strcmp(deblank('r2013   '),caey));
if(~isempty(k))
bey(k).volt = 0.85;                 % supply voltage, V
In = 1520;
Ip = In/1.25;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.1;                 % off-current, A/m
bey(k).metpitch = 2*27e-9;          % metal pitch, m
bey(k).Lg = 20e-9;                  % gate length, m
bey(k).EOT = 1.28e-9;               % oxide thickness, m
end

% 'r2015   '; ...
% ITRS 2015
k=find(strcmp(deblank('r2015   '),caey));
if(~isempty(k))
bey(k).volt = 0.8;                  % supply voltage, V
In = 1628;
Ip = In/1.22;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.1;                 % off-current, A/m
bey(k).metpitch = 2*21e-9;          % metal pitch, m
bey(k).Lg = 17e-9;                  % gate length, m
bey(k).EOT = 1.2e-9;                % oxide thickness, m
end

% 'r2017   '; ...
% ITRS 2017
k=find(strcmp(deblank('r2017   '),caey));
if(~isempty(k))
bey(k).volt = 0.75;                 % supply voltage, V
In = 1744;
Ip = In/1.2;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.1;                 % off-current, A/m
bey(k).metpitch = 2*16.9e-9;        % metal pitch, m
bey(k).Lg = 14e-9;                  % gate length, m
bey(k).EOT = 1.12e-9;               % oxide thickness, m
end

% 'r2019   '; ...
% ITRS 2019
k=find(strcmp(deblank('r2019   '),caey));
if(~isempty(k))
bey(k).volt = 0.71;                 % supply voltage, V
In = 1858;
Ip = In/1.18;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.1;                 % off-current, A/m
bey(k).metpitch = 2*13.4e-9;        % metal pitch, m
bey(k).Lg = 11.7e-9;                % gate length, m
bey(k).EOT = 1.05e-9;               % oxide thickness, m
end

% 'r2021   '; ...
% ITRS 2021
k=find(strcmp(deblank('r2021   '),caey));
if(~isempty(k))
bey(k).volt = 0.66;                 % supply voltage, V
In = 1976;
Ip = In/1.15;
bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
bey(k).Iofle = 0.1;                 % off-current, A/m
bey(k).metpitch = 2*10.6e-9;        % metal pitch, m
bey(k).Lg = 9.7e-9;                 % gate length, m
bey(k).EOT = 0.99e-9;               % oxide thickness, m
end
