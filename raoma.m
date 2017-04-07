function R=raoma(input)%定义函数
S = [1, 1, 1, 1, 1, 1, 1];%初始状态
L = zeros(1, 127);%127加扰序列（zeros功能是返回一个m×n×p×...的double类零矩阵）
F = zeros(1, length(input));%输入数据长度
 for i = 1:127
    A = S(1, 1);
    B = S(1, 4);
    C = xor(A, B);%将移位寄存器4，7异或
    S =[ S(2:7), C];% 左移一位  
    S(1, 7) = C;
    L(1,i) = C;%加扰序列
 end
L_copy = repmat(L, 1, ceil(length(input) / length(L)));%将矩阵 L复制 1×c块(ceil返回大于等于表达式的最小整数 )
L_num = L_copy(1: length(input));%将输入数据的长度和扰码序列长度匹配

F= xor(L_num, input);%将输入数据和改变长度后的扰码序列异或
   
R =  F;%加扰后的数据序列