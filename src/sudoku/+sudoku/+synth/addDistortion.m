function imOut = addDistortion(im, resolution, border, finalSize, maxError, maxShift)
    
    % Copyright 2018 The MathWorks, Inc.
    
    imagePoints = [border, border;
                    border, resolution - border;
                    resolution - border, resolution - border
                    resolution - border, border];
    imagePoints = imagePoints + maxError*(rand(4, 2)-0.5);
    % add shift
    imagePoints = imagePoints + maxShift*(rand(1, 2) - 0.5);
    worldPoints = [0, 0; ...
                    0, finalSize; ...
                    finalSize, finalSize; ...
                    finalSize, 0];
    imOut = sudoku.undistort(im, imagePoints, worldPoints);
