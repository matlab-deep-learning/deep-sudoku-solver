function extractNumberData(outputFolder)
% extractNumberData     Saves individual number images from sudoku images.
%
%   sudoku.training.extractNumberData(outputFolder)
%
%   Args:
%       outputFolder (char): output directory to save the data

% Copyright 2018, The MathWorks, Inc.

    %% Load data
    [images, labels, ~, ~] = sudoku.training.getSudokuData(1, false);
    pximds = pixelLabelImageDatastore(images, labels);
    dataFile = fullfile(sudokuRoot(), 'data', 'labels', 'numbers.txt');
    digitLabels = sudoku.training.readNumberLabels(dataFile);

    directoryNames = 0:9;
    numberSize = 64;
    
    for iDirectory = 1:numel(directoryNames)
        thisDir = fullfile(outputFolder, num2str(directoryNames(iDirectory)));
        if ~isfolder(thisDir)
            mkdir(thisDir);
        end
    end

    for iImage = 1:numel(pximds.Images)
        fprintf('Extracting number image for image %d.\n', iImage);
        data = pximds.readByIndex(iImage);
        filename = pximds.Images{iImage};

        intersections = sudoku.intersectionsFromLabel(data.pixelLabelImage{1} == "sudoku");

        % add some realistic line error
        puzzleArea = polyarea(intersections(:,1), intersections(:,2));
        maxError = sqrt(puzzleArea)/9/10;
        imagePoints = intersections + maxError*(0.5 - 1*rand(4, 2));

        numberImages = extractNumbers(data.inputImage{1}, imagePoints, numberSize);

        % Save images
        [puzzle, repeat] = sudoku.training.parseFilename(filename);
        if digitLabels.isKey(puzzle)
            puzzleLabel = abs(digitLabels(puzzle));
            for iDigitImage = 1:81
                thisNumber = puzzleLabel(iDigitImage);
                imageName = sprintf('%s_%s_%d.tif', puzzle, repeat, iDigitImage);
                filename = fullfile(outputFolder, num2str(thisNumber), imageName);
                imwrite(numberImages{iDigitImage}, filename);
            end
        end
    end
end

function numberImages = extractNumbers(im, imagePoints, numberSize)
    % Generate rectified puzzle
    fullWidth = 9*numberSize;
    worldPoints = [0, 0; ...
                    fullWidth, 0; ...
                    fullWidth, fullWidth; ...
                    0, fullWidth; ...
                    ];
    outputImage = sudoku.undistort(im, imagePoints, worldPoints);

    % Convert to individual number images
    numberImages = mat2cell(outputImage, ...
                        repmat(numberSize, 1, 9), ...
                        repmat(numberSize, 1, 9), ...
                        3);
end
    