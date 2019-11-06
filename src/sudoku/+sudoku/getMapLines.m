function lines = getMapLines(map)
% getMapLines   Finds the four strongest lines in an image
%
%   lines = getMapLines(map)
%
%   Args:
%       map: image in which to find lines
%
%   Returns:
%       lines:  4x2 array of line parameters in 
%               [rho (pixels), theta (rads)] format.
%
%   See also: sudoku.intersect

% Copyright 2018, The MathWorks, Inc.

    rhoResolution = 0.5;
    thetaResolution = 0.5;
    
    edgeMap = edge(map);
    
    [houghTransform, theta, rho] = hough(edgeMap, ...
                                        'RhoResolution', rhoResolution, ...
                                        'Theta', -90:thetaResolution:90-thetaResolution);
    peaks  = houghpeaks(houghTransform, 4, ...
                        'Threshold', 0.05*max(houghTransform(:)));
                        ...'Theta', -90:thetaResolution:90-thetaResolution);
    lines = [rho(peaks(:, 1))', pi/180*theta(peaks(:, 2))'];

end