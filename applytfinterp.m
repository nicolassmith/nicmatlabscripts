
function varargout = applytfinterp(TF,ASD)
%applies a transfer function linearly interpolated between points
%to asd.

% TF and ASD should be two column matrix with frequency in first column,
% second column should be ASD or complex TF.

tfint = interp1(TF(:,1),TF(:,2),ASD(:,1),'linear','extrap');

varargout{1} = [ ASD(:,1), abs(tfint) .* ASD(:,2) ];

if nargout>1
    varargout{2} = [ ASD(:,1), tfint ];
end

%%%%%%% Depreciated old version %%%%%%%%
% function psd2 = applytfinterp(tf,ftf,psd,fpsd)
% %applies a transfer function linearly interpolated between points
% %to psd.
% 
% tfint = interp1(ftf,tf,fpsd);
% 
% psd2 = tfint .* psd ;