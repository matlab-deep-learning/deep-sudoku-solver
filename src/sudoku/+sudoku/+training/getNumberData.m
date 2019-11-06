function [train, test] = getNumberData(nSamples, force)
% getNumberData   retrieve number classification data
%
%   [train, test] = sudoku.training.getNumberData(nSamples, force)
%
%   Args:
%       nSamples (double):  number of synthetic images to generate for
%                           each digit
%       force (boolean):    force a regenerate of the data
%
%   Returns:
%       train (imageDatastore):     synthetic samples for training
%       test (imageDatastore):      real samples for testing.

% Copyright 2018, The MathWorks, Inc.

    numberDataRoot = fullfile(sudokuRoot, 'data', 'number_data');
    trainLocation = fullfile(numberDataRoot, 'train');
    testLocation = fullfile(numberDataRoot, 'test');
    
    if force
        if isfolder(trainLocation)
            rmdir(trainLocation, 's');
        end
        if isfolder(testLocation)
            rmdir(testLocation, 's');
        end
    end
    if nSamples > 0 && ~isfolder(trainLocation)
        refreshSyntheticData(trainLocation, nSamples);
    end
    if ~isfolder(testLocation)
        sudoku.training.extractNumberData(testLocation);
    end

    if nSamples > 0
        % fetch the data that is already there
        train = imageDatastore(trainLocation, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
        
        samples = train.countEachLabel;
        if any(samples.Count < nSamples)
            % Not enough data, regenerate it all
            refreshSyntheticData(trainLocation, nSamples);
            train = imageDatastore(trainLocation, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
        elseif any(samples.Count > nSamples)
            % Too much data, subsample
            train = splitEachLabel(train, nSamples);
        end
    else
        train = [];
    end
    test = imageDatastore(testLocation, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
    
end

function refreshSyntheticData(trainLocation, nSamples)
    if isfolder(trainLocation)
        rmdir(trainLocation, 's');
    end
    sudoku.training.generateSyntheticNumberData(trainLocation, nSamples);
end