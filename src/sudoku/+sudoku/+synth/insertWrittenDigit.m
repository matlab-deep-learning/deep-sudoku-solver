function imOut = insertWrittenDigit(im, digit, resolution, border, padding)
    
    % Copyright 2018 The MathWorks, Inc.
    
    digitData = sudoku.synth.Mnist.getInstance.Cache;
    
    matchingDigits = digitData.images(:, :, digitData.labels == digit);
    digit = matchingDigits(:,:,randi(size(matchingDigits, 3)));

    textSize = [resolution - 2*border - 2*padding, resolution - 2*border - 2*padding];
    textImage = imresize(digit, textSize);
    textImage = repmat(textImage, 1, 1, 3);
    textImage = textImage.*(0.5 + 0.5*rand(1, 1, 3));
    textImage = uint8(255*textImage);
    textImage = padarray(textImage, ...
        [border + padding, border + padding], 0);
    textImage = imerode(textImage, strel('disk', round(4*rand(1))));
    imOut = im - textImage;
    
end