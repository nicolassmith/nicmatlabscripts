function psd2=applysysf(sys,f,psd)

psd2=applysys(sys,2*pi.*f,psd);