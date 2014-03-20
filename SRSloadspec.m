function spec = SRSloadspec(filename)

    M = SRSconvert(filename);
    
    spec = asddata(M(:,2),M(:,1));
end