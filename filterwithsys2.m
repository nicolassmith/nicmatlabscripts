function dataout = filterwithsys2(sys,data,fs)
    % dataout = filterwithsys(sys,data,fs)
    if isnumeric(sys)
        sys = zpk([],[],sys);
    end
    [z,p,k] = zpkdata(sys,'v');
    
    [zd,pd,kd] = bilinear(z,p,k,fs);
    [sos,g] = zp2sos(zd,pd,kd);
    dataout = real(g)*sosfilt(sos,data);
end