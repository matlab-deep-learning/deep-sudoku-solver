function [S,eflag] = sudokuEngine(B)
% This function sets up the rules for Sudoku. It reads in the puzzle
% expressed in matrix B, calls intlinprog to solve the puzzle, and returns
% the solution in matrix S.
%
% The matrix B should have 3 columns and at least 17 rows (because a Sudoku
% puzzle needs at least 17 entries to be uniquely solvable). The first two
% elements in each row are the i,j coordinates of a clue, and the third
% element is the value of the clue, an integer from 1 to 9. If B is a
% 9-by-9 matrix, the function first converts it to 3-column form.

%   Copyright 2014 The MathWorks, Inc. 

    if isequal(size(B),[9,9]) % 9-by-9 clues
        % Convert to 81-by-3
        [SM,SN] = meshgrid(1:9); % make i,j entries
        B = [SN(:),SM(:),B(:)]; % i,j,k rows
        % Now delete zero rows
        [rrem,~] = find(B(:,3) == 0);
        B(rrem,:) = [];
    end

    if size(B,2) ~= 3 || length(size(B)) > 2
        error('The input matrix must be N-by-3 or 9-by-9')
    end

    if sum([any(B ~= round(B)),any(B < 1),any(B > 9)]) % enforces entries 1-9
        error('Entries must be integers from 1 to 9')
    end

    %% The rules of Sudoku:
    N = 9^3; % number of independent variables in x, a 9-by-9-by-9 array
    M = 4*9^2; % number of constraints, see the construction of Aeq
    Aeq = zeros(M,N); % allocate equality constraint matrix Aeq*x = beq
    beq = ones(M,1); % allocate constant vector beq
    f = (1:N)'; % the objective can be anything, but having nonconstant f can speed the solver
    lb = zeros(9,9,9); % an initial zero array
    ub = lb+1; % upper bound array to give binary variables

    counter = 1;
    for j = 1:9 % one in each row
        for k = 1:9
            Astuff = lb; % clear Astuff
            Astuff(1:end,j,k) = 1; % one row in Aeq*x = beq
            Aeq(counter,:) = Astuff(:)'; % put Astuff in a row of Aeq
            counter = counter + 1;
        end
    end

    for i = 1:9 % one in each column
        for k = 1:9
            Astuff = lb;
            Astuff(i,1:end,k) = 1;
            Aeq(counter,:) = Astuff(:)';
            counter = counter + 1;
        end
    end

    for U = 0:3:6 % one in each square
        for V = 0:3:6
            for k = 1:9
                Astuff = lb;
                Astuff(U+(1:3),V+(1:3),k) = 1;
                Aeq(counter,:) = Astuff(:)';
                counter = counter + 1;
            end
        end
    end

    for i = 1:9 % one in each depth
        for j = 1:9
            Astuff = lb;
            Astuff(i,j,1:end) = 1;
            Aeq(counter,:) = Astuff(:)';
            counter = counter + 1;
        end
    end

    %% Put the particular puzzle in the constraints
    % Include the initial clues in the |lb| array by setting corresponding
    % entries to 1. This forces the solution to have |x(i,j,k) = 1|.

    for i = 1:size(B,1)
        lb(B(i,1),B(i,2),B(i,3)) = 1;
    end

    %% Solve the Puzzle
    % The Sudoku problem is complete: the rules are represented in the |Aeq|
    % and |beq| matrices, and the clues are ones in the |lb| array. Solve the
    % problem by calling |intlinprog|. Ensure that the integer program has all
    % binary variables by setting the intcon argument to |1:N|, with lower and
    % upper bounds of 0 and 1.

    intcon = 1:N;

    [x,~,eflag] = intlinprog(f,intcon,[],[],Aeq,beq,lb,ub);

    %% Convert the Solution to a Usable Form
    % To go from the solution x to a Sudoku grid, simply add up the numbers at
    % each $(i,j)$ entry, multiplied by the depth at which the numbers appear:

    if eflag > 0 % good solution
        x = reshape(x,9,9,9); % change back to a 9-by-9-by-9 array
        x = round(x); % clean up non-integer solutions
        y = ones(size(x));
        for k = 2:9
            y(:,:,k) = k; % multiplier for each depth k
        end

        S = x.*y; % multiply each entry by its depth
        S = sum(S,3); % S is 9-by-9 and holds the solved puzzle
    else
        S = [];
    end
end