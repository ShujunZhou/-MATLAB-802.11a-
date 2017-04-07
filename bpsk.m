function x=bpsk(code)
for k=1:length(code)
    if code(k) == 0
        x(k)=-1;
    else
        x(k)=1;
    end
end