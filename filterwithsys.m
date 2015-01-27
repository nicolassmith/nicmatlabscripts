function dataout = filterwithsys(sys,data,fs)
    % dataout = filterwithsys(sys,data,fs)
    if isnumeric(sys)
        sys = zpk([],[],sys);
    end
    sysd = c2d(sys,1/fs,'tustin');
    [a,b]=tfdata(sysd,'v');
    dataout = filter(a,b,data);
end