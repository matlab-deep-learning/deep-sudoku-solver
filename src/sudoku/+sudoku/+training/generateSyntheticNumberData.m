function generateSyntheticNumberData(outputFolder, nSamples)
% generateSyntheticNumberData   generate synthetic number images
%
%   sudoku.training.generateSyntheticNumberData(outputFolder, nSamples)
%
%   Args:
%       outputFolder (char):    output directory to save the data
%       nSamples (double):      number of synthetic images to generate for
%                               each digit
%
%   Note:
%       The output folder must be empty.
%       The synthetic data generate is carried out in parallel.

% Copyright 2018, The MathWorks, Inc.

    if isfolder(outputFolder)
        existingFiles = dir(fullfile(outputFolder, '*'));
        assert(numel(existingFiles) == 2, ...
            'sudoku:generateSyntheticNumberData', ...
            'Output folder is not empty.');
    end

    parfor iDigit = 0:9
        fprintf('Generating digit %d', iDigit);
        dataDir = fullfile(outputFolder, num2str(iDigit));
        if ~isfolder(dataDir)
            mkdir(dataDir);
        end
        for iSample = 1:nSamples
            handWritten = iSample < nSamples/2;
            im = sudoku.synth.makeSyntheticDigit(iDigit, handWritten);
            imwrite(im, fullfile(dataDir, sprintf('%0.5d.jpg', iSample)), ...
                    'Quality', 20 + randi(55));
            if rem(iSample/nSamples*10, 1) == 0
                fprintf('.');
            end
        end
        fprintf('done.\n');
    end
end