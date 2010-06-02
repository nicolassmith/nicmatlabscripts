function varargout=DTTloadspec(dttdata)
% loads a DTT spectrum into several matricies, uses the first column
% of the input as the frequency, returns a bunch of two-clumn matricies
% with columns f and spectrum.
% example: [PIT,YAW] = DTTloadspec(dttstuff)

if ischar(dttdata) % if input argument is a filename
    dttdata = load(dttdata);
end

f=dttdata(:,1);

for j = 1 : nargout
    varargout{j}=[f,dttdata(:,j+1)];
end