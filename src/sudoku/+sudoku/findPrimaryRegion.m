function mask = findPrimaryRegion(thresholdedImage)
% findPrimaryRegion     Finds the largest region in a thresholded image.
%
%   mask = findPrimaryRegion(thresholdedImage);
%
%   Args:
%       thresholdedImage: binary image for analysis
%   
%   Returns:
%       mask:   binary image corresponding to the filled area of the 
%               largest region.

% Copyright 2018, The MathWorks, Inc.

    % Analyse the regions and find the largest
    regions = regionprops('table', thresholdedImage, ...
                            'FilledArea', 'Image', 'FilledImage', 'BoundingBox');
    regions = sortrows(regions, 4);
    filledRegion = imerode(regions{end, 3}{1}, ones(3));
    boundingBox = regions{end, 1};
    
    % Generate the new mask 
    inputSize = size(thresholdedImage);
    mask = zeros(inputSize);
    mask(ceil(boundingBox(2)):floor(boundingBox(2) + boundingBox(4)), ...
            ceil(boundingBox(1)):floor(boundingBox(1) + boundingBox(3)), ...
            :) = repmat(filledRegion, 1, 1);
end