function thresholded = thresholdImage(im, mask)
% thresholdImage  Applies a binary threshold to an image.
%
%     thresholded = thresholdImage(im, mask)
%
%   Args:
%       im:     image to threshold
%       mask:   existing binary mask
%
%   Returns:
%     thresholded:  output binary mask

% Copyright 2018, The MathWorks, Inc.

    imGray = rgb2gray(im);
    bw = imbinarize(imGray, 'adaptive', ...
                    'Sensitivity', 0.7);
    thresholded = ~bw & mask;

end
