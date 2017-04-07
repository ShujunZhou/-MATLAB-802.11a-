function Temp = decon( code )
trellis = poly2trellis(7, [133 171]); %产生卷积编码器的表示方法
tblen = 6;
Temp = vitdec(code, trellis, tblen, 'trunc', 'hard' );
end

