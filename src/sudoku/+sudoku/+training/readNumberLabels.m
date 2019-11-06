function data = readNumberLabels(filename)
    
% Copyright 2018, The MathWorks, Inc.
    
    data = containers.Map();
    
    fid = fopen(filename);
    
    while ~feof(fid)
        name = textscan(fid, '%s', 1);
        name = name{1};
        if isempty(name)
            continue
        end
        
        numbers = textscan(fid, '%d', 81);
        assert(numel(numbers{1}) == 81, ...
                'sudoku:BadNumberData', ...
                'Number labels for ''%s'' are of incorrect size.', name{1});
        
        newName = name{1};
        assert(~ismember(newName, data.keys()), ...
                'sudoku:DuplicateLabel', ...
                'The label ''%s'' is duplicated.', newName);
            
        data(newName) = reshape(numbers{1}, 9, 9)';
    end
    
    fclose(fid);
end