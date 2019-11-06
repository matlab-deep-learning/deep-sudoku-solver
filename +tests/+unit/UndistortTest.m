classdef UndistortTest < matlab.unittest.TestCase
    
    % Copyright 2018 The MathWorks, Inc.
    
    methods (Test)
        
        function testUndistortion(testCase)
            im = imread('+tests/0001_01.jpg');
            imagePoints = [2180, 788; ...
                            2781, 943; ...
                            1933, 1215; ...
                            2596, 1412];
                        
            imagePoints = imagePoints + 20*(0.5 - 1*rand(4,2));
            
            boxWidth = 32;
            fullWidth = 9*boxWidth;
            worldPoints = [0, 0; ...
                            fullWidth, 0; ...
                            0, fullWidth; ...
                            fullWidth, fullWidth];
            outputImage = sudoku.undistort(im, imagePoints, worldPoints);
            
            newIm = mat2cell(outputImage, ...
                                repmat(boxWidth, 1, 9), ...
                                repmat(boxWidth, 1, 9), ...
                                3);
            montage(newIm)
            % TODO finish this test
        end
        
    end
    
end