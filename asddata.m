classdef asddata 
   properties
      asd = [];
      frequencies = [];
   end 
   methods
       function obj = asddata(asd,freq)
           obj.asd = asd;
           obj.frequencies = freq;
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