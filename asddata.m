classdef asddata 
   properties
      asd = [];
      frequencies = [];
   end 
   methods
       % olverloaded builtins
       function asdout = mtimes(a,b)
           if isnumeric(a)
               scalar = a;
               asdin = b;
           elseif isnumeric(b)
               scalar = b;
               asdin = a;
           else
               error('Can''t muliply by nonumeric')
           end
           
           asdout = asddata(scalar*asdin.asd,asdin.frequencies);
           
       end
       % constructor
       function obj = asddata(asd,freq)
           if length(asd)~=length(freq)
               error('Frequency vector and asd vector must be same length')
           end
           obj.asd = asd;
           obj.frequencies = freq;
       end
       % other methods
       function rebinnedAsd=rebin(asdin,frequencies,useLinearInterp)
           
           sOld = (asdin.asd).^2;
           fOld = asdin.frequencies;
           fNew = frequencies;
           
           % adjust shapes
           if ~isvector(fOld)
               error('fOld must be a vector')
           end
           if ~isvector(fNew)
               error('fNew must be a vector')
           end
           
           fOld = fOld(:);
           fNew = fNew(:);
           
           % remove DC
           fOld = fOld(fOld~=0);
           sOld = sOld(fOld~=0);
           
           % numbers
           Nnew = numel(fNew);
           
           % interpolate old spectrum at new points
           sWarn = warning('off', 'MATLAB:interp1:NaNinY');
           if nargin > 3 && useLinearInterp
               sInterp = interp1(fOld, sOld, fNew);
           else
               sInterp = exp(interp1(log(fOld), log(sOld), log(fNew)));
           end
           warning(sWarn)
           
           % mix in interpolated values
           [fAll, nSort] = sort([fNew; fOld]);
           [~, nMap] = sort(nSort);
           
           % loop over spectra
           sNew = zeros(Nnew, 1);
           for m = 1:size(sOld, 2)
               sAll = [sInterp(:, m); sOld(:, m)];
               sAll = sAll(nSort);
               
               % loop over points
               for n = 1:Nnew
                   % integrate under bins
                   if n == 1
                       nn = 1:nMap(n);
                       df = fNew(n) - fAll(1);           % bin width
                   else
                       nn = nMap(n - 1):nMap(n);
                       df = fNew(n) - fNew(n - 1);       % bin width
                   end
                   
                   pNew = trapz(fAll(nn), sAll(nn));   % integrated power
                   sNew(n, m) = pNew / df;
                   
               end
           end
           
           rebinnedAsd = asddata(sqrt(sNew),fNew);
       end
   end
   methods(Static)
       function plot(varargin)
               
               %colorlist = {'k','r','b','g','c','m','y'};
               colorlist = { [1 1 1], [1 0 0], [0 1 0], [0 0 1], [1 1 0], [.75 .25 .75], [0 1 1] };
               for j=1:length(varargin)
                   M=varargin{j};
                   %fldname = char(fieldnames(S));
                   %M=getfield(S,fldname);
                   loglog(M.frequencies,M.asd,'Color',colorlist{mod(j,length(colorlist))+1})
                   hold on
               end
               grid on
               axis tight
               xlabel('Frequency (Hz)')
               ylabel('Magnitude')
               hold off
       end
       function fullspec = patch(varargin)
           
           specs=varargin;
           n=length(specs);
           
           for k = 1:n
               if isempty(varargin{k})
                   fullspec = asddata.patch(varargin{1:n~=k});
                   return
               end
           end
           
           hflimits = zeros(n,1);
           for k = 1:n
               %hflimits(k)=specs{k}(end,1);
               hflimits(k)=specs{k}.frequencies(end);
           end
           
           [~,ix] = sort(hflimits);
           
           curlimit = 0;
           specvec = [0,0];
           for n = ix'
               m=1;
               while curlimit > specs{n}.frequencies(m)
                   m=m+1;
               end
               curlimit=hflimits(n);
               %disp(num2str(curlimit))
               l_0=length(specvec(:,1))-1;
               %disp(num2str(l_0))
               %disp(num2str(m))
               for l = m:length(specs{n}.frequencies(:))
                   %specvec(l+l_0-m+1,:) = specs{n}(l,:) ;
                   specvec(l+l_0-m+1,:) = [specs{n}.frequencies(l) specs{n}.asd(l)] ;
               end
           end
           fullspec = asddata(specvec(:,2),specvec(:,1));
       end
   end % methods
end % classdef