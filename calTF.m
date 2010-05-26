function TFout = calTF(TFin,TFnumerator,TFdenominator)
    % calibtrates a transfer function
    %
    %   TFout = calTF(TFin,TFnumerator,TFdenominator)
    %
    %   Each element in TFout is multiplied by the corresponding element
    %   in TFnumerator and divided by the corresponding element in
    %   TF denominator. Can be used with only 2 arguments and TFdenominator
    %   is considered to be unity.
    %
    %   with frequency columns, if TF numerator or TF denominator don't 
    %   have the same frequency column, it will be interpolated using interp1.
    
    fcolumn = 0;
    if size(TFin,2) == 2
        fcolumn = 1;
    end
    
    if nargin<3
        TFdenominator = TFin(:,1); 
        TFdenominator(:,fcolumn+1) = ones(size(TFin,1),1);
    end
    
    % interpolate here
    
    if fcolumn
        if length(TFin(:,1))~=length(TFnumerator(:,1)) || ~all( TFin(:,1) == TFnumerator(:,1) )
            TFnumInterp = interp1(TFnumerator(:,1),TFnumerator(:,2),TFin(:,1),'linear','extrap');
            TFnumerator = [TFin(:,1),TFnumInterp];
        end
        if length(TFin(:,1))~=length(TFdenominator(:,1)) || ~all( TFin(:,1) == TFdenominator(:,1) )
            TFdenInterp = interp1(TFdenominator(:,1),TFdenominator(:,2),TFin(:,1),'linear','extrap');
            TFdenominator = [TFin(:,1),TFdenInterp];
        end
    end
    
    TFout = TFin(:,1);
    
    TFout(:,fcolumn+1) = TFin(:,fcolumn+1) .* TFnumerator(:,fcolumn+1) ./ TFdenominator(:,fcolumn+1);    
end