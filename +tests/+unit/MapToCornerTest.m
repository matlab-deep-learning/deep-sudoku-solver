classdef MapToCornerTest < matlab.unittest.TestCase
    
    % Copyright 2018 The MathWorks, Inc.
    
    methods (Test)
        function testLineIntersectionOrigin(testCase)
            line1 = [0, 0];
            line2 = [0, pi/2];
            
            intersection = sudoku.intersect(line1, line2);
            
            testCase.verifyEqual(intersection, [0, 0]);
        end
        
        function testLineIntersectionPositive(testCase)
            line1 = [100, 0];
            line2 = [100, pi/2];
            
            intersection = sudoku.intersect(line1, line2);
            
            testCase.verifyEqual(intersection, [100, 100]);
        end
        
        function testLineIntersectionNegative(testCase)
            line1 = [100, 0];
            line2 = [-100, -pi/2];
            
            intersection = sudoku.intersect(line1, line2);
            
            testCase.verifyEqual(intersection, [100, 100]);
        end
        
        function testLineIntersectionParallel(testCase)
            line1 = [0, 0];
            line2 = [100, 0];
            
            intersect = @() sudoku.intersect(line1, line2);
            
            testCase.verifyError(intersect, 'sudoku:intersect:noIntersection');
        end
  
        function testMultiLineIntersect(testCase)
            lines = [0, 0;
                     100, 0;
                     0, pi/2;
                     100, pi/2];
                 
            intersections = sudoku.intersectAll(lines);
            
            testCase.verifyEqual(size(intersections, 1), 6);
            testCase.verifyTrue(testCase.pointInArray(intersections, [0, 0], 1e-6));
            testCase.verifyTrue(testCase.pointInArray(intersections, [100, 0], 1e-6));
            testCase.verifyTrue(testCase.pointInArray(intersections, [0, 100], 1e-6));
            testCase.verifyTrue(testCase.pointInArray(intersections, [100, 100], 1e-6));
        end
        
        function testMultiLineIntersectParallel(testCase)
            lines = [0, 0;
                     100, 0;];
                 
            intersections = sudoku.intersectAll(lines);
            
            testCase.verifyEqual(size(intersections, 1), 1);
            testCase.verifyEqual(intersections, [NaN, NaN]);
        end
        
        function testMapToIntersections(testCase)
            im = imread('+tests/Label_1.png');
            map = im == 1;
            
            lines = sudoku.getMapLines(map);
            intersections = sudoku.intersectAll(lines);
            
            testCase.verifyEqual(size(intersections, 1), 6);
            testCase.verifyTrue(testCase.pointInArray(intersections, [2180, 788], 1));
            testCase.verifyTrue(testCase.pointInArray(intersections, [2781, 943], 1));
            testCase.verifyTrue(testCase.pointInArray(intersections, [1933, 1215], 1));
            testCase.verifyTrue(testCase.pointInArray(intersections, [2596, 1412], 1));
        end
        
        function testMapToSortedIntersections(testCase)
            im = imread('+tests/Label_1.png');
            map = im == 1;
            expectedIntersections = [2180, 788;
                                     2781, 943;
                                     2596, 1412;
                                     1933, 1215;];
            
            lines = sudoku.getMapLines(map);
            intersections = sudoku.intersectAll(lines);
            intersections = sudoku.selectAndSort(intersections);
            
            testCase.verifyEqual(size(intersections, 1), 4);
            testCase.verifyEqual(intersections, expectedIntersections, 'AbsTol', 1);
        end
        
        function testSelectAndSortRemoveParallel(testCase)
            intersections = [0, 0;
                             100, 0;
                             NaN, NaN;
                             100, 100];
                 
            intersections = sudoku.selectAndSort(intersections);
            
            testCase.verifyEqual(size(intersections, 1), 3);
        end
        
        function testSelectAndSortRemoveDistant(testCase)
            intersections = [0, 0;
                             100, 0;
                             0, 100;
                             100, 100;
                             500, 1000];
                 
            intersections = sudoku.selectAndSort(intersections);
            
            testCase.verifyEqual(size(intersections, 1), 4);
        end
    end
    
    methods (Static)
        function tf = pointInArray(points, testPoint, tolerance)
            testResult = sum(sum(abs(points - testPoint) < tolerance, 2) == 2);
            tf = testResult == 1;
        end
    end
    
end