function frdout = ZIloadTF(datalocation)
    % frd = ZILoadTF(dataloacation)
    % function to load a TF measurement made by ZI HF2 into an frd object
    
    F_COLUMN = 1;
    A_COLUMN = 8;
    PHI_COLUMN = 9;
    
    rawdata = load([datalocation '/Data.csv']);
    
    f = rawdata(:,F_COLUMN);
    A = 10.^(rawdata(:,A_COLUMN)/20);
    phi = pi/180*rawdata(:,PHI_COLUMN);
    
    frdout = frd(A.*exp(1i*phi),f,'FrequencyUnit','Hz');
    frdout.Name = ['HF2 data: ' datalocation];
end