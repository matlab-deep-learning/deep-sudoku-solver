function lgraph = weightLossByFrequency(lgraph, pixelImageDataStore)
    
% Copyright 2018, The MathWorks, Inc.

    pixelCounts = countEachLabel(pixelImageDataStore);
    imageFreq = pixelCounts.PixelCount./pixelCounts.ImagePixelCount;
    classWeights = mean(imageFreq)./imageFreq;
    pxLayer = pixelClassificationLayer('Name', 'labels', ...
                                        'ClassNames', pixelCounts.Name, ...
                                        'ClassWeights', classWeights);
    lgraph = removeLayers(lgraph, 'pixelLabels');
    lgraph = addLayers(lgraph, pxLayer);
    lgraph = connectLayers(lgraph, 'softmax', 'labels');

end