% Problem 1: Image Alignment

%% 1. Load images (all 3 channels)
% red = [];
% green = [];
% blue = [];
% Red channel as 'red'
% Green channel as 'green'
% Blue channel as 'blue'
% red_mat = load('../data/red.mat');
% green_mat = load('../data/green.mat');
% blue_mat = load('../data/blue.mat');
% red = red_mat.red;
% green = green_mat.green;
% blue = blue_mat.blue;
red = importdata('../data/red.mat');
green = importdata('../data/green.mat');
blue = importdata('../data/blue.mat');

%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
rgbResult = alignChannels(red, green, blue);
%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
imwrite(rgbResult, '../results/rgbResult.jpg');

% %% 2. Find best alignment
% % Hint: Lookup the 'circshift' function
% rgbResult1 = alignChannels1(red, green, blue);
% %% 3. Save result to rgb_output.jpg (IN THE "results" folder)
% imwrite(rgbResult1, '../results/rgbResult1.jpg');
