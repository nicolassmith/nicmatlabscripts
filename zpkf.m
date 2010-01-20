function SYS=zpkf(Zeros,Poles,Gain)
%this takes zeros and poles in Hz and makes a sys type with
%zeros and poles in rad/s

SYS=zpk(2*pi.*Zeros,2*pi.*Poles,Gain);