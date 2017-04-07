function  LeaderSequence = qiandaoma()
S = [0, 0, 1+1i, 0, 0, 0, -1-1i, 0, 0, 0, 1+1i, 0, 0, 0, -1-1i, 0, 0, 0, -1-1i, 0, 0, 0, 1+1i, 0, 0, 0, 0, 0, 0, -1-1i, 0, 0, 0,...
    -1-1i, 0, 0, 0, 1+1i, 0, 0, 0, 1+1i, 0, 0, 0, 1+1i 0, 0, 0, 1+1i, 0, 0];
L = [1, 1, -1, -1, 1, 1, -1, 1, -1, 1, 1, 1, 1, 1, 1,  -1, -1, 1, 1, -1, 1, -1, 1, 1, 1, 1, 1, -1, -1, 1, 1, -1, 1, -1,...
    1, -1, -1, -1, -1, -1, 1, 1, -1, -1, 1, -1, 1, -1, 1, 1, 1, 1];
S = (13/6)^(1/2)*S;
short = IFFT64(S);
shortcp = short(1:16);
short = shortcp;
for f = 1:9
    short = [short,shortcp];
end
short_str = short;
long = IFFT64(L);
long1 = long(33:64);
long2 = long(1:64);
long_str = [long1,long2,long2];
preamble = [short_str,long_str];
preamble(:,161) = preamble(:,161)*0.5 + preamble(:,1)*0.5;
preamble(:,1) = preamble(:,1)*0.5;
LeaderSequence = preamble;

end

