function im = addPrintedDigit(im, digit, minSize, maxColour, border, maxOffset)
    
    persistent digitData
    if isempty(digitData)
        digitData = sudoku.synth.makeDigitsCache();
    end
    defaultFontSize = 64;
    % Copyright 2018 The MathWorks, Inc.
    
    resolution = size(im, 1);
    maxSize = resolution - 2*border;
    fontScale = round((maxSize - minSize)*rand(1) + minSize)/defaultFontSize;

    textColour = maxColour*rand(1, 3);
    offset = round(maxOffset.*(rand(1, 2) - 0.5));

    field = strcat("digit_", digit);
    printed = digitData.(field);
    selected = printed(:, :, randi(size(printed, 3)));
    
    selected = imresize(selected, fontScale);
    newSize = size(selected);
    padSize = resolution - newSize(1);
    if mod(padSize, 2) == 0
        selected = padarray(selected, [padSize/2, padSize/2], 255);
    else
        selected = padarray(selected, floor([padSize/2, padSize/2]), 255);
        selected = padarray(selected, [1, 1], 255, 'post');
    end
    
    selected = circshift(selected, offset(1), 1);
    selected = circshift(selected, offset(2), 2);
    selected = repmat(selected, 1, 1, 3);
    selected = double(255-selected).*(255-shiftdim(textColour, -1));
    
    im = uint8(double(im) - selected);
    
end