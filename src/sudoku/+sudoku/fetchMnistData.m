function [imgDataTrain, labelsTrain] = fetchMnistData()
% fetchMnistData    Downloads and extract minst data.
%   Adapted from "Code Examples from Deep Learning Ebook"

% Copyright 2018 The MathWorks, Inc.

%% Download MNIST files
    dataDirectory = tempname;
    files = ["train-images-idx3-ubyte",...
                "train-labels-idx1-ubyte"];

    disp('Downloading files...')
    mkdir(dataDirectory)
    webPrefix = "http://yann.lecun.com/exdb/mnist/";
    webSuffix = ".gz";

    filenames = files + webSuffix;
    for ii = 1:numel(files)
        outputFile = fullfile(dataDirectory, filenames(ii));
        websave(outputFile, webPrefix + filenames(ii));
        gunzip(outputFile, dataDirectory);
    end
    disp('Download complete.')
    
    %% Extract the MNIST images into arrays
    disp('Preparing MNIST data...');

    % Read headers for training set image file
    fid = fopen(fullfile(dataDirectory, char(files(1))), 'r', 'b');
    fread(fid, 1, 'uint32'); % skip one
    numImgs  = fread(fid, 1, 'uint32');
    numRows  = fread(fid, 1, 'uint32');
    numCols  = fread(fid, 1, 'uint32');

    % Read the data part 
    rawImgDataTrain = uint8(fread(fid, numImgs * numRows * numCols, 'uint8'));
    fclose(fid);

    % Reshape the data part into a 4D array
    rawImgDataTrain = reshape(rawImgDataTrain, [numRows, numCols, numImgs]);
    rawImgDataTrain = permute(rawImgDataTrain, [2,1,3]);
    imgDataTrain(:,:,1,:) = uint8(rawImgDataTrain(:,:,:));

    % Read headers for training set label file
    fid = fopen(fullfile(dataDirectory, char(files(2))), 'r', 'b');
    fread(fid, 1, 'uint32'); % skip one
    numLabels = fread(fid, 1, 'uint32');

    % Read the data for the labels
    labelsTrain = fread(fid, numLabels, 'uint8');
    fclose(fid);

    % Process the labels
    labelsTrain = categorical(labelsTrain);


    disp('MNIST data preparation complete.');
end