function imOut = addSharpening(im, maxAmount)
    % This is expensive so don't bother with small amounts
    amount = maxAmount*rand(1);
    if amount > 0.4
        imOut = imsharpen(im, 'Amount', amount);
    else
        imOut = im;
    end
    
    % Copyright 2018 The MathWorks, Inc.
end