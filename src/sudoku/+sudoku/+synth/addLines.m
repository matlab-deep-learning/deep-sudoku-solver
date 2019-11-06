function im = addLines(im, border, lineWidth, maxColour)
    
    % Copyright 2018 The MathWorks, Inc.
    
    resolution = size(im, 1);
    positions = [border, 0, border, resolution;
                resolution - border, 0, resolution - border, resolution,
                0, border, resolution, border;
                0, resolution - border, resolution, resolution - border];
    lineColour = maxColour*rand(1, 3);
    im = insertShape(im, 'line', positions, ...
                    'Color', lineColour, ...
                    'LineWidth', lineWidth);
end