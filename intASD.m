function I = intASD(AM,f1,f2)
% This takes a two-column matrix, first is frequency, second is the 
% amplitude spectral density. f1 and f2 are the low and high limits on 
% integration, if these aren't given, the whole ASD will be integrated.

if nargin < 3
    fs = AM(1,1);
    fe = AM(end-1,1);
else
    fs = f1;
    fe = f2;
end

intdomain = find(AM(:,1)>=fs & AM(:,1)<=fe);

Is=AM(intdomain,2).^2.*(AM(intdomain+1,1)-AM(intdomain,1));

%disp('hello')
I=sqrt(sum(Is));