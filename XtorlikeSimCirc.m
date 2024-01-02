function bey = XtorlikeSimCirc(bey,cop)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function bey = XtorlikeSimCirc(bey,cop)
% Obtain performance of simple circuits with MOSFET-like device
% time and energy with the downstream (or upstream ?!) interconnect till the next gate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Title:      XtorlikeSimCirc.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%   Author:     Dmitri E Nikonov
%   Date:       04/06/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch cop.name
    case {'NCFET','PiezoFET'}
        tfe = cop.tPZint;
    case {'MITFET','FEFET'}
        tfe = cop.tFEint;
    otherwise
        tfe = 0;
end

cop.liccu = cop.lic;                        % unit is the electrical interconnect unit
lengthfactors                               % factors of interconnect length
if ~strcmp(cop.name,'mLogic')
    bey.tic = cop.factic*cop.Cic*bey.volt/bey.Idev;         % interconnect delay, s
    bey.Eic = cop.facEcap*cop.Cic*bey.volt^2;               % interconnect energy, J
    switch cop.name
        case 'BisFET'                           % more complex interconnects
            bey.tic = 2.*bey.tic;
            bey.Eic = 2.*bey.Eic;
    end
end
% simple circuits
Ioff = bey.Iofle*bey.wTran;
bey.Sint = bey.volt*Ioff;
FO = 1;
bey.tinv1 = (FO+1)*cop.factinv*bey.tint + bey.tic*cop.factic*fac_inv1;                   
bey.Einv1 = FO*(cop.facEinv*bey.Eint + bey.Eic*cop.facEcap*fac_inv1);
bey.Sinv1 = FO*(bey.Sint + bey.Sic*fac_inv1);
FO = 2;
bey.tinv2 = (FO+1)*cop.factinv*bey.tint + bey.tic*cop.factic*fac_inv1;                   
bey.Einv2 = FO*(cop.facEinv*bey.Eint + bey.Eic*cop.facEcap*fac_inv1);
bey.Sinv2 = FO*(bey.Sint + bey.Sic*fac_inv1);
FO = 4;
bey.tinv4 = (FO+1)*cop.factinv*bey.tint + bey.tic*cop.factic*fac_inv4;
bey.Einv4 = FO*(cop.facEinv*bey.Eint + bey.Eic*cop.facEcap*fac_inv4);
bey.Sinv4 = FO*(bey.Sint + FO*bey.Sic*fac_inv1);
% estimates for NOR the same as NAND
FI = 2;
bey.tnan = FI*cop.factnan*bey.tint + bey.tic*cop.factic*fac_nan;
bey.Enan = FI*cop.facEnan*bey.Eint + bey.Eic*cop.facEcap*fac_nan;
FI = 3;
bey.tnan3 = FI*cop.factnan*bey.tint + bey.tic*cop.factic*fac_nan3;
bey.Enan3 = FI*cop.facEnan*bey.Eint + bey.Eic*cop.facEcap*fac_nan3;
FI = 4;
bey.tnan4 = FI*cop.factnan*bey.tint + bey.tic*cop.factic*fac_nan4;
bey.Enan4 = FI*cop.facEnan*bey.Eint + bey.Eic*cop.facEcap*fac_nan4;

bey.tint = bey.tint + tfe;
bey.tinv1 = bey.tinv1 + tfe;
bey.tinv2 = bey.tinv2 + tfe;
bey.tinv4 = bey.tinv4 + tfe;
bey.tnan = bey.tnan + tfe;
bey.tnan3 = bey.tnan3 + tfe;
bey.tnan4 = bey.tnan4 + tfe;

switch cop.name
    case {'HomJTFET','HetJTFET','gnrTFET','ThinTFET','GaNTFET','TMDTFET'}  
bey.Snan = 1.535*bey.Sint + bey.Sic*fac_nan;            % analyzed input combinations
bey.Snan3 = 0.837*bey.Sint + bey.Sic*fac_nan3;
bey.Snan4 = 5/8*bey.Sint + bey.Sic*fac_nan4;
    otherwise
bey.Snan = 1.625*bey.Sint + bey.Sic*fac_nan;            % analyzed input combinations
bey.Snan3 = 0.897*bey.Sint + bey.Sic*fac_nan3;
bey.Snan4 = 0.6*bey.Sint + bey.Sic*fac_nan4;  
end
bey.txor = 3*bey.tnan + bey.tic*cop.factic*fac_xor;
bey.Exor = 4*bey.Enan + bey.Eic*cop.facEcap*fac_xor;
bey.Sxor = 4*bey.Snan + bey.Sic*fac_xor;
bey.tmux = bey.tnan4 + bey.tnan3 + bey.tinv2 + bey.tic*cop.factic*fac_mux;
bey.Emux = bey.Enan4 + 4*bey.Enan3 + 2*bey.Einv2 + bey.Eic*cop.facEcap*fac_mux;
bey.Smux = bey.Snan4 + 4*bey.Snan3 + 2*bey.Sinv2 + bey.Sic*fac_mux;
bey.tdem = bey.tnan3 + bey.tinv2 + bey.tic*cop.factic*fac_dem;
bey.Edem = 4*bey.Enan3 + 2*bey.Einv2 + 4*bey.Eic*cop.facEcap*fac_dem;
bey.Sdem = 4*bey.Snan3 + 2*bey.Sinv2 + 4*bey.Sic*fac_dem;
bey.tse = 2*bey.tinv1 + 3*bey.tnan + bey.tic*cop.factic*fac_se;
bey.Ese = 3*bey.Einv1 + 4*bey.Enan + 2*bey.Eic*cop.facEcap*fac_se;
bey.Sse = 3*bey.Sinv1 + 4*bey.Snan + 2*bey.Sic*fac_se;
switch cop.tunnel
    case 'n'
        bey.tram = 2*bey.tinv1 + bey.tic*cop.factic*fac_ram;
        bey.Eram = 3*bey.Einv1 + bey.Eic*cop.facEcap*fac_ram;
        bey.Sram = 2*bey.Sinv1 + bey.Sic*fac_ram;
    case 'y'
        bey.tram = 2*bey.tinv1 + bey.tic*cop.factic*fac_ram;
        bey.Eram = 4*bey.Einv1 + bey.Eic*cop.facEcap*fac_ram;
        bey.Sram = 3*bey.Sinv1 + bey.Sic*fac_ram;
end
switch cop.name
    case 'STT/DW'
bey.t1 = 9*bey.tnan;
bey.E1 = 9*bey.Enan + 9*bey.Einv1 + 2*bey.Eic*cop.facEcap*fac_1;
bey.S1 = 9*bey.Snan + 9*bey.Sinv1 + 2*bey.Sic*fac_1;
    otherwise
bey.t1 = 1.5*bey.txor+2.5*bey.tnan + bey.tic*cop.factic*fac_1;
bey.E1 = 7/8*bey.Exor+351/512*bey.Enan + 2*bey.Eic*cop.facEcap*fac_1;
if cop.pipeline == 1 && bey.domino == 1     % exclude BisFET and ITFET

    bey.t1 = 15*bey.tint + 3*tfe + bey.tic*cop.factic*fac_1; % 1/2 clock cycle
    bey.E1 = 13.625*bey.Eint + bey.Eic*cop.facEcap*fac_1;
end
bey.S1 = (2*bey.Sxor+3*bey.Snan) + 2*bey.Sic*fac_1;
end
end










