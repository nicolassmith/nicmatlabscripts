function spec = SRSloadspec(filename)

    if iscell(filename)
        spec = {};
        for name=filename
           spec = [spec,{SRSloadspec(name{:})}]; %#ok<AGROW>
        end
        return;
    end
            

    M = SRSconvert(filename);
    
    spec = asddata(M(:,2),M(:,1));
end