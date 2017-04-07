function DEINTER = jiejiaozhi( code, zes, Ncbps, Nbpsc)
%接收数据
Data = code;
DataNum = length(Data);
DevideNum = DataNum / Ncbps;

NewD = zeros(1, DataNum);
Nend = zeros(1, DataNum);
%第一次解置换
s = max(Nbpsc/2, 1);
for p = 0 : DevideNum - 1
    for j = 0 : Ncbps - 1
        t1 = Data(1, (p * Ncbps) + (j + 1));
        i = s*floor(j/s)+mod((j+floor(16*j/Ncbps)), s);
        NewD(1, p * Ncbps + (i+1)) = t1;
    end
end
%第二次解置换
for m = 0 : DevideNum - 1
    for i =0 : Ncbps - 1
        t1 = NewD(1,(m * Ncbps) + (i + 1));
        k = 16 * i - (Ncbps-1) * floor(16 * i/Ncbps);
        Nend(1, m * Ncbps + (k + 1)) = t1;
    end
end
Nend(:, DataNum - zes + 1 : DataNum) = [];
DEINTER = Nend;
