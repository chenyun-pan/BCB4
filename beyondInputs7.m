%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs for individual Beyond-CMOS devices
%   Title:      beyondInputs7.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%   Author:     Dmitri E Nikonov
%   Date:       01/01/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cgaun = cop.Cgale*1e9;              % gate capacitance in fF/um units
cop.tunnel = 'n';                   % non -tunneling FETs

% 'CMOS HP '; ...
% from ITRS 2013 edition; 2016 column
k=find(strcmp(deblank('CMOS HP '),caey));
if(~isempty(k))
bey(k).volt = 0.73;
cop.vTran = bey(k).volt;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = 1805;                % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Craw = Cgaun;
% In = 1805;
% Ip = In/1.19;
% bey(k).Ionle = 2/(1/In+1/Ip);       % on current, A/m
cop.Ionle = bey(k).Ionle;           % save the on-current
bey(k).Iofle = cop.Ileak;           % off-current, A/m
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
% ITRS already has Rsd included !!
Rchan = Ron/3;                      % resistance of the channel, small Vds
cop.Rtranlin = Rchan;
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
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

% not gate leakage, assumes a thicker gate
end

% 'CMOS LV '; ... Raseong low voltage
k=find(strcmp(deblank('CMOS LV '),caey));
if(~isempty(k))
bey(k).volt = 0.3;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m  
bey(k).Ionle = 53;                  % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 1.5e-3;              % off current, A/m
bey(k).Cadj = 0.14;                 % much smaller channel capacitance
bey(k).Craw = .14*Cgaun;
% Raseong has Rsd included !!
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% 'vdWFET  '; ...
% % FAME '14
k=find(strcmp(deblank('vdWFET'),caey));
if(~isempty(k))
bey(k).volt = 0.5;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m  
bey(k).Ionle = 2300;                   % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 0.1;                % off current, A/m
bey(k).Cadj = 1;                   % Dmitri's estimate
Ron = bey(k).volt/bey(k).Ionle;    % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

k=find(strcmp(deblank('vdWFET-BP'),caey));
if(~isempty(k))
bey(k).volt = 0.3;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m  
bey(k).Ionle = 34.96;                   % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 1.5e-3;                % off current, A/m
bey(k).Cadj = .0828/Cgaun;                   
bey(k).Craw = bey(k).Cadj*Cgaun;
Ron = bey(k).volt/bey(k).Ionle;    % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

k=find(strcmp(deblank('vdWFET-WS2'),caey));
if(~isempty(k))
bey(k).volt = 0.3;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m  
bey(k).Ionle = 29.51;                   % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 1.5e-3;                % off current, A/m
bey(k).Cadj = .0935/Cgaun;                   
Ron = bey(k).volt/bey(k).Ionle;    % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

cop.tunnel = 'y';                   % tunneling FETs

% 'HomJTFET'; ... @Lch=20nm,EOT=0.5nm
% Seabaugh NRI'11 workshop
k=find(strcmp(deblank('HomJTFET'),caey));
if(~isempty(k))
bey(k).volt = 0.2;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = 25;                  % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 6.2e-2;              % off current, A/m
bey(k).Cadj = 0.5;                  % capacitance lower in tunneling transistors
bey(k).Craw = bey(k).Cadj*Cgaun;
bey(k).nandlen = 4;                 % length of inverter in metal-1 pitches
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% 'HetJTFET  '; ... @Lch=20nm,EOT=0.5nm
% Seabaugh NRI'12 workshop
k=find(strcmp(deblank('HetJTFET  '),caey));
if(~isempty(k))
bey(k).volt = 0.4;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = 500;                 % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 4e-3;                % off current, A/m
bey(k).Cadj = 0.5;                  % capacitance lower in tunneling transistors
bey(k).Craw = bey(k).Cadj*Cgaun;
bey(k).nandlen = 4;                 % length of inverter in metal-1 pitches
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% 'gnrTFET '; ... @Lch=15nm, EOT=0.6nm
% Seabaugh NRI'12 workshop
k=find(strcmp(deblank('gnrTFET '),caey));
if(~isempty(k))
bey(k).volt = 0.25;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = 130;                 % on current, A/m (!) Ribbons = 1/2 of total width
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 2.5e-3;              % off current, A/m
bey(k).Cadj = 0.5;                  % capacitance lower in tunneling transistors
bey(k).Craw = bey(k).Cadj*Cgaun;
bey(k).nandlen = 4;                 % length of inverter in metal-1 pitches
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% 'BisFET  '; ...    
% SWAN '14
k=find(strcmp(deblank('BisFET  '),caey));
if(~isempty(k))
bey(k).volt = 0.025;
bey(k).wTran = 2*cop.F;             % device width, m 
bey(k).Ionle = bey(k).volt/cop.Rtunn/5;  % on current, A/m, factor 5 = Vdd/Vcritical
% bey(k).Iofle = 1e-3*bey(k).Ionle;   % off current, A/m
bey(k).Iofle = 1e-1*bey(k).Ionle;   % off current, A/m
bey(k).Cadj = 2;                    % very high interlayer capacitance
bey(k).invlen = 4;                  % length of inverter in metal-1 pitches
bey(k).nandlen = 6;                 % length of NAND in metal-1 pitches
bey(k).invwid = 4;                  % length of inverter in metal-1 pitches
bey(k).nandwid = 4.5;               % length of NAND in metal-1 pitches
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
bey(k).domino = 0;
end

% 'ITFET   ';
% SWAN '14
k=find(strcmp(deblank('ITFET   '),caey));
if(~isempty(k))
bey(k).volt = 0.075;
bey(k).wTran = 4*cop.F;             % device width, m 
bey(k).Ionle = bey(k).volt/cop.Rtunn/5*1;  % on current, A/m, factor 5 = Vdd/Vcritical
bey(k).Iofle = 1e-1*bey(k).Ionle;   % off current, A/m
bey(k).Cadj = 1;                    % very high interlayer capacitance
bey(k).invlen = 4;                  % length of inverter in metal-1 pitches
bey(k).nandlen = 6;                 % length of NAND in metal-1 pitches
bey(k).invwid = 4;                  % length of inverter in metal-1 pitches
bey(k).nandwid = 5;                 % length of NAND in metal-1 pitches
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
bey(k).domino = 0;
end

% 'ThinTFET'; ...
% LEAST '14
k=find(strcmp(deblank('ThinTFET'),caey));
if(~isempty(k))
bey(k).volt = 0.2;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = 858;                  % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 1e-3;                % off current, A/m
bey(k).Cadj = 0.38/Cgaun;           % capacitance lower in tunneling transistors
bey(k).Craw = bey(k).Cadj*Cgaun;
bey(k).nandlen = 4;                 % length of inverter in metal-1 pitches
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
% bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
bey(k).SS = 50;
bey(k).ib = 158;
end

% 'GaNTFET '; ...
% LEAST '14
k=find(strcmp(deblank('GaNTFET '),caey));
if(~isempty(k))
bey(k).volt = 0.3;
bey(k).Ionle = 88.58;                 % on current, A/m
bey(k).Cadj = 0.0188/Cgaun;           % capacitance lower in tunneling transistors
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 1e-3;                % off current, A/m

bey(k).Craw = bey(k).Cadj*Cgaun;
bey(k).nandlen = 4;                 % length of inverter in metal-1 pitches
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
% bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;

end

% 'TMDTFET '; ...
% LEAST '14, WSe2
k=find(strcmp(deblank('TMDTFET '),caey));
if(~isempty(k))
bey(k).volt = 0.2;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = 76;                  % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 1e-3;                % off current, A/m
bey(k).Cadj = 0.37/Cgaun;           % capacitance
bey(k).Craw = bey(k).Cadj*Cgaun;
bey(k).nandlen = 4;                 % length of inverter in metal-1 pitches
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
% bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
bey(k).SS = 103;
bey(k).ib = 15;
end

% 'NCFET   '; ...
% LEAST '14
k=find(strcmp(deblank('NCFET   '),caey));
if(~isempty(k))
bey(k).volt = 0.3;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = 526;                  % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 1e-3;                % off current, A/m
bey(k).Cadj = .53/Cgaun;           % same charge as CMOS at smaller voltage, i.e. higher capacitance
bey(k).Craw = bey(k).Cadj*Cgaun;
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
bey(k).SS = 64;
bey(k).ib = 7.5;
end

cop.tunnel = 'n';                   % non -tunneling FETs

% 'GpnJ    '; ... 
% CMOS-like, three junction devices, two-ribbon, rounded corners
k=find(strcmp(deblank('GpnJ    '),caey));
if(~isempty(k))
bey(k).volt = 0.4;
bey(k).wTran = 4*cop.F;             % device width, m
bey(k).invlen = 2;                  % length of inverter in metal-1 pitches
bey(k).nandlen = 4;                 % length of NAND in metal-1 pitches
bey(k).invwid = 5;                  % length of inverter in metal-1 pitches
bey(k).nandwid = 7;                 % length of NAND in metal-1 pitches
end

% 'GpnJ    '; ... 
k=find(strcmp(deblank('GpnJ-Vg2'),caey));
if(~isempty(k))
% bey(k).volt = 0.4;
bey(k).volt = 0.3;
bey(k).wTran = 1e-6;             % device width, m
bey(k).Ionle = 180;                  % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 15;                % off current, A/m
bey(k).invlen = 4;                  % length of inverter in metal-1 pitches
bey(k).nandlen = 6;                 % length of NAND in metal-1 pitches
bey(k).invwid = 68;                  % length of inverter in metal-1 pitches
bey(k).nandwid = 68;                 % length of NAND in metal-1 pitches
bey(k).Cadj = 1;    % miller
end
k=find(strcmp(deblank('GpnJ-Vg3'),caey));
if(~isempty(k))
% bey(k).volt = 0.4;
bey(k).volt = 0.3;
bey(k).wTran = 1e-6;             % device width, m
bey(k).Ionle = 750;                  % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 3.26;                % off current, A/m
bey(k).invlen = 4;                  % length of inverter in metal-1 pitches
bey(k).nandlen = 6;                 % length of NAND in metal-1 pitches
bey(k).invwid = 68;                  % length of inverter in metal-1 pitches
bey(k).nandwid = 68;                 % length of NAND in metal-1 pitches
bey(k).Cadj = 2;    % miller
end
% CMOS-like, three junction devices, two-ribbon, rounded corners
k=find(strcmp(deblank('GpnJ3'),caey));
if(~isempty(k))
bey(k).volt = 0.4;
bey(k).wTran = 4*cop.F;             % device width, m
bey(k).invlen = 2;                  % length of inverter in metal-1 pitches
bey(k).nandlen = 4;                 % length of NAND in metal-1 pitches
bey(k).invwid = 5;                  % length of inverter in metal-1 pitches
bey(k).nandwid = 7;                 % length of NAND in metal-1 pitches
bey(k).Cadj = 1.5;    % miller
end
k=find(strcmp(deblank('GpnJ2'),caey));
if(~isempty(k))
bey(k).volt = 0.4;
bey(k).wTran = 4*cop.F;             % device width, m
bey(k).invlen = 2;                  % length of inverter in metal-1 pitches
bey(k).nandlen = 4;                 % length of NAND in metal-1 pitches
bey(k).invwid = 4;                  % length of inverter in metal-1 pitches
bey(k).nandwid = 5;                 % length of NAND in metal-1 pitches
bey(k).Cadj = 2;    % miller
end
k=find(strcmp(deblank('GpnJ1'),caey));
if(~isempty(k))
bey(k).volt = 0.4;
bey(k).wTran = 4*cop.F;             % device width, m
bey(k).invlen = 2;                  % length of inverter in metal-1 pitches
bey(k).nandlen = 4;                 % length of NAND in metal-1 pitches
bey(k).invwid = 3;                  % length of inverter in metal-1 pitches
bey(k).nandwid = 3;                 % length of NAND in metal-1 pitches
bey(k).Cadj = 2;    % miller
end
k=find(strcmp(deblank('GpnJNEGF'),caey));
if(~isempty(k))
bey(k).volt = 0.4;
bey(k).wTran = 4*cop.F;             % device width, m
bey(k).invlen = 2;                  % length of inverter in metal-1 pitches
bey(k).nandlen = 4;                 % length of NAND in metal-1 pitches
bey(k).invwid = 4;                  % length of inverter in metal-1 pitches
bey(k).nandwid = 5;                 % length of NAND in metal-1 pitches
bey(k).Cadj = 2;    % miller
end

% 'FEFET   '; ...
% estimate derived from CMOS HP
k=find(strcmp(deblank('FEFET   '),caey));
if(~isempty(k))
bey(k).volt = bey(1).volt;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = bey(1).Ionle;        % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = bey(1).Iofle;        % off current, A/m
bey(k).Cadj = 1;                    % initial capacitance adjustment
bey(k).Craw = bey(k).Cadj*Cgaun;
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
% bey(k).Ionle = bey(k).Ionle/(1);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% 'PiezoFET'; ...
% LEAST '14
k=find(strcmp(deblank('PiezoFET'),caey));
if(~isempty(k))
bey(k).volt = 0.3;                  
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = 421;                % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 1.7e-2;                   % off current, A/m
%otn = cop.Cpiezo/cop.Cgaar*cop.F/cop.Lch;
bey(k).Cadj = 0.25;                  % capacitance of piezoelectric
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% 'ExFET   '; ...
% FAME '14 FIX IT
k=find(strcmp(deblank('ExFET   '),caey));
if(~isempty(k))
bey(k).volt = 0.4;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m
bey(k).Ionle = 1000;                % on current, A/m
bey(k).Iofle = 0.3;                 % off current, A/m
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% 'MITFET  '; ...
% FAME 
k=find(strcmp(deblank('MITFET  '),caey));
if(~isempty(k))
bey(k).volt = 0.5;
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = 3000;                % on current, A/m
bey(k).Iraw = bey(k).Ionle;
bey(k).Iofle = 0.3;                 % worse off current, A/m, due to the deplection mode
bey(k).Cadj = 2.56/Cgaun;           % very high capacitance of the ferroelectric
bey(k).Craw = bey(k).Cadj*Cgaun;
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% 'SpinFET '; ...
% estimate derived from CMOS HP
k=find(strcmp(deblank('SpinFET '),caey));
if(~isempty(k))
bey(k).volt = 0.7;
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).Ionle = 700;                 % on current, A/m
bey(k).Iofle = 0.3/10;              % off current, A/m, suppressed due to magnetoresistance
bey(k).Cadj = 2;                    % cap adjustment for an MTJ
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
end

% 'ASL     '; ...    
k=find(strcmp(deblank('ASL     '),caey));
if(~isempty(k))
% bey(k).volt = 0.05;
bey(k).volt = 0.1;
bey(k).mgates = 2;                              % 2 crosses in the functionally enhanced adder
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 3*cop.pitch;  % cross majority gate
bey(k).width = 3*cop.pitch;
end

% 'ASL     '; ...    
k=find(strcmp(deblank('ASL-PMA'),caey));
if(~isempty(k))
bey(k).volt = 0.05;
bey(k).volt = 0.1;
bey(k).mgates = 2;                              % 2 crosses in the functionally enhanced adder
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 3*cop.pitch;  % cross majority gate
bey(k).width = 3*cop.pitch;
end

k=find(strcmp(deblank('ASL-HA'),caey));
if(~isempty(k))
bey(k).volt = 0.1;
bey(k).mgates = 2;                              % 2 crosses in the functionally enhanced adder
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 3*cop.pitch;  % cross majority gate
bey(k).width = 3*cop.pitch;
end

k=find(strcmp(deblank('ASL-HAs'),caey));
if(~isempty(k))
bey(k).volt = 0.1;
bey(k).mgates = 2;                              % 2 crosses in the functionally enhanced adder
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 3*cop.pitch;  % cross majority gate
bey(k).width = 3*cop.pitch;
end

% 'ASL     '; ...    
k=find(strcmp(deblank('ASL-ME'),caey));
if(~isempty(k))
% bey(k).volt = 0.05;
bey(k).volt = 0.2;
bey(k).mgates = 2;                              % 2 crosses in the functionally enhanced adder
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 3*cop.pitch;  % cross majority gate
bey(k).width = 3*cop.pitch;
end

% 'CSL    '; ...
k=find(strcmp(deblank('CSL     '),caey));
if(~isempty(k))
bey(k).volt = 0.1;
if cop.RAspinvalve > 1e-12; bey(k).volt = 2; end
bey(k).mgates = 2;                              % 2 crosses in the functionally enhanced adder
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 4*cop.pitch;  % 3*2MP cross majority gate
bey(k).width = 4*cop.pitch;
end

% 'CSL    '; ...
k=find(strcmp(deblank('CSL-CC'),caey));
if(~isempty(k))
bey(k).volt = 0.08;
if cop.RAspinvalve > 1e-12; bey(k).volt = 1.5; end
bey(k).mgates = 2;                              % 2 crosses in the functionally enhanced adder
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 4*cop.pitch;  % cross majority gate
bey(k).width = 5*cop.pitch;     % extra CC
end

k=find(strcmp(deblank('CSL-New'),caey));
if(~isempty(k))
bey(k).volt = 0.05;
if cop.RAspinvalve > 1e-12; bey(k).volt = 1.2; end
bey(k).mgates = 2;                              % 2 crosses in the functionally enhanced adder
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 4*cop.pitch;  % cross majority gate
bey(k).width = 5*cop.pitch;     % extra CC
end

k=find(strcmp(deblank('CSL-YIG'),caey));
if(~isempty(k))
bey(k).volt = 0.035;
if cop.RAspinvalve > 1e-12; bey(k).volt = 1.1; end
bey(k).mgates = 2;                              % 2 crosses in the functionally enhanced adder
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 4*cop.pitch;  % cross majority gate
bey(k).width = 5*cop.pitch;   % extra CC
end

% 'STT/DW  '; ...     % Ross, aka MTJ logic switch
k=find(strcmp(deblank('STT/DW  '),caey));
if(~isempty(k))
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).domino = 0;
end

k=find(strcmp(deblank('mLogic'),caey));
if(~isempty(k))
bey(k).volt = 0.05;
if cop.RAspinvalve > 1e-12; bey(k).volt = .5; end
bey(k).wTran = cop.elecwidth*cop.F; % device width, m 
bey(k).Ionle = 43;                  % on current, A/m
bey(k).Iofle = 1e-3;                % off current, A/m
bey(k).Cadj = 0.19/Cgaun;           % capacitance lower in tunneling transistors
bey(k).invlen = 1;                  % length of inverter in metal-1 pitches
bey(k).nandlen = 8;                 % length of NAND in metal-1 pitches
bey(k).invwid = 2;                  % length of inverter in metal-1 pitches
bey(k).nandwid = 8;               % length of NAND in metal-1 pitches
Ron = bey(k).volt/bey(k).Ionle;     % on-resistance for the transistor, large Vds
bey(k).Ionle = bey(k).Ionle/(1+cop.Rcont/Ron);
bey(k).Iofle = cop.Jg*cop.Lch + bey(k).Iofle;
bey(k).domino = 0;
end

% 'SWD     '; ...    
k=find(strcmp(deblank('SWD     '),caey));
if(~isempty(k))
bey(k).volt = 0.13;
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).mgates = 2;                              % effectively 2 crosses in the adder
bey(k).majcrit = 1;                             % 1 crosses in the critical pass of an adder
bey(k).length = 3*cop.pitch;  % cross majority gate
bey(k).width = 3*cop.pitch;
end

% 'MEMTJ     '; ...    
k=find(strcmp(deblank('MEMTJ     '),caey));
if(~isempty(k))
% bey(k).volt = .3;
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 5*cop.pitch;  % cross majority gate
bey(k).width = 3*cop.pitch;
end

k=find(strcmp(deblank('MEMTJ-Sep '),caey));
if(~isempty(k))
% bey(k).volt = .3;
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 8*cop.pitch;  % cross majority gate
bey(k).width = 3*cop.pitch;
end

k=find(strcmp(deblank('MEMTJs  '),caey));
if(~isempty(k))
% bey(k).volt = .3;
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 4*cop.pitch;  % cross majority gate
bey(k).width = 2*cop.pitch;
end

k=find(strcmp(deblank('MEMTJ-Pre '),caey));
if(~isempty(k))
% bey(k).volt = .3;
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 6*cop.pitch;  % cross majority gate
bey(k).width = 3*cop.pitch;
end

k=find(strcmp(deblank('MEMTJ-Pres'),caey));
if(~isempty(k))
% bey(k).volt = .3;
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 5*cop.pitch;  % cross majority gate
bey(k).width = 2*cop.pitch;
end

k=find(strcmp(deblank('CoMET'),caey));
if(~isempty(k))
% bey(k).volt = .3;
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
bey(k).length = 4*cop.pitch;  % cross majority gate
bey(k).width = 8*cop.pitch;
end

% 'NML     '
k=find(strcmp(deblank('NML     '),caey));
if(~isempty(k))
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
end

% 'SMG     '; ...     % Nikonov
% cross-version
k=find(strcmp(deblank('SMG     '),caey));
if(~isempty(k))
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
end

% 'STOlogic'; ...     % Krivorotov, aka Spin Torque Majority Logic
k=find(strcmp(deblank('STOlogic'),caey));
if(~isempty(k))
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
end

% 'MESO    '; ...     % Manipatruni
k=find(strcmp(deblank('MESO    '),caey));
if(~isempty(k))
bey(k).wTran = cop.elecwidth*cop.F;             % width of the transistor, m
bey(k).wMagn = cop.spinwidth*cop.F;             % width of the magnet, m
end
