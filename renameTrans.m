cop.F = bey(k).metpitch/2;          % metal half pitch, m
cop.Lch = bey(k).Lg;                % gate length, m
cop.EOT = bey(k).EOT;               % equivalent oxide thickness, m

bey(k).wTran = cop.elecwidth*cop.F; % device width, m
cop.pitch = 4*cop.F;                % contacted gate pitch
cop.lic = 5*cop.pitch;              % typical length of an electrical interconnect
cop.licsp = 5*cop.pitch;            % typical length of a spin spin interconnect
cop.Cgaar = eps0*cop.epsSiO2/cop.EOT;           % gate capacitance, F/m^2
cop.Cgale = cop.Cgaar*cop.Lch;      % gate capacitance, F/m
Cint = cop.Cgale*1e12;              
cop.Ctole = cop.Cgale*(cop.parasitC+1); % parasitics adjusted gate capacitance, F/m
cop.Cicle = CapWire(2*cop.F,4*cop.F,2*cop.F,4*cop.F,cop.epsILD);
                                    % interconnect capacitance per unit length, F/m
cop.Cic = cop.lic*cop.Cicle;        % interconnect capacitance per logic gate, F