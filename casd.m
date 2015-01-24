function [A]= casd(dataX, dataY, Fs, resolution, windowFunction, ...
   OverlapPercent, verbose)
%===============================================
% Function A = coherence(dataX, dataY, Fs, resolution, windowFunction, ...
%   OverlapPercent, verbose)
%
%  computes the coherence like mscohere
%  default rate = 16384
%  default_resolution = 1;
%  default_window     = @hanning; <- this is a function handle
%  default_overlap    = 50;
%  default_verbose    = 0;  
%
% Based on asd by L. Cadonati.
% Nicolas Smith-Lefebvre 2011
%
% Ex 1:  A = coherence(data, 16384, 0.125)
%===============================================

narginchk(2, 7);
%====================================
default_rate = 16384;
default_resolution = 1;
default_window     = @hanning;
default_overlap    = 50;
default_verbose    = 0;
%====================================
if nargin == 2,
  Fs = default_rate;
  resolution = default_resolution;
  windowFunction = default_window;
  OverlapPercent = default_overlap;
  verbose = default_verbose;
 
elseif nargin == 3,
  resolution = default_resolution;
  windowFunction = default_window;
  OverlapPercent = default_overlap;
  verbose = default_verbose;
elseif nargin == 4,
  windowFunction = default_window;
  OverlapPercent = default_overlap;
  verbose = default_verbose;
elseif nargin == 5,
  OverlapPercent = default_overlap;
  verbose = default_verbose;
elseif nargin == 6,
  verbose = default_verbose;
end  
%====================================


% force row vector
dataX = dataX(:).';
dataY = dataY(:).';

% segment lengths
SegmentDuration = 1/resolution;
SegmentLength   = Fs*SegmentDuration;

noverlap = OverlapPercent*SegmentLength/100;

% ensure integer power of two segment length
log2SegmentLength = log(SegmentLength) / log(2);
if log2SegmentLength ~= floor(log2SegmentLength),
  error('rate / resolution must be an integer power of two');
end

if (verbose), 
  fprintf('duration       = %g\n',SegmentDuration); 
  fprintf('segmentLength  = %g\n',SegmentLength); 
end

%h = spectrum.welch(windowFunction,SegmentLength,OverlapPercent);
%Hpsd = psd(h,data,'Fs',Fs);
[Pxy,F] = cpsd(dataX,dataY,windowFunction(SegmentLength),noverlap,SegmentLength,Fs);


A = struct('Name','Coherence',...
           'Axy',sqrt(abs(Pxy)),'f',F);
