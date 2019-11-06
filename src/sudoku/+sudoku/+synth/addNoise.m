function imOut = addNoise(im, maxNoise)
    
    % Copyright 2018 The MathWorks, Inc.
    
    noiseMag = maxNoise*rand(1);
    imOut = im - uint8(noiseMag*rand(size(im)));
end