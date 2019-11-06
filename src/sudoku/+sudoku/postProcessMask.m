function maskDilated = postProcessMask(mask)
    
    % Copyright 2018-2019 The MathWorks, Inc.
    
    erodeSize =  ceil(min(size(mask))/150);
    dilateSize = ceil(min(size(mask))/20);
    
    mask = imclearborder(mask);
    mask = imerode(mask, ones(erodeSize));
    maskDilated = imdilate(mask, strel('disk', dilateSize));
end