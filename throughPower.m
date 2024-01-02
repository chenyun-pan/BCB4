%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot throughput-power for aset of devices
%   Title:      throughPower.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%   Author:     Dmitri E Nikonov
%   Date:       11/07/2011
%   (C) Dmitri E. Nikonov 2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf
malkegl = 10;
malkegdot = 9;
powLimit = 10;
thruput = 1e8./aplot./tplot;
if cop.pipeline == 1
    thruput = thruput*16;   % delay is half clock cycle
    thruput(28) = thruput(28)*2/3;    % SWD 3-phase clocking
end
power = thruput.*Eplot/1e3 + 1e-4.*Splot./aplot;    % 
% power = thruput.*Eplot/1e3 ;
kp = find(power>powLimit);
thruput(kp)= thruput(kp)*powLimit./power(kp);
power(kp) = powLimit;

% figure(nfi+9)
ll = {'CMOS','TFETs','Ferroelectric','Others','Spintronics'}; i = 1; ind = 1:2; % {'CMOS','TFETs','Ferroelectric','Others','Spintronics'}
h(i) = loglog(thruput(1:2),power(1:2),'o','MarkerFaceColor','g','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on; i = i+1;
h(i) = loglog(thruput(3:7),power(3:7),'o','MarkerFaceColor','r','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on; i = i+1;
h(i) = loglog(thruput(8:10),power(8:10),'o','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on; i = i+1;
h(i) = loglog(thruput(11:15),power(11:15),'o','MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on; i = i+1;
h(i) = loglog(thruput(16:end),power(16:end),'o','MarkerFaceColor','c','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on; i = i+1;
legend(ll,'location','southwest','FontWeight','bold')
set(gca,'FontSize',malkegl,'linewidth',1.5)
xlabel('Throughput Density, TIOPS/cm^2')
ylabel('Power Density, W/cm^2')
captfact = exp(0.3*(2*rand(size(power))-1));
axis(diathru)
text(thruput.*1.15,power.*captfact,caey,'FontSize',malkegl)
title(titna)

% powAct = Eplot./tplot.*1e-3;            % active power, W
% figure(nfi+8)
% loglog(Splot,powAct,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',malkegdot)
% set(gca,'FontSize',malkegl,'FontWeight','bold')
% xlabel('Standby Power, W')
% ylabel('Active Power, W')
% captfact = exp(0.3*(2*rand(size(powAct))-1));
% text(Splot.*1.3,powAct,dn,'FontSize',malkegl)
% %axis([1e-3 1e1 1e-2 1e2])
% title(titna)
