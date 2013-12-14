function prettyzpk(zpkmodel,frequencyrange)
    tp = 2*pi;
    flow = frequencyrange(1);
    fhigh = frequencyrange(2);

    [z,p,k] = zpkdata(zpkmodel);
    
    % uncell
    z = z{1};
    p = p{1};
    
    % limit range and convert to Hz    
    z = z(abs(z)/tp>flow&abs(z)/tp<fhigh)/(-tp);
    p = p(abs(p)/tp>flow&abs(p)/tp<fhigh)/(-tp);
    
    % display
    disp('Zeros:')
    disp(z)
    
    disp('Poles:')
    disp(p)
    
    disp('Gain:')
    disp(k)

end