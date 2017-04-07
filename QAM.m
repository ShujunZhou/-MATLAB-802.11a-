function x = QAM( code)
M=16;
k=4;
a = reshape(code, k, []);
b = bi2de(a.', 'left-msb');
c = modulate(modem.qammod(M), b);
e = reshape(c, 1, []);
x = e;