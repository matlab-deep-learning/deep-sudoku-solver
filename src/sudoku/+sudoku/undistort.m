function outputImage = undistort(im, imagePoints, worldPoints)
% undistort     Undistort an image.
%
%   outputImage = undistort(im, imagePoints, worldPoints)
%
%   Args:
%       im:             image for undistortion
%       imagePoints:    nx2 array of points in the image
%       worldPoints:    nx2 array of corresponding world points
%
%   Returns:
%       outputImage:    rectified image

% Copyright 2018, The MathWorks, Inc.


    transform = fitgeotrans(imagePoints, worldPoints, 'projective');
    outputImage = imwarp(im, transform, ...
                            'Interpolation', 'cubic', ...
                            'OutputView', imref2d(max(worldPoints)));

end