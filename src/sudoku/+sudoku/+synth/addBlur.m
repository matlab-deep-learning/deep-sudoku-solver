function imOut = addBlur(im, maxBlur)
    
    % Copyright 2018 The MathWorks, Inc.
    
    imOut = imgaussfilt(im, maxBlur*rand(1));
end