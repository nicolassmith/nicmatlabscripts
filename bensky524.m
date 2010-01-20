% bensky's homework
T=50; %range
%% Question 1.
t=0:.1:T;
figure(1)
plot(t,dampcos(t))
%% further questions.
N=100;
a=zeros(N,1);
b=zeros(N,1);
for n=1:N
    a(n)=2/T*quad(@(x)dampcos(x).*cos(2*pi/T*x*n),0,T,1E-7);
    b(n)=2/T*quad(@(x)dampcos(x).*sin(2*pi/T*x*n),0,T,1E-7);
end
k=1:N;
figure(2)
fplot(@(x)cos(k*2*pi/T*x)*a+sin(k*2*pi/T*x)*b,[0 T])
figure(3)
plot(2*pi/50*k,[a b])