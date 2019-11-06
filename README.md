# Deep Sudoku Solver

__Takes an uncontrolled image of a sudoku puzzle, identifies the location, reads the puzzle, and solves it.__

This example was originally put together for the [UK MATLAB Expo](https://www.matlabexpo.com/uk) 2018, for a talk entitled _Computer Vision and Image processing with MATLAB ([video](https://www.mathworks.com/videos/image-processing-and-computer-vision-with-matlab-1541003708736.html), [blog post(https://blogs.mathworks.com/deep-learning/2018/11/15/sudoku-solver-image-processing-and-deep-learning/)])_. It is intended to demonstrate the use of a combination of deep learning and image procesing to solve a computer vision problem.

## Getting started

- Get a copy of the code either by cloning the repository or downloading a .zip
- Run the example live script getting_started.mlx

## Details

Broadly the algorithm is divided into four distinct steps:

1. Find the sudoku puzzle in an image using deep learning (sematic segmentation)
2. Extracts each of the 81 number boxes in the puzzle using image processing.
3. Read the number contained in each box using deep learning.
4. Solve the puzzle using opimisation.

For more details see the original [Expo talk](https://www.mathworks.com/videos/image-processing-and-computer-vision-with-matlab-1541003708736.html).

![](presentation/reprojected_result.jpg)

## Usage

- Install my navigating to the top level directory then running `install()` to add the required folders to the MATLAB path.
- Run `setupData()` to fetch the required training data from my public drive.
- Run `sudoku.trainSemanticSegmentation(filename)`
where `filename` is the name under which the trainded network will be saved (in the `models/` folder).
- Run `sudoku.trainNumberNetwork(filename)`
- TODO run on a single image

## Contributing

Please file any bug reports or questions as [GitHub issues](https://github.com/mathworks/deep-sudoku-solver/issues).

_Copyright 2018 The MathWorks, Inc._