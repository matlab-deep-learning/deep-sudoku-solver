function data = getMnistData()
    
    % Copyright 2018 The MathWorks, Inc.

    persistent digitData
    
    if isempty(digitData)
        mnist = load('number_data/mnist.mat', 'training');
        digitData = mnist.training;
    end
    
    data = digitData;
    
end