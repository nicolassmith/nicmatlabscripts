function MM = HPload(filein)
    % loads ascii data from HP network analyzer
    
    [head,data] = hdrload(filein);
    
    % split column header
    cols = regexp(head(end,:),'"','split');
    % find real data column
    realcol = find(strcmp(cols,'Data Real'))/2;
    % imag
    imagcol = find(strcmp(cols,'Data Imag'))/2;
    
    if isempty(realcol)
        error('no real data column found')
    end
    if isempty(imagcol)
        error('no imaginary data column found')
    end
    
    MM = [data(:,1),data(:,realcol)+1i*data(:,imagcol)];
end