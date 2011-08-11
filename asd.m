function [A]= asd(data, Fs, resolution, WindowName, ...
   OverlapPercent, verbose)
%===============================================
% Function A = asd(d, Fs, resolution, WindowName, ...
%   OverlapPercent, verbose)
%
%  computes the amplitude spectral density 
%  using Welch's method
%  default rate = 16384
%  default_resolution = 1;
%  default_window     = 'Hann';
%  default_overlap    = 50;
%  default_verbose    = 0;  
%
% L.Cadonati, 2007-05-13
%
% Ex 1:  A = asd(data, 16384, 0.125)
%===============================================

error(nargchk(1, 6, nargin));
%====================================
default_rate = 16384;
default_resolution = 1;
default_window     = 'Hann';
default_overlap    = 50;
default_verbose    = 0;
%====================================
if nargin == 1,
  Fs = default_rate;
  resolution = default_resolution;
  WindowName = default_window;
  OverlapPercent = default_overlap;
  verbose = default_verbose;
 
elseif nargin == 2,
  resolution = default_resolution;
  WindowName = default_window;
  OverlapPercent = default_overlap;
  verbose = default_verbose;
elseif nargin == 3,
  WindowName = default_window;
  OverlapPercent = default_overlap;
  verbose = default_verbose;
elseif nargin == 4,
  OverlapPercent = default_overlap;
  verbose = default_verbose;
elseif nargin == 5,
  verbose = default_verbose;
end  
%====================================


% force row vector
data = data(:)';

% segment lengths
SegmentDuration = 1/resolution;
SegmentLength   = Fs*SegmentDuration;

% ensure integer power of two segment length
log2SegmentLength = log(SegmentLength) / log(2);
if log2SegmentLength ~= floor(log2SegmentLength),
  error('rate / resolution must be an integer power of two');
end

if (verbose), 
  fprintf('duration       = %g\n',SegmentDuration); 
  fprintf('segmentLength  = %g\n',SegmentLength); 
end

h = spectrum.welch(WindowName,SegmentLength,OverlapPercent);
Hpsd = psd(h,data,'Fs',Fs);

A = struct('Name','Amplitude Spectral Density',...
           'x',sqrt(Hpsd.Data),'f',Hpsd.Frequencies);

