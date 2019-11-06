classdef Mnist < handle
    
    % Copyright 2018 The MathWorks, Inc.
    
    properties (Dependent)
        Cache
    end
    
    properties
        Cache_
    end
    
    %% Public Methods
    methods (Static)
        function output = getInstance()
            persistent singletonObj
            if isempty(singletonObj) || ~isvalid(singletonObj)
                singletonObj = sudoku.synth.Mnist();
            end
            output = singletonObj;
        end    
    end
    
    
    %% Private helper functions
    methods (Access = private)
        function obj = Mnist()
        end
    end
    
    methods
        function clearCache(obj)
            obj.Cache_ = [];
        end
        
        function val = get.Cache(obj)
            if isempty(obj.Cache_)
                dataFile = fullfile(sudokuRoot(), 'data', 'number_data', 'mnist.mat');
                mnist = load(dataFile, 'training');
                obj.Cache_ = mnist.training;
            end
            val = obj.Cache_;
        end
    end
end