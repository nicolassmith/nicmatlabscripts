function TF2 = tfinv(TF)
% inverse transfer function

TF2 = [ TF(:,1) , 1./TF(:,2) ];