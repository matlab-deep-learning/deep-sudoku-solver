function digitData = makeDigitsCache()
    digits = cellstr(string(1:9));
    
    possibleFonts = {'Arial', ...
        'Garamond', ...
        'Courier New', ...
        'Gill Sans MT', ...
        'Comic Sans MS', ...
        'Calibri', ...
        'Tahoma', ...
        'Times New Roman', ...
        'Times New Roman Bold', ...
        'Times New Roman Italic', ...
        'Verdana', ...
        'Verdana Bold'};
    nFonts = numel(possibleFonts);
    fontSize = 64;
    position = [32, 32];
    
    for digit = digits
        im = 255*ones(64, 64, nFonts, 'uint8');
        for iFont = 1:nFonts
            font = possibleFonts{iFont};



            outIm = insertText(im(:,:,iFont), position, digit, ...
                'BoxOpacity', 0, ...
                'Font', font, ...
                'FontSize', fontSize, ...
                'TextColor', 'black', ...
                'AnchorPoint', 'center');
            im(:,:,iFont) = outIm(:,:,1);
        end
        field = strcat("digit_", digit{1});
        digitData.(field) = im;
    end
end