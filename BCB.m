%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   comparison beyond CMOS devices with multiple circuits
%   Title:      BCB.m
%   Updated by: Chenyun Pan
%   Last modified: 1/15/2018
%   Author:     Dmitri E Nikonov
%   Date:       01/01/2012
%   (C) Dmitri E. Nikonov 2012

%   Modeling approaches and assumptions are described in the following papers:
%   Chenyun Pan and Azad Naeemi, “An Expanded Benchmarking of Beyond-CMOS Devices Based on Boolean and Neuromorphic Representative Circuits,” IEEE Journal of Exploratory Solid-State Computational Devices and Circuits (JxCDC), Janurary, 2018.
%   Dmitri E. Nikonov and Ian A. Young, "Benchmarking of beyond-CMOS exploratory devices for logic integrated circuits." IEEE Journal on Exploratory Solid-State Computational Devices and Circuits 1 (2015): 3-11.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
% figure
clf; 
cop.pipeline = 0; cop.target = 300;
cop.leak = 0;
cop.outInv = 'n';
cop.outAdd = 'n';
cop.outAlu = 'n';
cop.ploPow = 'n';
cop.plotCNN = 'n';
cop.plotEDwire = 0;
cop.plottspan = 0;

% cop.outInv = 'y';
cop.outAlu = 'y';         % ALU
% cop.ploPow = 'y'; cop.outAdd = 'y'; cop.pipeline = 1;     % power vs. throughput
% cop.plotCNN = 'y';          % CNN
% % cop.plotEDwire = 1;       % Interconnect
% cop.plottspan = 1;        % Interconnect 
% cop.leak = 1; cop.pipeline = 0; 
NRIrev7

%%
cop.plotYear = 'n';
cop.outNand = 'n';
cop.outXor = 'n';
cop.outMux = 'n';
cop.outRam = 'n';
cop.outSe = 'n';
cop.ploCurr = 'n';
cop.wriArea = 'n';
cop.ploUniv = 'n';

% rescaling plots for energy-delay
mnove = 100;mnoni = 1;mnopr = 10;mnole = 1;
if(strcmp(cop.outAdd,'y'))          % 32-bit adder
    titna = '32-bit Adder';
    aplot = mey(16,:)*1e12;
    tplot = mey(17,:)*1e12;
    Eplot = mey(18,:)*1e15;
    Splot = mey(54,:);
    marcol = 'b';
    diap = [1e2*mnole .2e6*mnopr 1e-1*mnoni 1e4*mnove];
    nfi = 130;
    if(strcmp(cop.ploPow,'y'))
        diathru = [1e-2 1e5 1e-2 3e1];
        throughPower
    else
%         diathru = [1e-1 1e5 1e-2 3e1];
        plotNRI
    end
end
if(strcmp(cop.outAlu,'y'))         % 32-bit ALU
    titna = '32bit ALU';
    aplot = mey(46,:)*1e12;
    tplot = mey(47,:)*1e12;
    Eplot = mey(48,:)*1e15;
    Splot = mey(64,:);
    marcol = 'b';
    diap = [1e2 1e7 1 1e6]; 
    nfi = 180;
    plotNRI
    if(strcmp(cop.ploPow,'y'))
    diathru = [1e-2 1e4 1e-2 3e1];
    throughPower
    end
end
if cop.plotEDwire > 0               % interconnect
    titna = 'Interconnect Energy vs. Delay';
%     aplot = mey(7,:)*1e12;
    tplot = mey(84,:)*1e12;
    Eplot = mey(85,:)*1e15;
    diap = [1e0 1e6 1e-2 1e5];
    plotNRI
end
if(strcmp(cop.plotCNN,'y'))         % CNN
    titna = 'Cellular Neural Network';
%     aplot = mey(46,:)*1e12;
    tplot = mey(92,:)*1e12;
    Eplot = mey(93,:)*1e15;
%     Splot = mey(64,:);
    marcol = 'b';
    diap = [1e2 1e6 1e1 1e5];
    nfi = 180;
    plotNRI
end

if cop.plottspan > 0
    titna = 'Span-of-Control';
    plotNRI
end
%%
if(strcmp(cop.outInv,'y'))
titna = 'Inverter';
aplot = mey(19,:)*1e12;
tplot = mey(20,:)*1e12;
Eplot = mey(21,:)*1e15;
% titna = 'INVFO4';
% aplot = mey(7,:)*1e12;
% tplot = mey(8,:)*1e12;
% Eplot = mey(9,:)*1e15;
marcol = 'b';
diap = [1e-1 1e5 1e-5 1e2];
nfi = 110;
plotNRI
end
if(strcmp(cop.outNand,'y'))
titna = 'NAND2';
aplot = mey(10,:)*1e12;
tplot = mey(11,:)*1e12;
Eplot = mey(12,:)*1e15;
marcol = 'b';
diap = [1e0*mnole 1e4*mnopr 1e-5*mnoni 1e1*mnove];
nfi = 120;
plotNRI
end

if(strcmp(cop.outXor,'y'))
titna = 'XOR';
aplot = mey(22,:)*1e12;
tplot = mey(23,:)*1e12;
Eplot = mey(24,:)*1e15;
marcol = 'b';
diap = [1e0*mnole 1e4*mnopr 1e-4*mnoni 1e2*mnove];
nfi = 140;
plotNRI
end
if(strcmp(cop.outMux,'y'))
titna = 'MUX';
aplot = mey(31,:)*1e12;
tplot = mey(32,:)*1e12;
Eplot = mey(33,:)*1e15;
marcol = 'b';
diap = [1e0*mnole 1e5*mnopr 1e-3*mnoni 1e2*mnove];
nfi = 150;
plotNRI
end
if(strcmp(cop.outRam,'y'))
titna = 'Register Bit';
aplot = mey(40,:)*1e12;
tplot = mey(41,:)*1e12;
Eplot = mey(42,:)*1e15;
marcol = 'b';
diap = [1e0*mnole 1e4*mnopr 1e-3*mnoni 1e1*mnove];
nfi = 160;
plotNRI
end
if(strcmp(cop.outSe,'y'))
titna = 'State Element';
aplot = mey(37,:)*1e12;
tplot = mey(38,:)*1e12;
Eplot = mey(39,:)*1e15;
marcol = 'b';
diap = [1e0*mnole 1e5*mnopr 1e-3*mnoni 1e1*mnove];
nfi = 170;
plotNRI
end

% additional processing
if(strcmp(cop.ploCurr,'y'))
    TransCurrents
end
if(strcmp(cop.wriArea,'y'))
    areaNRI
end
if(strcmp(cop.ploUniv,'y'))
   universalDevice
end
