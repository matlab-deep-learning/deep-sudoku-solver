function lgraph = resnetLike()
    
% Copyright 2018, The MathWorks, Inc.
    
    net = resnet50();
    lgraph = layerGraph(net);
    lgraph = removeLayers(lgraph, ...
        {'input_1', ...
         'avg_pool', ...
         'fc1000', ...
         'fc1000_softmax', ...
         'ClassificationLayer_fc1000'});
    
    lgraph = addLayers(lgraph, imageInputLayer([64, 64, 3], 'Name', 'input'));
    lgraph = connectLayers(lgraph, 'input', 'conv1');

    numClasses = 10;
    newLayers = [
        averagePooling2dLayer([2, 2], 'Name', 'avg_pool')
        fullyConnectedLayer(numClasses,'Name','fc')
        softmaxLayer('Name','softmax')
        classificationLayer('Name','classoutput')];
    lgraph = addLayers(lgraph,newLayers);

    lgraph = connectLayers(lgraph,'activation_49_relu','avg_pool');

end