function mask = segmentPuzzle(im, net)
% segmentPuzzle     Perform semantic segmentation to find a puzzle
%
%   mask = sudoku.segmentPuzzle(im, net)
%
%   Args:
%       im:     image to segment
%       net:    semantic segmentation network
%
%   Returns:
%       mask:   binary segmentation mask
%   
%   Note:
%       This function assumes that the segmentation network has been
%       trained to recognised a class named 'sudoku'.
%
%   See also: sudoku.trainSemanticSegmentationNetwork

% Copyright 2018, The MathWorks, Inc.

    inputSize = net.Layers(1).InputSize;
    originalSize = size(im);
    imInput = imresize(im, inputSize(1:2));
    C = semanticseg(imInput, net);
    mask = C == 'sudoku';
    mask = imresize(mask, originalSize(1:2));
end