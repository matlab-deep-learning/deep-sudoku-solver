function intersection = intersect(line1, line2)
% intersect     Calculate intersection of two lines.
%
%   intersection = intersect(line1, line2)
%
%   Args:
%       line1: 1x2 array defining line to intersect
%       line2: 1x2 array defining line to intersect
%
%   Returns:
%       intersection: 1x2 array defining the intersection co-ordinate.
%   
%   Note:
%       Each line should be in the format [rho (pixels), theta (rads)].
%
%       If the lines are parallel an 'sudoku:intersect:noIntersection'
%       exception will be raised.
%
%   See also: sudoku.getMapLines

% Copyright 2018, The MathWorks, Inc.

    reenableWarning = onCleanup(@() warning('on', 'MATLAB:singularMatrix'));
    warning('off', 'MATLAB:singularMatrix');

    M = [cos(line1(2)), sin(line1(2));
         cos(line2(2)), sin(line2(2))];
    b = [line1(1);  line2(1)];
    intersection = M\b;
    intersection = intersection';
    
    if any(isinf(intersection))
        error('sudoku:intersect:noIntersection', ...
                'Infinte point, lines may be parallel');
    end
end