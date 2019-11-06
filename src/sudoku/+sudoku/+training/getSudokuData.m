function [imagesTrain, labelsTrain, imagesTest, labelsTest] = ...
            getSudokuData(trainingFraction, includeExtra)
        
% Copyright 2018, The MathWorks, Inc.
        
    rng('default');
    gTruth = loadGroundTruth('sudokuLabels.mat');

    imageFiles = gTruth.DataSource.Source;
    labelFiles = gTruth.LabelData.PixelLabelData;
    numImages = numel(imageFiles);
    shuffledIndices = randperm(numImages);
    N = round(trainingFraction*numImages);
    trainIndex = shuffledIndices(1:N);
    testIndex = shuffledIndices(N+1:end);

    if includeExtra
        gTruth = loadGroundTruth('extraLabels.mat');
        extraImages = gTruth.DataSource.Source;
        extraLabels = gTruth.LabelData.PixelLabelData;
        trainImageFiles = [imageFiles(trainIndex); extraImages];
        trainLabelFiles = [labelFiles(trainIndex); extraLabels];
    else
        trainImageFiles = imageFiles(trainIndex);
        trainLabelFiles = labelFiles(trainIndex);
    end
    
    if trainingFraction == 1
        imagesTrain = imageDatastore(trainImageFiles);
        labelsTrain = pixelLabelDatastore(trainLabelFiles, ...
                                        ["background", "sudoku"], ...
                                        [0, 1]);
        imagesTest = [];
        labelsTest = [];
    elseif trainingFraction == 0
        imagesTest = imageDatastore(imageFiles(testIndex));
        labelsTest = pixelLabelDatastore(labelFiles(testIndex), ...
                                        ["background", "sudoku"], ...
                                        [0, 1]);
        imagesTrain = [];
        labelsTrain = [];
    else
        imagesTrain = imageDatastore(trainImageFiles);
        labelsTrain = pixelLabelDatastore(trainLabelFiles, ...
                                        ["background", "sudoku"], ...
                                        [0, 1]);
        imagesTest = imageDatastore(imageFiles(testIndex));
        labelsTest = pixelLabelDatastore(labelFiles(testIndex), ...
                                        ["background", "sudoku"], ...
                                        [0, 1]);
    end

end

function gTruth = loadGroundTruth(labelFile)
    labelDirectory = fullfile(sudokuRoot(), 'data', 'labels');
    data = load(fullfile(labelDirectory, labelFile), 'gTruth');
    gTruth = data.gTruth;
    changeFilePaths(gTruth, ...
        ["C:\Users\jpinkney\MATLAB Drive Connector\deep-sudoku", fullfile(sudokuRoot(), "data")]);
    changeFilePaths(gTruth, ...
        ["raw_data", fullfile(sudokuRoot(), "data", "raw_data")]);
end