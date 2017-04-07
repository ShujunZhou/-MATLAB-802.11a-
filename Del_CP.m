function rx_time_data=Del_CP(rx_frame)

frame_length=length(rx_frame);
rx_data=rx_frame(321:frame_length);
num_symbols =floor(size(rx_data, 2)/80);%需要接收的符号数（每符号有80码元）
rx_data=rx_data(1:80*num_symbols);

% 删除循环前缀
symbols = reshape(rx_data(:), 80, num_symbols);
symbols(1:16,:)=[]; 
rx_time_data = symbols;