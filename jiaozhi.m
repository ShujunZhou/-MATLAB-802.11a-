function [INTER, ZEROS] = jiaozhi( input_data, Ncbps, Nbpsc)
DataNum = length(input_data);

Mod = mod(DataNum, Ncbps);
t = Ncbps - Mod;
if t == Ncbps
    t = 0;
end
Data = input_data;
NewD = zeros(1, DataNum+t);
Nend = zeros(1, DataNum+t);
InputD = zeros(1, DataNum+t);
InputD(1:DataNum) = Data(1:DataNum);
Data = InputD;
DevideNum = (DataNum+t)/Ncbps;
Devide = reshape(Data, Ncbps, DevideNum);
Devide = reshape(Devide, 1, []);
Data = Devide;
s = max(Nbpsc/2, 1);

for p = 0 : DevideNum - 1 
    for k = 0 : Ncbps - 1
        t1 = Data(1, (p * Ncbps) + (k+1));
        i = (Ncbps/16)*(mod(k,16))+floor(k/16);
        NewD(1, p * Ncbps + (i+1)) = t1;
    end
end
 
for m = 0 : DevideNum - 1 
    for i =0 : Ncbps - 1
        t1 = NewD(1,(m * Ncbps) + (i + 1));
        j = s*floor(i/s)+mod((i+Ncbps-floor(16*i/Ncbps)), s);
        Nend(1, m * Ncbps + (j+1)) = t1;
    end
end
ZEROS = t;
INTER = Nend;
