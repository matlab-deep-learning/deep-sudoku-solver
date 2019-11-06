function setupDataGitHub()
% setupDataGitHub    Copy all the required data files.    

% Copyright 2018 The MathWorks, Inc.

    rawDataLocation = "https://github.com/mathworks/deep-sudoku-solver/releases/latest/download/raw_data.zip";
    
    outputRoot = fullfile(sudokuRoot(), "data");
    
    fprintf("Downloading raw data to %s...", outputRoot);
    unzip(rawDataLocation, outputRoot);
    fprintf("done.\n");
    
    sudoku.prepareMnistData();
end