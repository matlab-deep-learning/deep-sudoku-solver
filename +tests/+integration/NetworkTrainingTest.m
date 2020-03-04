classdef NetworkTrainingTest < matlab.unittest.TestCase
    
    % Copyright 2018 The MathWorks, Inc.
    
    methods (Test)
        function testNumberNetwork(testCase)
            nSamples = 10;
            imageSize = [64, 64, 3];

            [train, ~] = sudoku.training.getNumberData(nSamples, false);

            options = trainingOptions('sgdm', ...
                                        'ExecutionEnvironment', 'cpu', ...
                                        'MaxEpochs', 2, ...
                                        'MiniBatchSize', 64);

            layers = sudoku.training.makeNetwork(imageSize);
            net = trainNetwork(train, layers, options);
        end
        
        function testSegmentationNetwork(testCase)
            inputSize = [64, 64, 3];
            numClasses = 2;
            networkDepth = 2;
            trainFraction = 0.1;

            %% Get the training data
            [imagesTrain, labelsTrain] = sudoku.training.getSudokuData(trainFraction, false);

            train = pixelLabelImageDatastore(imagesTrain, labelsTrain, ...
                'OutputSize', inputSize(1:2));

            %% Setup the network
            layers = segnetLayers(inputSize, numClasses, networkDepth);
            layers = sudoku.training.weightLossByFrequency(layers, train);

            opts = trainingOptions('sgdm', ...
                'InitialLearnRate', 0.005, ...
                'MaxEpochs', 2, ...
                'MiniBatchSize', 2);

            %% Train
            net = trainNetwork(train, layers, opts); %#ok<NASGU>


        end
    end
end