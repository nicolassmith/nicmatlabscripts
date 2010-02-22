function data_out = blrmsseries(data_in,BP,LP)
% BLRMSSERIES
% returns a time series Band Limited RMS calculated from input time series
% 'data_in'
%
% usage: data_out = blrmsseries(data_in,BP,LP)
%
% data_in is input time series data, BP is dfilt object used for
% bandpassing, LP is dfilt object used for low passing.

% first bandpass the data using BP
passed = filter(BP,data_in);
fs=16384;
A = asd(passed,fs,0.25);
figure(1)
loglog(A.f,A.x)
hold on
% square
squared = passed.^2;

% low pass
meaned = filter(LP,squared);

% root
data_out = sqrt(meaned);