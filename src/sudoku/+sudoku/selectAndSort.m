function sortedIntersections = selectAndSort(intersections)
% selectAndSort     Select the most feasible intersections.
%
%   sortedIntersections = sudoku.selectAndSort(intersections)
%
%   Args:
%       intersections: nx2 array of intersection points
%
%   Returns:
%       sortedIntersections: mx2 array of intersection points
%   
%   Note:
%       The selection algorithm removes nan, and negative intersection
%       locations. As well as those very far from the median point.
%
%       The remaining intersections are sorted to be anti-clockwise
%
%   See also: sudoku.intersect, sudoku.intersectAll

% Copyright 2018, The MathWorks, Inc.

    % Remove nan and negative
    nanLocations = sum(isnan(intersections), 2) > 0;
    negativeLocations = min(intersections, [], 2) < 0;
    intersections(negativeLocations | nanLocations, :) = [];
    
    % Remove very distant
    distances = sqrt(sum((intersections - median(intersections)).^2, 2));
    medianDistance = median(distances);
    distantPoints = distances > 2*medianDistance;
    intersections(distantPoints, :) = [];
    
    % Sort order
    meanPoint = mean(intersections);
    points = intersections - meanPoint;
    angles = atan2(points(:,2), points(:,1));
    [~, sortIndex] = sort(angles);
    sortedIntersections = intersections(sortIndex, :);
end