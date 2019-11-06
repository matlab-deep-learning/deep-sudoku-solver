function [sudokuNumber, repeat] = parseFilename(testName)
    
% Copyright 2018, The MathWorks, Inc.

    [~, name] = fileparts(testName);
    
    nameParts = split(name, '_');
    sudokuNumber = nameParts{1};
    repeat = nameParts{2};
end