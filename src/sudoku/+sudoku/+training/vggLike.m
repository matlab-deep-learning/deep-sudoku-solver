function layers = vggLike(n, imageSize)
    
% Copyright 2018, The MathWorks, Inc.
    
    layers = [imageInputLayer([imageSize(1), imageSize(2), 3])
            convolution2dLayer([5, 5], n, 'Stride', [3, 3], 'Padding', 'same')
            reluLayer
            batchNormalizationLayer
            ...
            convolution2dLayer([3, 3], n, 'Padding', 'same')
            reluLayer
            batchNormalizationLayer
            ...
            convolution2dLayer([3, 3], n, 'Padding', 'same')
            reluLayer
            batchNormalizationLayer
            maxPooling2dLayer([2, 2], 'Stride', [2, 2], 'Padding', 'same')
            ...
            convolution2dLayer([3, 3], 2*n, 'Padding', 'same')
            reluLayer
            batchNormalizationLayer
            ...
            convolution2dLayer([3, 3], 2*n, 'Padding', 'same')
            reluLayer
            batchNormalizationLayer
            maxPooling2dLayer([2, 2], 'Stride', [2, 2], 'Padding', 'same')
            ...
            convolution2dLayer([3, 3], 4*n, 'Padding', 'same')
            reluLayer
            batchNormalizationLayer
            ...
            convolution2dLayer([3, 3], 4*n, 'Padding', 'same')
            reluLayer
            batchNormalizationLayer
            maxPooling2dLayer([2, 2], 'Stride', [2, 2], 'Padding', 'same')
            ...
            convolution2dLayer([3, 3], 8*n, 'Padding', 'same')
            reluLayer
            batchNormalizationLayer
            ...
            convolution2dLayer([3, 3], 8*n, 'Padding', 'same')
            reluLayer
            batchNormalizationLayer
            ...
            convolution2dLayer([3, 3], 8*n, 'Padding', 'same')
            reluLayer
            batchNormalizationLayer
            maxPooling2dLayer([2, 2], 'Stride', [2, 2], 'Padding', 'same')
            ...
            fullyConnectedLayer(8*n)
            dropoutLayer(0.5)
            fullyConnectedLayer(10)
            softmaxLayer
            classificationLayer];
end