function [freq_tr_syms, freq_data_syms, freq_pilot_syms] = FFT64(time_signal)

UsedSubcIdx=[7:32 34:59]';
DataSubcIdx=[7:11 13:25 27:32 34:39 41:53 55:59]';
PilotSubcIdx=[12 26 40 54]';

long_tr_syms = time_signal(193:320);%提取时域长训练符号

long_tr_syms = reshape(long_tr_syms, 64, 2);
% 转换到频域
freq_long_tr = fft(long_tr_syms)/(64/sqrt(52));%转换到频域 
reorder = [33:64 1:32];%重排序
freq_long_tr(reorder,:) = freq_long_tr;   
% 选择训练符号
freq_tr_syms= freq_long_tr(UsedSubcIdx,:);
freq_tr_syms= freq_tr_syms(:).';

% 提取Data 字段   
freq_data = Del_CP(time_signal);   
% 执行FFT
freq_data = fft(freq_data)/(64/sqrt(52));   
%%重排序 [33:64 1:32]
freq_data(reorder,:) = freq_data;   
%选择数据子载波
freq_data_syms = freq_data(DataSubcIdx,:);
%选择导频子载波
freq_pilot_syms = freq_data(PilotSubcIdx,:);

freq_data_syms = freq_data_syms(:).';
freq_pilot_syms = freq_pilot_syms(:).';
