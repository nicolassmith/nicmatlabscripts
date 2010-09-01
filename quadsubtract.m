function specOUT = quadsubtract(specA,specB)
    % subtracts two spectra in quadrature
    % specOUT = sqrt(specA^2 - specB^2);
    %
    % spectra art two column matricies with frequency in the first column
    % and amplitude spectral density in the second.
    %
    % in the case of specB>specA, the corresponding element in specOUT will be
    % NaN.
    
    if ~all(specA(:,1) == specB(:,1))
        error('frequency columns don''t match')
    end
    
    specOUT = [specA(:,1),sqrt(specA(:,2).^2 - specB(:,2).^2)];
    
    for kk = 1:size(specOUT,1)
        
        if ~isreal(specOUT(kk,2))
            specOUT(kk,2) = NaN;
        end
        
    end
    
end