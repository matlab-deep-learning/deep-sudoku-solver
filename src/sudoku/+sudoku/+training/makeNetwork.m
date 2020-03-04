function lgraph = makeNetwork(imageSize)
    
    lgraph = layerGraph();
    
    input = imageInputLayer(imageSize, "Name", "input");
    stem = [convBnRelu("stem", 64)
	    convBnRelu("stem2", 64, true)];
    layer1 = convBnRelu("layer1", 128, true);
    layer1 = [
        layer1
        convBnRelu("layer1_2", 128, false)
        convBnRelu("layer1_3", 128, false)
        additionLayer(2, "Name", "add1")
        ];
    
    layer2 = convBnRelu("layer2", 256, true);
    
    layer3 = convBnRelu("layer3", 512, true);
    layer3 = [
        layer3
        convBnRelu("layer3_2", 512, false);
        convBnRelu("layer3_3", 512, false)
        additionLayer(2, "Name", "add3")
    ];
    
    output = [
        maxPooling2dLayer(4, "Name", "pool", "Stride", 4)
        fullyConnectedLayer(10, "Name", "fc", ...
            "WeightsInitializer", @(x) sudoku.training.kaimingUniform(x, "fc"))
        softmaxLayer("Name", "softmax")
        classificationLayer("Name", "classes")
        ];
    
    lgraph = lgraph.addLayers([
        input
        stem
        layer1
        layer2
        layer3
        output]);
    
    lgraph = lgraph.connectLayers("layer1_pool", "add1/in2");
    lgraph = lgraph.connectLayers("layer3_pool", "add3/in2");
end

function layers = convBnRelu(label, filters, pool)
    
    if nargin < 3
        pool = false;
    end
    
    name = @(x) strjoin([label, x], "_");
    
    layers = [
            convolution2dLayer(3, filters, ...
                            "Name", name("conv"), ...
                            "Padding", 1, ...
                            "Stride", 1, ...
                            "WeightsInitializer", @(x) sudoku.training.kaimingUniform(x, "conv"));
            batchNormalizationLayer("Name", name("bn"))
            reluLayer("Name", name("relu"));
        ];
    
    if pool
        layers(end+1) = maxPooling2dLayer(2, "Name", name("pool"), "Stride", 2);
    end
    
end
