function  time_syms= IFFT64(mod_ofdm_syms)

%IFFT64：信号由频域变换到时域
UsedSubcIdx=[7:32 34:59]';%使用的子载波索引
NumSubc=52;%子载波数

%OFDM符号数
num_symbols =size(mod_ofdm_syms, 2)/NumSubc;

%将数据加到相应子载波上，并在未使用的子载波上补0
syms_into_ifft = zeros(64, num_symbols);
syms_into_ifft(UsedSubcIdx,:) = reshape(mod_ofdm_syms(:),NumSubc, num_symbols); %串并变换
 
%数据位置置换
resample_patt=[33:64 1:32];
syms_into_ifft(resample_patt,:) = syms_into_ifft;
   
% 变换到时域
time_syms = zeros(1,num_symbols*64);%初始化time_syms
ifft_out = ifft(syms_into_ifft);
time_syms(1,:) = ifft_out(:).';

