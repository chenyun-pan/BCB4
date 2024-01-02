%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Non-local Spin-Valve (NLSV) including both in-plane and PMA cases
% Title:      analytics_ASL.m
% Author: Sou-Chi Chang and Chenyun Pan
% Last modified: 5/31/2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tau, Energy, Isc, Eb, beta, Is] = analytics_ASL(vdd,Lc_n,cop)
%% Physical constants
hbar = 6.58e-16; % reduced Plank constant (eV*sec)
T = 300; % temperature (Kelvin)
kT = (0.026/300)*T; % (eV)
mu0 = 4*pi*1e-7; % free space permeability (joule*A^-2*m^-1)
muB = 9.27e-24; % Bohr magneton (joule*T^-1)
q = 1.6e-19; % (C)

%% material parameters
alpha = 0.01; % damping coefficient
beta = cop.sppol;
if strcmp(cop.name,'ASL')
    L_f = 15e-9; W_f = 45e-9; t_f = 3e-9;
    Ms = 1e6; % saturation magnetization (A/m)
    [Nxx, ~, Nzz] = demag(L_f,t_f,W_f,'cuboid'); % demagnetization tensor
    Eb = (Nxx - Nzz)*(Ms^2)*mu0*(L_f*t_f*W_f)/2/0.026/q; % energy barrier (1/kbT)
    theta = sqrt(1/2/Eb); % initial angle due to thermal noise (rad)
end
if strcmp(cop.name,'ASL-PMA')
    Ku = 6e4; % PMA energy density (J/m^3)
    Ms = 3e5;
    W_f = 30e-9; L_f = 30e-9; t_f = 3e-9;
    Eb = Ku*L_f*W_f*t_f/0.026/q; % energy barrier (kb*T)
    theta = sqrt(1/2/Eb); % initial angle due to thermal noise (rad)
end
if strcmp(cop.name,'ASL-HA')
    Ms = 400e3; Ku = 2.6e6; beta = .8; alpha = .005; % PMA energy density (J/m^3)
    W_f = 15e-9; L_f = 15e-9; t_f = 2e-9;
    Eb = Ku*L_f*W_f*t_f/0.026/q; % energy barrier (kb*T)
    theta = sqrt(1/2/Eb); % initial angle due to thermal noise (rad)
end
if strcmp(cop.name,'ASL-HAs')
    W_f = 15e-9; L_f = 15e-9; t_f = 2e-9; 
    Ms = 100e3; Ku = 2.6e6; beta = .8; alpha = .005;
    Eb = Ku*L_f*W_f*t_f/0.026/q; % energy barrier (kb*T)
    theta = sqrt(1/2/Eb); % initial angle due to thermal noise (rad)
end

if Lc_n > 10e-6; tau = Inf; Energy = Inf; Isc = 0; return; end

rho_f = 7.5e-8; % resistivity (Ohm*m)
R_f = rho_f*t_f/L_f/W_f;

Ic = vdd/(cop.Rwiring+R_f);
Jc = Ic/L_f/W_f;
Js = beta*Jc; % spin current density (A/m^2)

% non-magnetic metal (Cu)
t_n = 20e-9; % channel thickness (m)
W_n = 120e-9; % channel width (m)
Lg_n = 10e-6; % shunt path (m)
p = 1; R = 0.1; % specularity and reflectivity
d = t_n; % spacing between grain boundaries (m)
AR = t_n/W_n; % aspect ratio
[rho_eff_cu,~,~,~,~,Lsn_cu] = rho_metal_copper(R,p,W_n*1e9,AR,d*1e9);
lsf_n = Lsn_cu*1e-2; % spin relaxation length (m)
rho_n = rho_eff_cu*1e-2; % resistivity (Ohm*m)
sigma_up_n = 1/2/rho_n; % up-spin conductivity (1/Ohm/m)
sigma_down_n = 1/2/rho_n; % down-spin conductivity (1/Ohm/m)
sigma_n = sigma_up_n + sigma_down_n; % conductivity (1/Ohm/m)

%% Spin diffusion equation for nlsv
a1 = sigma_n/lsf_n;
M = zeros(4,4);
M(1,1) = exp(Lc_n/lsf_n); M(1,2) = exp(-Lc_n/lsf_n);
M(2,1) = 1; M(2,2) = 1; M(2,3) = -1; M(2,4) = -1;
M(3,1) = a1; M(3,2) = -a1; M(3,3) = a1; M(3,4) = -a1;
M(4,3) = exp(Lg_n/lsf_n); M(4,4) = exp(-Lg_n/lsf_n);
b = zeros(4,1);
b(3,1) = Js;
a = M\b;
A = a(1,1); B = a(2,1); C = a(3,1); D = a(4,1);

%% Analytical expression for Js at the end of the channel
Js_end = Js*sinh(Lg_n/lsf_n)/( sinh(Lc_n/lsf_n)*cosh(Lg_n/lsf_n) + sinh(Lg_n/lsf_n)*cosh(Lc_n/lsf_n) );
if strcmp(cop.name,'ASL') % For the in-plane case,
    Jsc = alpha*t_f*mu0*(Ms^2)/hbar; % (A/m^2)
    if (Js_end > Jsc)
        tau = q*Ms*t_f*log(pi/2/theta)/muB/(Js_end - Jsc)/1e-9; % (ns)
    else % no switching
        tau = Inf;
    end
else
    Jsc = 2*alpha*Ku*t_f/hbar; % (A/m^2)
    if (Js_end > Jsc)
        tau = abs(q*Ms*t_f*log(pi/2/theta)/muB/(Js_end - Jsc)/1e-9); % (ns)
    else % no switching
        tau = Inf; 
    end
end
Energy = (Ic^2)*(cop.Rwiring+R_f)*tau*(1e-9)*1e15; % (joule)
Isc = Jsc*L_f*W_f;
Is = Js_end*L_f*W_f;













