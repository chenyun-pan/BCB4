%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Intrinsic delay and energy for MEMTJ device
%   Title:      MEMTJDevPerf.m
%   Author:     Chenyun Pan
%   Last modified: 1/15/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bey = MEMTJDevPerf(bey,cop)
fundcon
d = cop.thme; k = 13;       % thickness and dielectric of AFM
E0 = eps0; 
Amtj = 4*cop.F*cop.F;       % area of MTJ
tox = 2.3e-9;               % MTJ oxide thickness
Rp = 10.^(2.85*tox*1e9-2.57)*1e-12/Amtj; Rap = Rp.*(1+cop.TMR); 
Cmtj=(k.*E0.*Amtj)/tox;     % MTJ capacitance
Bcp = .06; tmag = 1.3e-9;      % from numerical simulation
Ereq = cop.Elecme*Bcp/cop.Bme;        % required electric field, V/m
dV = Ereq*cop.thme;                   % switching voltage, V
if strcmp(cop.name,'MEMTJ')
    A = 14*cop.F*2*cop.F;
    Ereq = cop.Elecme*Bcp/cop.Bme;    % required electric field, V/m
    dV = Ereq*d;
    vdd = 2*dV*3*(Rp+Rap)/(Rap-Rp);   % worst case
end
if strcmp(cop.name,'MEMTJ-Sep')
    A = 2*10*cop.F*2*cop.F;
    Ereq = cop.Elecme*Bcp/cop.Bme;    % required electric field, V/m
    dV = Ereq*d;
    vdd = 2*dV*3*(Rp+Rap)/(Rap-Rp);
end
if strcmp(cop.name,'MEMTJ-Pre')
    A = 6*cop.F*2*cop.F;
    rdown1 = Rp*Rap/(Rp+2*Rap);     % pull-down resistance
    rdown2 = Rp*Rap/(2*Rp+Rap); rup = Rp;
    v1 = rdown1./(rdown1+rup); v2 = rdown2./(rdown2+rup); vmid = .5*(v1+v2); %d = vmid*vdd/vcrit*d0; 
    vdd = dV/vmid;
end
if strcmp(cop.name,'MEMTJs')
    A = 10*cop.F*2*cop.F;
    Ereq = cop.Elecme*Bcp/cop.Bme;              % required electric field, V/m
    dV = Ereq*d;
    vdd = 2*dV/(Rap-Rp)*(Rap+Rp);
end
if strcmp(cop.name,'MEMTJ-Pres')
    A = 6*cop.F*2*cop.F; ratio = 1; % same MTJ size
    v1 = Rp/ratio/(Rp/ratio+Rp); v2 = Rap/ratio/(Rap/ratio+Rp); vmid = .5*(v1+v2);      % area ratio 2.5
    vdd = dV/vmid;
end
Cafm = (k.*E0.*A)./d;           % AFM capacitance
Eint = .5*(Cafm+Cmtj*2)*dV^2;   % intrinsic energy
trc = .7*Rap*Rp/(Rap+Rp)*Cafm;  % RC delay 
tint = tmag+trc;                % total intrinsic delay
Eleak = vdd^2/(Rp+Rap)*tint;    % leakage energy
energy = Eint+Eleak;            % total intrinsic energy
bey.volt = vdd;
bey.Eint = energy;
bey.tint = tint;
bey.tic = cop.factic*cop.Cic*Rap*Rp/(Rap+Rp);
bey.Eic = cop.facEcap*cop.Cic*bey.volt^2;















