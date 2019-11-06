function intersections = intersectionsFromLabel(mask)
% intersectionsFromLabel    Find line intersections from puzzle mask.
%
%   intersections = sudoku.intersectionsFromLabel(mask)
%
%   Args:
%       mask: binary image corresponding to puzzle pixels in an image
%
%   Returns:
%       intersections: 4x2 array of intersection points
%   
%   Note:
%       The four strongest lines are found in the image and from these the
%       four most plausible intersections are chosen.
%
%       The intersections are also sorted to be arranged clockwise around
%       the centre of the puzzle.
%
%   See also: sudoku.getMapLines, sudoku.intersectAll, sudoku.selectAndSort

% Copyright 2018, The MathWorks, Inc.

    lines = sudoku.getMapLines(mask);
    intersections = sudoku.intersectAll(lines);
    intersections = sudoku.selectAndSort(intersections);
end