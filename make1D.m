function M=make1D(N);

n=length(N);
M=zeros(n,1);

for i=1:n
    M(i)=N(1,1,i);
end