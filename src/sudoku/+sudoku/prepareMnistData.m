function prepareMnistData()
% prepareMnistData  Generates the required mnist data files.
%   Adapted from "Code Examples from Deep Learning Ebook"

% Copyright 2018 The MathWorks, Inc.

    [imgDataTrain, labelsTrain] = sudoku.fetchMnistData();
    
    outputFile = 'mnist.mat';
    destination = fullfile(sudokuRoot(), 'data', 'number_data', outputFile);
    
    training = struct();
    training.images = double(squeeze(imgDataTrain));
    training.labels = str2double(cellstr(labelsTrain));
    
    save(destination, 'training');
end