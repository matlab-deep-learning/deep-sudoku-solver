function uninstall()
    
    % Copyright 2018 The MathWorks, Inc.
    
    thisPath = fileparts(mfilename('fullpath'));
    rmpath(fullfile(thisPath, 'src', 'sudoku'));
    
end