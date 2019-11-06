function imOut = addSharpening(im, maxAmount)
    
    % Copyright 2018 The MathWorks, Inc.
    
    imOut = imsharpen(im, 'Amount', maxAmount*rand(1));
end