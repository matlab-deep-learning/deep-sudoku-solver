classdef PuzzleSolver < handle
    % PuzzleSolver  Solves sudoku puzzles from uncontrolled images.
    
    % Copyright 2018, The MathWorks, Inc.

    
    properties
        SegmentationNetwork
        SegmentationInputSize
        ClassificationNetwork
        ClassificationInputSize
    end
    
    methods
        function obj = PuzzleSolver(segmentationNetworkPath, numberNetworkPath)
            % PuzzleSolver  Constructor.
            %
            %   solver = sudoku.PuzzleSolver(segmentationNetworkPath,
            %   numberNetworkPath);
            %
            %   Args:
            %       segmentationNetworkPath:    Path to a saved
            %                                   segmentation network
            %       numberNetworkPath:          Path to a saved
            %                                   classiciation network
            %
            %   Notes:
            %       The paths to networks should point to .mat files which
            %       contain an appropriate network with the variable name
            %       'net'.
            %   
            %       If no file paths are specified the object will try and
            %       look for files with the default names in a 'models'
            %       directory in the current working directory.
            %
            %   See also:   sudoku.trainSemanticSegmentation, 
            %               sudoku.trainNumberNetwork
            
            if nargin == 0
                % look for the default network names
                numberNetworkPath = fullfile('models', 'number_network.mat');
                segmentationNetworkPath = fullfile('models', 'segmentation_network.mat');
            end
            
            obj.loadNetworks(segmentationNetworkPath, numberNetworkPath);
        end
        
        function [solution, intermediateOutputs] = process(obj, im)
            % process   Solves a sudoku from an input image.
            %
            %   [solution, intermediateOutputs] = solver.process(im);
            %
            %   Args:
            %       im: input image of a sudoku puzzle
            %
            %   Returns:
            %       solution (9x9 double):      solved puzzle
            %       intermediateOutputs (cell): outputs from intermediate
            %                                   steps in the algorithm.
            
            
            [mask, findSteps] = obj.findPuzzle(im);
            [numberImages, extractSteps] = obj.extractNumbers(im, mask);
            numberData = obj.readNumbers(numberImages);
            solution = obj.solve(numberData);
            
            intermediateOutputs = [findSteps, ...
                                    {mask}, ...
                                    extractSteps, ...
                                    {numberImages}, ...
                                    {numberData}];
        end
        
        function [mask, intermediateOutputs] = findPuzzle(obj, im)
            % findPuzzle    Find the sudoku puzzle in an image
            %
            %   Step 1 - find the puzzle using deep learning
            
            networkMask = sudoku.segmentPuzzle(im, obj.SegmentationNetwork);
            maskPostProcessed = sudoku.postProcessMask(networkMask);
            thresholdedImage = sudoku.thresholdImage(im, maskPostProcessed);
            mask = sudoku.findPrimaryRegion(thresholdedImage);
            
            intermediateOutputs = {networkMask, maskPostProcessed, thresholdedImage};
        end
        
        function [numberImages, intermediateOutputs] = extractNumbers(obj, im, mask)
            % extractNumbers    Extract the 81 number boxes from the puzzle
            %
            %   Step 2 - find the number boxes using image processing
            
            intersections = sudoku.intersectionsFromLabel(mask);
            numberSize = obj.ClassificationInputSize(1);
            numberImages = sudoku.extractNumbers(im, intersections, numberSize);
            
            intermediateOutputs = {intersections};
        end
        
        function numberData = readNumbers(obj, numberImages)
            % readNumbers   Read the contents of the number boxes
            %
            %   Step 3 - read the numbers using deep learning
            
            numbers = obj.ClassificationNetwork.classify(cat(4, numberImages{:}));
            numberData = str2double(string(numbers));
        end
        
        function solution = solve(~, numberData)
            % solve     Solve a sudoku puzzle
            %
            %   Step 4 - solve the puzzle using optimisation
            
            solution = sudoku.sudokuEngine(reshape(numberData, [9, 9]));
        end
        
        function loadNetworks(obj, segmentationNetworkPath, numberNetworkPath)
            % load the segmenation network
            loadedData = load(segmentationNetworkPath, 'net');
            obj.SegmentationNetwork = loadedData.net;
            obj.SegmentationInputSize = obj.SegmentationNetwork.Layers(1).InputSize;
            
            % load teh number network
            loadedData = load(numberNetworkPath, 'net');
            obj.ClassificationNetwork = loadedData.net;
            obj.ClassificationInputSize = obj.ClassificationNetwork.Layers(1).InputSize;
        end
    end
end