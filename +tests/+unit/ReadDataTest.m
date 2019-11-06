classdef ReadDataTest < matlab.unittest.TestCase
    
    % Copyright 2018 The MathWorks, Inc.
   
    methods (Test)
        function testImportOneLabel(testCase)
            data = sudoku.training.readNumberLabels('+tests/data1');

            testCase.verifyEqual(length(data), 1);
            testCase.verifyEqual(size(data('0001')), [9, 9]);
        end
        
        function testImportTwoLabels(testCase)
            data = sudoku.training.readNumberLabels('+tests/data2');

            testCase.verifyEqual(length(data), 2);
            testCase.verifyEqual(size(data('0001')), [9, 9]);
            testCase.verifyEqual(size(data('0002')), [9, 9]);
        end
        
        function testImportBadNumbers(testCase)
            importData = @() sudoku.training.readNumberLabels('+tests/bad_data1');

            testCase.verifyError(importData, 'sudoku:BadNumberData');
        end
        
        function testImportBadLabels(testCase)
            importData = @() sudoku.training.readNumberLabels('+tests/bad_data2');

            testCase.verifyError(importData, 'sudoku:DuplicateLabel');
        end
        
        function testNameParseing(testCase)
            testName = 'C:\one\two\0003_04.jpg';
            
            [sudokuNumber, repeat] = sudoku.training.parseFilename(testName);
            
            testCase.verifyEqual(sudokuNumber, '0003');
            testCase.verifyEqual(repeat, '04');
        end
    end
end
