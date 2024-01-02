%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot throughput-power for a set of devices
%   Title:      TransCurrents.m
%   Author:     Dmitri E Nikonov
%   Date:       05/09/2014
%   (C) Dmitri E. Nikonov 2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
malkegl = 10;
malkegdot = 9;
curon = mey(68,:);
curoff = mey(69,:);
Vdd = mey(65,:);
curoncuroff = curon./curoff;

figure(1011)
loglog(curoff,curon,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',malkegdot)
set(gca,'FontSize',malkegl,'FontWeight','bold')
xlabel('Off Current, A/m')
ylabel('On Current, A/m')
captfact = exp(0.3*(2*rand(size(curon))-1));
text(curoff.*1.3,curon.*captfact,dn,'FontSize',malkegl)
%axis([1e-3 1e1 1e-2 1e2])

figure(1012)
semilogy(Vdd,curoncuroff,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',malkegdot)
set(gca,'FontSize',malkegl,'FontWeight','bold')
xlabel('Voltage, V')
ylabel('On/Off Current, A/m')
captfact = exp(0.3*(2*rand(size(curon))-1));
text(Vdd.*1.07,curoncuroff.*captfact,dn,'FontSize',malkegl)
%axis([1e-3 1e1 1e-2 1e2])
