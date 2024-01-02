%% this file calculates the effective resistivity using the
%% Fuchs-Sondheimer-Mayadas-Shatzkes model
function [rho_eff_cu,mu_cu,D_cu,lambdam_net_cu,lambdam_def_cu,Lsn_cu] = ...
    rho_metal_copper(R,p,w,AR,d) %%% R = reflectivity, p = specularity, d = spacing b/w grain boundaries, w = width, lamda = mfp, AR = aspect ration, rho0 = bulk resistivity 
%% rho_expt in ohm-m;
%% Ls_expt also in meters
lambda_cu=40;
rho0_cu=1.7e-06;
n0_cu=8.5e22;
Ef_cu=7;
alpha_cu = lambda_cu./d.*R./(1-R);
rho_eff_cu = rho0_cu*(1/3*(1/3-alpha_cu/2+alpha_cu^2-alpha_cu.^3.*log(1+1./alpha_cu)).^(-1)+0.45*(1-p).*(1+AR)./AR.*lambda_cu./w);
q=1.6e-19;
mu_cu = 1./(rho_eff_cu*q*n0_cu);
D_cu = 2/3*Ef_cu*mu_cu;
mass=9.1e-31;
vf_cu = 1.57e8;
aph_cu = 2e-3;
adef_cu = 5e-4;
lambdam_net_cu = mass*vf_cu*1e-2./1.6e-19.*(mu_cu*1e-04)*1e2;% in cm
lambdam_def_cu = 40e-07*lambdam_net_cu./(40e-07-lambdam_net_cu);% in cm
Lsn_cu= sqrt(D_cu./vf_cu.*(lambdam_def_cu*40e-07)./(40e-07*adef_cu+lambdam_def_cu*aph_cu));
%aexpt = (mass*1.57e6)^2./(q^2*n0_cu*1e6*rho_expt*Ls_expt)^2./3;

