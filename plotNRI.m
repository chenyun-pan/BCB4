%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot delay-energy and other views of devices
%   Title:      plotNRI.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%   Author:     Dmitri E Nikonov
%   Date:       03/10/2012
%   (C) Dmitri E. Nikonov 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf

malkegl = 10;
malkegdot = 9;
udal = 1.2;
cop.plotAD = 'n';
cop.plotAE = 'n';
cop.plotDE = 'y';
cop.plotDP = 'n';
% Pplot = Eplot./tplot*1e-3;                  % active power, W
if(strcmp(cop.plotDE,'y'))
    % grid of lines
    tg = [1e-1 1e7]; for i= 1:20; Eg(i,:) = 10^(15-i)./tg; end
    if cop.plotEDwire == 2; tplot(3:15) = tplot(3:15)*1e10; end
    if cop.plottspan > 0; tplot = mey(2,:)*1e12; Eplot = mey(91,:); titna = 'Span of Control'; end
    if cop.plottspan > 0; diap = [.1 1e4 1e1 1e9]; end
    if(strcmp(cop.plotCNN,'y'))
        tplot(22) = Inf;
    end
    h(i) = loglog(tplot(1:2),Eplot(1:2),'o','MarkerFaceColor','g','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on; i = i+1;
    loglog(tplot(1:2),Eplot(1:2),'o','MarkerFaceColor','g','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on
    loglog(tplot(3:7),Eplot(3:7),'o','MarkerFaceColor','r','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on
    loglog(tplot(8:10),Eplot(8:10),'o','MarkerFaceColor','y','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on
    loglog(tplot(11:15),Eplot(11:15),'o','MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on
    loglog(tplot(16:end),Eplot(16:end),'o','MarkerFaceColor','c','MarkerEdgeColor','k','MarkerSize',malkegdot); hold on
    legend({'CMOS','Spintronics','TFETs','Ferroelectric','Others',},'location','northwest');
    set(gca,'FontSize',malkegl,'FontWeight','bold','linewidth',1.5)
    xlabel('Delay (ps)')
    ylabel('Energy (fJ)')
    text(tplot.*udal,Eplot,dn,'FontSize',malkegl)
    if strcmp(cop.outAlu,'y') || cop.plotEDwire > 0
        loglog(tplot(16:19),Eplot(16:19),':r','linewidth',1.5)
        loglog(tplot(20:23),Eplot(20:23),':r','linewidth',1.5)
        loglog(tplot(24:26),Eplot(24:26),':r','linewidth',1.5)
    end
    if strcmp(cop.plotCNN,'y')
        tdig = mey(96,1:2)*1e12; Edig = mey(97,1:2)*1e15;
        loglog(tdig,Edig,'^','MarkerFaceColor','m','MarkerEdgeColor','k','MarkerSize',malkegdot); 
        text([tdig(1)*1.3 tdig(2)/2],[Edig(1) 1.5*Edig(2)],{'Digital CMOS HP','Digital CMOS LV'},'color','m');
    end
    if(exist('diap','var')); axis(diap); end
    title(titna)
    for i = 1:size(Eg,1); p = loglog(tg,Eg(i,:),'Color',.7*[1 1 1],'LineStyle','--'); end
    if cop.plottspan > 0; ylabel('Number of Accessible NAND2 Gates'); end
end

if(strcmp(cop.plotAD,'y'))
%     figure(nfi+1)
    loglog(aplot,tplot,'o','MarkerFaceColor','b','MarkerEdgeColor','k','MarkerSize',malkegdot)
    set(gca,'FontSize',malkegl,'FontWeight','bold')
    xlabel('Area, \mu{m}^2')
    ylabel('Delay, ps')
    text(aplot.*udal,tplot.*udal,dn,'FontSize',malkegl)
    title(titna)
end
if(strcmp(cop.plotDP,'y'))
    figure(nfi+4)
    loglog(tplot,Pplot,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',malkegdot);
    set(gca,'FontSize',malkegl,'FontWeight','bold')
    xlabel('Delay, ps')
    ylabel('Active Power, W')
    text(tplot.*udal,Pplot,dn,'FontSize',malkegl)
    title(titna)
end
if(strcmp(cop.plotYear,'y'))
    figure(nfi+5)
    semilogy(tplot,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',malkegdot);
    set(gca,'FontSize',malkegl,'FontWeight','bold')
    h = gca;
    h.XTickLabel = ticknodes;
    xlabel('Node')
    ylabel('Delay, ps')
    title(titna)
    figure(nfi+6)
    semilogy(Eplot,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',malkegdot);
    set(gca,'FontSize',malkegl,'FontWeight','bold')
    h = gca;
    h.XTickLabel = ticknodes;
    xlabel('Node')
    ylabel('Energy, fJ')
    title(titna)
    figure(nfi+7)
    semilogy(tplot.*Eplot,'o','MarkerFaceColor',marcol,'MarkerEdgeColor','k','MarkerSize',malkegdot);
    set(gca,'FontSize',malkegl,'FontWeight','bold')
    h = gca;
    h.XTickLabel = ticknodes;
    xlabel('Node')
    ylabel('Energy \cdot Delay, ps \cdot fJ')
    title(titna)
end

