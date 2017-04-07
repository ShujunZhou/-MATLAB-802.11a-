function time_signal = Add_CP(time_syms)

num_symbols = size(time_syms, 2)/64;%需要传输的符号数（每符号有64数据码元）
time_signal = zeros(1, num_symbols*80);%产生时域信号的初始状态；

% 增加循环前缀
symbols = reshape(time_syms(:), 64, num_symbols);
tmp_syms = [symbols(49:64,:); symbols]; 
tmp_syms(1,:)=tmp_syms(1,:)*0.5;%对符号的首尾进行加窗处理
tmp_syms_end(1,:)=symbols(1,:)*0.5;

tmp_syms(1,2:num_symbols)=tmp_syms(1,2:num_symbols)+tmp_syms_end(1:num_symbols-1);
time_signal(:) = tmp_syms(:).';