function M=make1D(N)

warning('make1D:jerk','Hey jerk, there is a function that ships with MATLAB called squeeze')

n=length(N);
M=zeros(n,1);

for i=1:n
    M(i)=N(1,1,i);
end