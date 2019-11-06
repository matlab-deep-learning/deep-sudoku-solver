function net = trainSemanticSegmentation(outputName, checkpoints)
% trainSemanticSegmentation Train the sudoku segmentation network.
%
%   net = sudoku.trainSemanticSegmentation();
%   net = sudoku.trainSemanticSegmentation(outputName);
%   net = sudoku.trainSemanticSegmentation(outputName, checkpoints);
%
%   Args:
%       outputName (optional):  Name under which to save the network
%       checkpoints (optional boolean): Whether to save training
%                                       checkpoints
%
%   Returns:
%       net:  Trained neural network
%
%   Note:
%       The output model will be saved in a 'models' folder in the current
%       working directory. If no name is provided a default of 
%       'segmentation_network.mat' will be used.

% Copyright 2018, The MathWorks, Inc.

    if nargin < 2
      checkpoints = false;
    end

    if nargin < 1
      outputName = 'segmentation_network';
    end

    %% Parameters
    modelDirectory = 'models';
    inputSize = [512, 512, 3];
    numClasses = 2;
    networkDepth = 'vgg16';
    trainFraction = 0.7;

    %% Get the training data
    [imagesTrain, labelsTrain, imagesTest, labelsTest] = sudoku.training.getSudokuData(trainFraction, false);

    augmenter = imageDataAugmenter( ...
        'RandXReflection',false, ...
        'RandYReflection',false, ...
        'RandRotation', [15, 15], ...
        'RandXScale', [0.75, 1.25], ...
        'RandYScale', [0.75, 1.25], ...
        'RandXTranslation', [-100, 100], ...
        'RandYTranslation', [-100, 100]);

    train = pixelLabelImageDatastore(imagesTrain, labelsTrain, ...
        'OutputSize', inputSize(1:2), ...
        'DataAugmentation', augmenter);
    test = pixelLabelImageDatastore(imagesTest, labelsTest, ...
        'OutputSize', inputSize(1:2));

    %% Setup the network
    layers = segnetLayers(inputSize, numClasses, networkDepth);
    layers = sudoku.training.weightLossByFrequency(layers, train);

    %% Set up the training options
    if checkpoints
        checkpointPath = fullfile('checkpoints', outputName);
        if ~isfolder(checkpointPath)
            mkdir(checkpointPath)
        end
    else
        checkpointPath = '';
    end

    opts = trainingOptions('sgdm', ...
        'InitialLearnRate', 0.005, ...
        'LearnRateDropFactor', 0.1, ...
        'LearnRateDropPeriod', 20, ...
        'LearnRateSchedule', 'piecewise', ...
        'ValidationData', test, ...
        'ValidationPatience', Inf, ...
        'MaxEpochs', 40, ...
        'MiniBatchSize', 2, ...
        'Shuffle', 'every-epoch', ...
        'Plots', 'training-progress', ...
        'CheckpointPath', checkpointPath);

    %% Train
    net = trainNetwork(train, layers, opts);

    %% Save
    if ~isfolder(modelDirectory)
        mkdir(modelDirectory)
    end
    outputFile = fullfile(modelDirectory, outputName);
    save(outputFile);
end
