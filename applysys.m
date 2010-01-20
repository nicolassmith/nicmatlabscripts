function psdfilt=applysys(sys,f,psd)

[mag,phase]=bode(sys,f);
S=size(psd);
if S(1)>S(2)
    mag1D=make1D(mag);
else
    mag1D=make1D(mag)';
end

psdfilt=mag1D.*psd;