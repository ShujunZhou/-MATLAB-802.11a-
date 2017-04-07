function main()
Ncbps = 192;
Nbpsc = 4;
%RATE=[1 1 0 1];                 % 6Mbps速率
RATE=[1 0 0 1];                    %24Mbps
Pad_Bits =[];
Tail=zeros(1,6);
SERVICE = zeros(1, 16);
PSDU = randi([0 1], 3000, 1)';   %原始数据
len_psdu = length(PSDU);        %数据长度
DATA = [SERVICE PSDU Tail Pad_Bits];

S_DATA = raoma(DATA); %扰码

SIGNAL_DATA = xinyuan(len_psdu, S_DATA, RATE); %信源

con = convolutionNew(SIGNAL_DATA);%卷积

[INTER, ZEROS] = jiaozhi(con, Ncbps, Nbpsc); %交织
%SIGNAL_DATA = bpsk(INTER); %映射
SIGNAL_DATA = QAM(INTER); %QAM

P_SIGNAL_DATA = Add_Pilot(SIGNAL_DATA); %添加导频

IF_SIGNAL_DATA = IFFT64(P_SIGNAL_DATA); %OFDM调制

ACP_SIGNAL_DATA = Add_CP(IF_SIGNAL_DATA); %添加CP

preamb = qiandaoma(); %前导码

PPDU = [preamb ACP_SIGNAL_DATA]; %PPDU

N_PPDU = awgn(PPDU, 20.0);     %高斯噪声
[~, freq_data_syms, ~] = FFT64(N_PPDU);  %OFDM解调
freq_data_syms = freq_data_syms * (64/sqrt(52));

%NDBSK_DATA = dbpsk(freq_data_syms); %逆映射
NDBSK_DATA = D16QAM(freq_data_syms);

d = jiejiaozhi(NDBSK_DATA, ZEROS, Ncbps, Nbpsc);  %解交织

s = decon(d);     %解卷积

s([1 1:24]) = [];   %删除signal

rm = raoma(s);   %解扰码

XOR = xor(rm, DATA); %异或
ONES = numel(find(XOR == 1)); %找出异或结果中1的个数
ERRORS = ONES / len_psdu * 100


