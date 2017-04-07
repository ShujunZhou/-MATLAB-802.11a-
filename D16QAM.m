function x = D16QAM(code)
M=16;
x=demodulate(modem.qamdemod(M),code);
x=de2bi(x.','left-msb');
x=reshape(x',1,[]);
        
