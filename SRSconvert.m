function M=SRSconvert(F)

% convertPath should point to SRT785.EXE on windows systems and
%     nic's 78DtoMAT script on linux systems. If dosbox gives library
%     errors, it's because MATLAB is using its own c++ libraries.
%     You must make it use good libraries in /usr/lib for example.
convertPath = ...
'"/usr/bin/78DtoMAT"';

if(~exist(F,'file')) 
    error(['File ',F,' doesn''t exist!']);
end

suf = F(end-2:end);
if(strcmp(suf,'78D'))
    newF = [F(1:end-3),'mat'];
else
    newF = [F,'.mat'];
end

command = [convertPath,' /Omat ',F,' ',newF];

if(exist(newF,'file'))
    warning('SRSconvert:exist','name exist, not convert');
else
    system([command,'']);
end

S=load(newF);
fldname = char(fieldnames(S));
M=S.(fldname); 

