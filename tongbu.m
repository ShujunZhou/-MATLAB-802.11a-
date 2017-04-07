function p = tongbu(data,preamble)
b=0;
d=preamble;
p=[];
for i=1:200
    a=abs(dot(data(i:i+15),d(1:16)));%dot的意思data(i:i+15)的共轭转置乘以d(1:16)
    if a>0.1%求峰值
        b=b+1;
        if b==10
            v = i - 144;
            length(data);
            p=data(v : length(data));
        elseif b~=10&&i==200
            disp('信噪比太小，失去同步信息')
            break;
        end
    end
end
