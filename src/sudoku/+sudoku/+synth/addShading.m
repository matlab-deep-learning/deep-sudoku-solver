function im = addShading(im, maxShade)
    
    % Copyright 2018 The MathWorks, Inc.
    
    resolution = size(im, 1);
    [xGrid, yGrid] = meshgrid(1:resolution, 1:resolution);
    shading = interp2([0, resolution], [0, resolution], ...
                        maxShade*rand(2), xGrid, yGrid);
    im = im - uint8(rand(1)*shading);
end