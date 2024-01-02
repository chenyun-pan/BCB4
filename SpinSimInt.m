%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Interconnect focused study for spintronic devices
%   Title:      SpinSimInt.m
%   Author:     Chenyun Pan
%   Date:       5/31/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function bey = SpinSimInt(bey,cop)

lw = 100e-6;        % length of interconnect
n = round(logspace(0,log10(lw/60e-9),30));    % number of repeaters
for j = 1:length(n)
    if strcmp(cop.name(1:3),'ASL')
        [td(j), energy(j)] = analytics_ASL(bey.volt,lw/n(j),cop); % delay and energy per stage
    end
    if strcmp(cop.name(1:3),'CSL')
        [td(j), energy(j)] = analytics_CSL(bey.volt,lw/n(j),cop);  % delay and energy per stage
    end
    if strcmp(cop.name,'mLogic')
        [td(j), energy(j)] = analytics_mLogic(bey.volt,lw/n(j),cop);  % delay and energy per stage
    end
    if strcmp(cop.name,'SWD')
        n(j) = round(lw/cop.licsp); td(j) = bey.tic*1e9; energy(j) = bey.Eic*1e15;
    end
    if strcmp(cop.name(1:3),'MEM')
        td(j) = (lw/n(j)/cop.licsp*bey.tic+bey.tint)*1e9;    % voltage-driven
        energy(j) = (bey.Eint+lw/n(j)/cop.licsp*bey.Eic)*1e15;
    end
    if strcmp(cop.name,'CoMET')
        td(j) = (lw/n(j)/cop.licsp*bey.tic+bey.tint)*1e9;    % voltage-driven
        energy(j) = (bey.Eint+lw/n(j)/cop.licsp*bey.Eic)*1e15;
    end
    edp0(j) = energy(j)*td(j)*n(j)*n(j);    % energy-delay product
end
[~,temp] = min(edp0); nrep = round(n(temp));     % find optimal number of repeaters
twire = td(temp);
Ewire = energy(temp);
EDPwire = edp0(temp);
bey.twire = twire*n(temp)/1e9; bey.Ewire = Ewire*n(temp)/1e15;

% % % span of control
lw = logspace(-7,-3,30);
td = []; energy = [];
for i = 1:length(lw)
    if strcmp(cop.name(1:3),'ASL')
        [td(i), energy(i)] = analytics_ASL(bey.volt,lw(i),cop); 
    end
    if strcmp(cop.name(1:3),'CSL')
        [td(i), energy(i)] = analytics_CSL(bey.volt,lw(i),cop); 
    end
    if strcmp(cop.name,'mLogic')
        [td(i), energy(i)] = analytics_mLogic(bey.volt,lw(i),cop); 
    end
    if strcmp(cop.name,'SWD')
        td(i) = bey.tic*lw(i)/500e-9; 
        if lw(i)>500e-9; td(i) = Inf; end 
        energy(i) = bey.Eic*1e15;
    end
    if strcmp(cop.name(1:3),'MEM')
        td(i) = (lw(i)/cop.licsp*bey.tic+bey.tint)*1e9;    % voltage-driven
        energy(i) = (bey.Eint+lw(i)/cop.licsp*bey.Eic)*1e15;
    end
    if strcmp(cop.name,'CoMET')
        td(i) = (lw(i)/cop.licsp*bey.tic+bey.tint)*1e9;    % voltage-driven
        energy(i) = (bey.Eint+lw(i)/cop.licsp*bey.Eic)*1e15;
    end
end
span = lw(sum((td*1e-9)<cop.target*bey.tint)); % find span @ given timing target
Aspan = 2*span.^2; 
bey.Nspan = Aspan./bey.anan; 
end



















