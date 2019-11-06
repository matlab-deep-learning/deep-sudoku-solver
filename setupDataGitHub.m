function setupDataGitHub()
    % setupDataGitHub    Copy all the required data files.    
    
    % Copyright 2019 The MathWorks, Inc.
    
        version = 'v0.0';
        baseURL = 'https://github.com/mathworks/deep-sudoku-solver/releases/download';
    
        segmentationURL = sprintf('%s/%s/%s', baseURL, version, 'segmentation_data.zip');
        numberURL = sprintf('%s/%s/%s', baseURL, version, 'number_data.zip');
        
        outputRoot = fullfile(sudokuRoot(), 'data');
        
        fprintf('Downloading segmentation data...');
        unzip(segmentationURL, outputRoot);
        fprintf('done.\n');
        
        fprintf('Downloading synthetic number data...');
        unzip(numberURL, outputRoot);
        fprintf('done.\n');
        
        sudoku.prepareMnistData();
    end