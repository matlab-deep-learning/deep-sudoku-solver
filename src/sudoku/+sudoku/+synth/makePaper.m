function im = makePaper(resolution, minWhite, maxNoise)
    noiseValue = ceil(maxNoise*rand());
    im = 255 - randi(noiseValue, resolution, resolution, 3, 'uint8');
 
    % Copyright 2018 The MathWorks, Inc.
end