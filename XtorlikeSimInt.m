%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Interconnect focused study for Charge-based FETs
% Title:      XtorlikeSimInt.m
% Author:     Chenyun Pan
% Last modified: 1/15/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bey = XtorlikeSimInt(bey,cop)

cw = cop.Cicle;                 % cap per unit length
rw = cop.rho/2/cop.F/4/cop.F;   % res per unit length
r0 = bey.volt/bey.Idev;         % device resistance
c0 = bey.Cdev;                  % device capacitance
tint = bey.tint;                % intrinsic delay
a0 = bey.anan;                  % NAND2 gate area
ainv1 = bey.ainv1;              % inverter area
volt = bey.volt;                % device vdd
fo = 1;
t0 = cop.target*tint;           % target clock period
dt = tint-r0.*c0;               % extra ferroelectric switching delay
a = 0.4*rw*cw; b = 0.7*(r0*cw+rw*c0*fo); c = -t0+0.7*r0.*c0*fo+dt;
span = (sqrt(b.^2-4*a.*c)-b)./a/2;      % find span @ given timing target
Aspan = 2*span.^2; 
bey.Nspan = Aspan./a0; 

lw = 100e-6;            % length of interconnect
bey.twire = (1.4*sqrt(r0.*c0*rw*cw)+2*sqrt((0.7*r0.*c0+dt)*0.4*rw*cw))*lw;  % interconnect delay
krep = sqrt(.4*rw*cw./(0.7*r0.*c0+dt))*lw;      % number of repeaters
lmin = 2./sqrt(.4*rw*cw./(0.7*r0.*c0+dt));
hrep = sqrt(r0*cw./c0/rw);                      % size of repeaters
Arep = krep.*hrep.*ainv1;
Ew = lw*cw*volt.^2;                             % interconnect energy
Ed = krep.*hrep.*c0*2.*volt.^2;                 % dynamic energy of repeaters
Ed = Ed+bey.Sinv1*bey.twire*krep*hrep;          % Add leakage of repeaters
Ed = Ed+bey.Sinv1*bey.twire*krep*hrep*10;       % Add leakage of repeaters
bey.Ewire = Ew+Ed;                              % total energy

end