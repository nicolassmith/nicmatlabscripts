function bodeplotf(sys)
% this function will make a bode plot with Hz frequency axis

h=bodeplot(sys);    % Create a Bode plot with plot handle h.
p=getoptions(h);    % Create a plot options handle p.
p.FreqUnits = 'Hz'; % Modify frequency units.
setoptions(h,p);    % Apply plot options to the Bode plot and 
                    % render.