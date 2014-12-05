function frdOut = SRSloadTF(filename)

    raw = SRSconvert(filename);
    
    frdOut = frd(raw(:,2),raw(:,1),'FrequencyUnit','Hz');
    frdOut.Name = ['SRS data: ' filename];
end