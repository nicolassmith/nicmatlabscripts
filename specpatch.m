function fullspec = specpatch(varargin)
% input many spectra as arguments and this function will patch them together. 
% low frequency spectra get priority. first column should be f.
specs=varargin;
n=length(specs);

hflimits = zeros(n,1);
for k = 1:n
    hflimits(k)=specs{k}(end,1);
end

[limitsort,ix] = sort(hflimits);

curlimit = 0;
fullspec = [0,0];
for n = ix'
    m=1;
    while curlimit > specs{n}(m,1)
        m=m+1;
    end
    curlimit=hflimits(n);
    %disp(num2str(curlimit))
    l_0=length(fullspec(:,1))-1;
    %disp(num2str(l_0))
    %disp(num2str(m))
    for l = m:length(specs{n}(:,1))
        fullspec(l+l_0-m+1,:) = specs{n}(l,:);
    end
end



