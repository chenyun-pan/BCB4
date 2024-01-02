%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot universal charge-resistance characteristics for devices
%   Title:      universalDevice.m
%   Author:     Dmitri E Nikonov
%   Date:       04/06/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NRIrev6
polimya = fieldnames(bey);
npo = length(polimya);
for k = 1:npo
    if(strcmp(polimya(k),'tint')); tint = mey(k,:)*1e12; end
    if(strcmp(polimya(k),'Eint')); Eint = mey(k,:)*1e15; end
    if(strcmp(polimya(k),'tadd')); tadd = mey(k,:)*1e12; end
    if(strcmp(polimya(k),'Eadd')); Eadd = mey(k,:)*1e15; end
    if(strcmp(polimya(k),'volt')); volt = mey(k,:);      end
    if(strcmp(polimya(k),'Qeff')); Qeff = mey(k,:)./eelec; end
    if(strcmp(polimya(k),'Idev')); Idev = mey(k,:).*1e6; end
    if(strcmp(polimya(k),'Reff')); Reff = mey(k,:);      end
    if(strcmp(polimya(k),'Ceff')); Ceff = mey(k,:).*1e18;end
end
Edint = Eint.*tint;
Edadd = Eadd.*tadd;
trat = tadd./tint;
Erat = Eadd./Eint;
Edrat = Edadd./Edint;
hfull = 2*pi*hbar;
Rquant = hfull/eelec/eelec;
QQR = Qeff.*Qeff.*Reff./Rquant;
Ednat = Edint./hfull.*1e-27;
malkegl = 12;
tolsh = 2;
marcol = 'b';
sdvig = 1.1;

figure(601)
loglog(tint,trat,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',10)
set(gca,'FontSize',malkegl,'FontWeight','bold')
xlabel('Device Delay, ps')
ylabel('Adder/Device Delay')
text(tint.*sdvig,trat.*sdvig,dn,'FontSize',malkegl)

figure(602)
loglog(Eint,Erat,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',10)
set(gca,'FontSize',malkegl,'FontWeight','bold')
xlabel('Device Energy, fJ')
ylabel('Adder/Device Energy')
text(Eint.*sdvig,Erat.*sdvig,dn,'FontSize',malkegl)

figure(603)
loglog(Edint,Edrat,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',10)
set(gca,'FontSize',malkegl,'FontWeight','bold')
xlabel('Devics E*d, fJ\cdot{ps}')
ylabel('Adder/Device E*d')
text(Edint.*sdvig,Edrat.*sdvig,dn,'FontSize',malkegl)

figure(604)
loglog(volt,Qeff,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',10)
set(gca,'FontSize',malkegl,'FontWeight','bold')
xlabel('Voltage, V')
ylabel('Charge, e')
text(volt.*sdvig,Qeff.*sdvig,dn,'FontSize',malkegl)

figure(605)
loglog(volt,Idev,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',10)
set(gca,'FontSize',malkegl,'FontWeight','bold')
xlabel('Voltage, V')
ylabel('Current, \mu{A}')
text(volt.*sdvig,Idev.*sdvig,dn,'FontSize',malkegl)

figure(606)
loglog(Reff,Ceff,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',10)
set(gca,'FontSize',malkegl,'FontWeight','bold')
xlabel('Resistance, Ohm')
ylabel('Capacitance, aF')
text(Reff.*sdvig,Ceff.*sdvig,dn,'FontSize',malkegl)

figure(607)
loglog(Reff,Qeff,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',10)
set(gca,'FontSize',malkegl,'FontWeight','bold')
xlabel('Resistance, Ohm')
ylabel('Charge, e')
text(Reff.*sdvig,Qeff.*sdvig,dn,'FontSize',malkegl)

figure(608)
loglog(QQR,Ednat,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',10)
set(gca,'FontSize',malkegl,'FontWeight','bold')
xlabel('Q^2R, h')
ylabel('Energy*delay, h')
text(QQR.*sdvig,Ednat.*sdvig,dn,'FontSize',malkegl)
