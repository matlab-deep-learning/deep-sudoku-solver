function visualiseClassifier(net)
% visualiseClassifier   Generate tsne based visualisation of classifier.
%
%   sudoku.visualiseClassifier(net);
%
%   Args:
%       net:  Classifier network

% Copyright 2018, The MathWorks, Inc.

    % Parameters
    perplexity = 25;
    canvasScale = 15;
    imageSize = 10;

    % Get test data
    [~, test] = sudoku.training.getNumberData(0, false);

    % Get the activations
    X = activations(net, test, 'fc_1', 'OutputAs', 'channels');
    predictions = net.classify(test);
    X = squeeze(X);
    Y = tsne(X', 'Perplexity', perplexity);

    % Generate the figure
    figure
    hold on
    cmap = colormap('hsv');
    cmap = cmap(7:end-6, :);

    for iNum = 1:numel(test.Labels)
        im = test.readimage(iNum);
        label = test.Labels(iNum);
        num = str2double(char(label));
        index = ceil(size(cmap, 1)*(num+1)/10);
        x = canvasScale*Y(iNum,1);
        y = canvasScale*Y(iNum,2);
        image('XData', [x, x+imageSize], ...
              'YData', [y, y-imageSize], ...
              'CData', im)

        if label ~= predictions(iNum)
            edgeColor = 'r';
        else
            edgeColor = cmap(index, :);
        end

        rectangle('Position', [x, y-imageSize, imageSize, imageSize], ...
                  'EdgeColor', edgeColor, ...
                  'LineWidth', 2);

    end
    grid on
    axis equal
    set(gca,'YColor','none')
    set(gca,'XColor','none')
    currentXLim = get(gca,'XLim');
    xlim([currentXLim(1) - 100, currentXLim(2) + 100])
end