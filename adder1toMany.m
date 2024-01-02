function bey = adder1toMany(bey,cop)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function bey = adder1toMany(bey,cop)
% Obtain the area, delay, and switching energy for a multi-bit adder
% from the values for a 1-bit adder
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Title:      adder1toMany.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%   Author:     Dmitri E Nikonov
%   Date:       04/06/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nadd = cop.adderorder;
bey.aadd = nadd*cop.adderarea*bey.a1;
bey.tadd = nadd*bey.t1;
bey.Eadd = nadd*bey.E1;
bey.Sadd = nadd*bey.S1;
switch cop.name
    case {'BisFET','ITFET'}
        if cop.pipeline == 0
            bey.Eadd = bey.Eadd + bey.Sxor*(nadd+1)*nadd/2*bey.t1 + bey.Sadd*bey.t1;   % non-pipeline, 
        else
            bey.Eadd = bey.Eadd + bey.Sadd*bey.t1;   % pipeline, leakage less dominated 20X->3X
        end
%         bey.Eadd = bey.Eadd*bey.tadd/bey.t1;    % BCB 3.0 w/o leakage
%         bey.Eadd = bey.Eadd*bey.tadd/bey.t1+bey.Sadd*bey.tadd;    % BCB 3.0 with leakage
end

end

