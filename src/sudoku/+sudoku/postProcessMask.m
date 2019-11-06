function maskDilated = postProcessMask(mask)
    
    % Copyright 2018 The MathWorks, Inc.
    
    maskDilated = imdilate(mask, strel('disk', 120));
end