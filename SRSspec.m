function SRSspec(varargin)

colorlist = {'r','b','g','c','m','y','k'};
for j=1:length(varargin)
    M=varargin{j};
    %fldname = char(fieldnames(S));
    %M=getfield(S,fldname);
    loglog(M(:,1),M(:,2),colorlist{mod(j,length(colorlist))})
    hold on
end
grid on
axis tight
xlabel('Frequency (Hz)')
ylabel('Magnitude')
hold off