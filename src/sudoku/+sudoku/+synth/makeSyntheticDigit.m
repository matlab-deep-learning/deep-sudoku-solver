function im = makeSyntheticDigit(iDigit, isHandwritten)
    
    % Copyright 2018 The MathWorks, Inc.
    
    resolution = 300;
    border = 50;
    im = sudoku.synth.makePaper(resolution, 225, 50);
    im = sudoku.synth.addLines(im, border, 2+randi(11), 70);
    if iDigit > 0
        if isHandwritten
            im = sudoku.synth.insertWrittenDigit(im, iDigit, resolution, border, randi(60));
        else
            im = sudoku.synth.addPrintedDigit(im, num2str(iDigit), 2*border, 70, border, 20);
        end
    end
    im = sudoku.synth.addShading(im, 155);
    im = sudoku.synth.addBlur(im, 2.6);
    im = sudoku.synth.addNoise(im, 40);
    im = sudoku.synth.rescaleChannels(im, 0.11);
    im = sudoku.synth.addSharpening(im, 2);
    im = sudoku.synth.addDistortion(im, resolution, border, 64, 30, 60);
end