function imOut = rescaleChannels(im, maxDecrease)
    
    % Copyright 2018 The MathWorks, Inc.
    
    imOut = uint8(double(im).*(1-maxDecrease*rand(1, 1, 3)));
end