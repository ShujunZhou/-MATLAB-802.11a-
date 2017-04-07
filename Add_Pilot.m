function mod_ofdm_syms = Add_Pilot(mod_syms)

PilotScramble=[1 1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 1 -1 1 -1 -1 1 1 -1 1 1 -1 1 1 1 1 ...
      1 1 -1 1 1 1 -1 1 1 -1 -1 1 1 1 -1 1 -1 -1 -1 1 -1 1 -1 -1 1 -1 -1 1 1 1 1 1 -1 -1 1 ...
      1 -1 -1 1 -1 1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 -1 1 -1 -1 1 -1 1 1 1 1 -1 1 -1 1 -1 1 -1 ...
      -1 -1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 -1 1 -1 -1 -1 1 1 1 -1 -1 -1 -1 -1 -1 -1];%Pilot扰码数据
NumDataSubc=48;% 数据子载波数
NumSubc=52;%子载波数
DataSubcPatt=[1:5 7:19 21:26 27:32 34:46 48:52]';%数据子载波的位置
PilotSubcPatt=[6 20 33 47]';%导频子载波的位置
NumPilotSubc=4;% 导频子载波数
PilotSubcSymbols=[1;1;1;-1];%导频子载波的符号

n_mod_syms = size(mod_syms,2);%发送的映射调制符号数
n_ofdm_syms = ceil(n_mod_syms/NumDataSubc);%发送的OFDM符号数
mod_syms=[mod_syms zeros(1,n_ofdm_syms*NumDataSubc-n_mod_syms)];

%pilot scrambling pattern
scramble_patt = repmat(PilotScramble,1,ceil(n_ofdm_syms/length(PilotScramble)));%重复导频扰码，使得其长度至少与OFDM符号数一样
scramble_patt = scramble_patt(1:n_ofdm_syms);%截取与OFDM符号数个导频扰码序列

mod_ofdm_syms = zeros(NumSubc, n_ofdm_syms);
mod_ofdm_syms(DataSubcPatt,:) = reshape(mod_syms, NumDataSubc, n_ofdm_syms);%将映射调制符号mod_syms按分组插入NumDataSubc个数据子载波中

%将导频子载波符号序列进行扰码后插入相应导频子载波位置上
mod_ofdm_syms(PilotSubcPatt,:) = repmat(scramble_patt, NumPilotSubc,1).*repmat(PilotSubcSymbols, 1, n_ofdm_syms);
%导频插入后的数据输出
mod_ofdm_syms = mod_ofdm_syms(:).';
