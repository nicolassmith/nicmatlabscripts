function SRSbode(varargin)

% check for options
unwrapflag = 0;

flagIndex = find(strncmp(varargin,'-',1),2); % find the option flag
if length(flagIndex)>1
    error('Please only use the option flag "-" once in arguments.')
end

if flagIndex
    if any(varargin{flagIndex}=='u') || any(varargin{flagIndex}=='U')
        unwrapflag = 1; % unwrap flag
    end
    varargin = {varargin{1:end~=flagIndex}}; % remove options from the arguments
end

colorlist = {'r','b','g','c','m','y','k'};
for j=1:length(varargin)
    M=varargin{j};
    subplot(2,1,1)
    loglog(M(:,1),abs(M(:,2)),colorlist{mod(j,length(colorlist))})
    hold on
    subplot(2,1,2)
    if(unwrapflag)
        semilogx(M(:,1),180/pi*unwrap(angle(M(:,2))),colorlist{mod(j,length(colorlist))})
    else
        semilogx(M(:,1),180/pi*angle(M(:,2)),colorlist{mod(j,length(colorlist))})
    end
    hold on
    maxnow = max(M(:,1));
    minnow = min(M(:,1));
    if ~exist('minf','var') || minnow<minf
        minf = minnow;
    end
    if ~exist('maxf','var') || maxnow>maxf
        maxf = maxnow;
    end
end

subplot(2,1,1)
title('Bode Diagram')
ylabel('Magnitude')
xlim([minf,maxf])
ylim('auto')
grid on
hold off
subplot(2,1,2)
xlabel('Frequency (Hz)')
ylabel('Phase (deg)')
xlim([minf,maxf])
if(unwrapflag)
    ylim('auto')
else
    ylim([-200,200])
end
grid on
hold off
