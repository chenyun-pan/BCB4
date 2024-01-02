function bey = XtorlikeArea(bey,cop)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function bey = XtorlikeArea(bey,cop)
% Obtain area for transistor-like devices and gates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Title:      XtorlikeArea.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%   Author:     Dmitri E Nikonov
%   Date:       04/06/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bey.aic = cop.lic*2*cop.F;          % an interconnect does not drive additional area
switch cop.name
    case 'STT/DW'
bey.length = 2*cop.pitch+2*cop.F;
bey.width = bey.wTran+cop.F;
bey.aint = bey.length*bey.width;
bey.ainv1 = bey.aint*cop.gatearea;
bey.ainv2 = 2*bey.ainv1;
bey.ainv4 = 4*bey.ainv1;
bey.anan =  2*bey.aint*cop.gatearea;
bey.anan3 =  3*bey.aint*cop.gatearea;
bey.anan4 =  4*bey.aint*cop.gatearea;    
    otherwise
bey.length = cop.pitch;         % not applicable to BisFET?
bey.width = bey.wTran;
bey.aint = bey.length*bey.width;
if strcmp(cop.name,'BisFET')
    bey.aint = cop.pitch^2*2*3.5; 
end
bey.ainv1 = bey.invlen*cop.pitch*bey.invwid*cop.pitch;
bey.ainv2 = (bey.invlen+1)*cop.pitch*bey.invwid*cop.pitch;
bey.ainv4 = (bey.invlen+3)*cop.pitch*bey.invwid*cop.pitch;
bey.anan = bey.nandlen*cop.pitch*bey.nandwid*cop.pitch;
bey.anan3 = (bey.nandlen+1)*cop.pitch*(bey.nandwid+1)*cop.pitch;
bey.anan4 = (bey.nandlen+2)*cop.pitch*(bey.nandwid+2)*cop.pitch;
end
switch cop.tunnel
    case 'n'
        bey.aram = 2*bey.ainv1;
    case 'y'
        bey.aram = 3*bey.ainv1;
end
bey.axor = 4*bey.anan*cop.gatearea;
bey.amux = (bey.anan4+4*bey.anan3+2*bey.ainv2)*cop.gatearea;
bey.adem = (4*bey.anan3+4*bey.ainv1+2*bey.ainv2)*cop.gatearea;
bey.ase = (4*bey.anan+3*bey.ainv1)*cop.gatearea;
switch cop.name
    case 'STT/DW'
        bey.a1 = (9*bey.anan+9*bey.ainv1)*cop.bitarea;
    otherwise
        bey.a1 = (2*bey.axor+3*bey.anan+3*bey.ainv1)*cop.bitarea;
        if cop.pipeline == 1 && bey.domino == 1
            bey.a1 = 13*cop.pitch*5*cop.pitch*cop.gatearea*cop.bitarea;
        end
end
end
