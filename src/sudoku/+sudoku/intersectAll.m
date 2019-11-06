function intersections = intersectAll(lines)
% intersectAll  Find all the intersections between a set of lines
%
%   intersections = intersectAll(lines)
%
%   Args:
%       lines: nx2 array of line parameters
%
%   Returns:
%       intersections: mx2 array of intersections points
%   
%   Note:
%       The number of intersection points will be n choose 2 for n lines.
%
%       Any pairs of lines which do not have an intersection will
%       correspond to a point [NaN, NaN] in the intersections array.
%
%   See also: sudoku.intersect

% Copyright 2018, The MathWorks, Inc.

    
    nLines = size(lines, 1);
    intersections = zeros(nchoosek(nLines, 2), 2);
    count = 1;
    
    for iLine1 = 1:(nLines - 1)
        for iLine2 = (iLine1 + 1):nLines
            try
                intersections(count, :) = sudoku.intersect(lines(iLine1, :), ...
                                                            lines(iLine2, :));
            catch ME
                if strcmp(ME.identifier, 'sudoku:intersect:noIntersection')
                    intersections(count, :) = [NaN, NaN];
                else
                    rethrow(ME)
                end
            end
            count = count + 1;
        end
    end
    
end