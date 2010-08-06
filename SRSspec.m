function SRSspec(varargin)

%colorlist = {'k','r','b','g','c','m','y'};
colorlist = { [1 1 1], [1 0 0], [0 1 0], [0 0 1], [1 1 0], [.75 .25 .75], [0 1 1] };
for j=1:length(varargin)
    M=varargin{j};
    %fldname = char(fieldnames(S));
    %M=getfield(S,fldname);
    loglog(M(:,1),M(:,2),'Color',colorlist{mod(j,length(colorlist))+1})
    hold on
end
grid on
axis tight
xlabel('Frequency (Hz)')
ylabel('Magnitude')
hold off