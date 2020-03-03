function net = trainNumberNetwork(outputName)
% trainNumberNetwork  Trains a number classification network.
%
%   net = sudoku.trainNumberNetwork();
%   net = sudoku.trainNumberNetwork(outputName);
%
%   Args:
%       outputName (optional):  Name under which to save the network
%
%   Returns:
%       net:  Trained neural network
%
%   Note:
%       The output model will be saved in a 'models' folder in the current
%       working directory. If no name is provided a default of 
%       'number_network.mat' will be used.

% Copyright 2018, The MathWorks, Inc.

    if nargin < 1
      outputName = 'number_network';
    end

    %% Parameters
    modelDirectory = 'models';
    nSamples = 5000;
    initialChannels = 32;
    imageSize = [64, 64];

    %% Get the training data
    [train, test] = sudoku.training.getNumberData(nSamples, false);

    %% Set up the training options
    options = trainingOptions('adam', ...
                                ...'Plots', 'training-progress', ...
                                'L2Regularization', 1e-4, ...
                                'MaxEpochs', 5, ...
                                'Shuffle', 'every-epoch', ...
                                'InitialLearnRate', 5e-3, ...
                                'LearnRateDropFactor', 0.1, ...
                                'LearnRateDropPeriod',4, ...
                                'LearnRateSchedule', 'piecewise', ...
                                'ValidationData', test, ...
                                'ValidationPatience', Inf, ...
                                'ValidationFrequency', 100, ...
                                'MiniBatchSize', 256);

	%% Setup the network
%     layers = sudoku.training.vggLike(initialChannels, imageSize);
    layers = makeNetworkDownsample();
    
    %% Train
    net = trainNetwork(train, layers, options);

    %% Save the output model
    if ~isfolder(modelDirectory)
        mkdir(modelDirectory)
    end
    outputFile = fullfile(modelDirectory, outputName);
    save(outputFile);

end
