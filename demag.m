function [Nxx,Nyy,Nzz] = demag(a,b,c,flag_shape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Demagnetization factor for different geometry
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author : Sou-Chi Chang
% Last modified : 11/07/2012
% The original code is written by Dmitri E. Nikonov from Intel

% Input :
% a, b, and c are length, width, and thickness of nanomagnet
% flag_shape : shape of nanomaget

% Output :
% Nxx, Nyy, and Nzz are demagnetization factor of nanomagnet

switch flag_shape
    
    case 'ellipsoid'

        cthe = c./a;
        cphi = b./a;
        sthe = sqrt(1-cthe.*cthe);
        sphi = sqrt(1-cphi.*cphi);
        k = sphi./sthe;
        calph = sqrt(1-k.*k);
        N1 = mfun('EllipticF',sthe,k);
        N2 = mfun('EllipticE',sthe,k);
        mnozh = cphi.*cthe./sthe./sthe./sthe;
        Nxx = mnozh.*(N1-N2)./k./k;
        Nyy = mnozh.*(N2-N1.*calph.*calph-k.*k.*sthe.*cthe./cphi)./k./k./calph./calph;
        Nzz = mnozh.*(sthe.*cphi./cthe-N2)./calph./calph;
    
    case 'cylinder'
        
        beta = b./a;
        tau = c./a;
        ksi = c./b;
        eccentr = 1-beta.*beta;
        [zK,zE] = ellipke(eccentr);
        qua1 = quad(@vyr1,0,pi/2,1e-4);
        qua2 = quad(@vyr2,0,pi/2,1e-4);
        co1 = 8./3./pi./pi;
        Nxx = co1./ksi./eccentr.*(beta.*beta*zK-zE) + 2.*beta.*beta./pi.*qua2;
        Nzz = 1 + co1./ksi.*zK - 2./pi.*qua1;
        Nyy = 1 - Nxx - Nzz;
    
    case 'cuboid'
        
        ly = b./a;
        lz = c./a;
        Nxx = rectprism(ly,lz);
        Nyy = rectprism(lz./ly,1./ly);
        Nzz = rectprism(1./lz,ly./lz);
        
end

end

function [N] = rectprism(ly,lz)

    ly2 = ly.*ly;
    lz2 = lz.*lz;
    tly = sqrt(1+ly2);
    tlz = sqrt(1+lz2);
    tlyz = sqrt(ly2+lz2);
    Lam = sqrt(1+ly2+lz2);
    ly3 = ly.*ly.*ly;
    lz3 = lz.*lz.*lz;
    tlyz3 = tlyz.*tlyz.*tlyz;
    N = -2 + ly3 + lz3 + (2-ly2).*tly + (2-lz2).*tlz - tlyz3 ...
    + Lam.*(-2+ly2+lz2) - 3.*ly.*log(ly+tly) - 3.*lz.*log(lz+tlz) ...
    + 6.*ly.*lz.*atan(ly.*lz./Lam) - 3.*ly.*lz.*(ly.*log(ly)+lz.*log(lz)) ...
    + 3.*ly*(lz2-1).*log(tlz./(ly+Lam)) + 3.*lz*(ly2-1).*log(tly./(lz+Lam)) ...
    + 3.*ly.*lz2*log(ly+tlyz) + 3.*lz.*ly2*log(lz+tlyz);

N = N./3./pi./ly./lz;

end