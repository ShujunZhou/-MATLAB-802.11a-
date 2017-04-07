function c = convolutionNew( code)
trellis = poly2trellis(7, [133 171]);
c = convenc(code, trellis);
end

