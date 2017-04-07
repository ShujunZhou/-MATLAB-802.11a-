function SIGNAL_DATA = xinyuan( len_psdu, S_DATA, RATE)
Reserved = 0;
dec = dec2bin(len_psdu);
zero1 = zeros(1, 12 - length(dec));
binRate = str2num(dec(:))';
LENGTH = [zero1 binRate];       %≥§∂»Œª
Parity = 0;
Tail = zeros(1,6);
SIGNAL = [RATE Reserved LENGTH Parity Tail];
SIGNAL_DATA = [SIGNAL S_DATA];
end

