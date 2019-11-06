function im = makePaper(resolution, minWhite, maxNoise)
    
    % Copyright 2018 The MathWorks, Inc.
    
    baseColour = minWhite + rand(1)*(255 - minWhite);
    im = 255*ones(resolution, resolution, 3, 'uint8');
    noiseValue = maxNoise*rand();
    im = im - uint8(noiseValue*rand(size(im)));
end