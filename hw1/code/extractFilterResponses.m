function [filterResponses] = extractFilterResponses(I, filterBank)
% CV Fall 2015 - Provided Code
% Extract the filter responses given the image and filter bank
% Pleae make sure the output format is unchanged. 
% Inputs: 
%   I:                  a 3-channel RGB image with width W and height H 
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses
 

% Convert input Image to Lab
doubleI = double(I);
% Duplicate gray-scale imags into three-channel
if (size(doubleI,3) ~= 3)
    doubleI = repmat(doubleI,[1,1,3]);
end
[L,a,b] = RGB2Lab(doubleI(:,:,1), doubleI(:,:,2), doubleI(:,:,3));
pixelCount = size(doubleI,1)*size(doubleI,2);

%filterResponses:    a W*H x N*3 matrix of filter responses
filterResponses = zeros(pixelCount, length(filterBank)*3);

%for each filter and channel, apply the filter, and vectorize

%% === fill in your implementation here  ===
% g = imfilter(f, w, filtering_mode, boundary_options, size_options)
%   f: the input image; w: the filter; g: the filtered image;
%   filtering_mode: convolution or correlation
%   boundary_options: operations at edge
for i=1:length(filterBank)
    %% convolving image by each filter in filter bank
    % filterBank is a cell array, so use filterBank{i} to get the filter
    L_filtered = imfilter(L, filterBank{i}, 'conv'); % size_options 'same' is default
    a_filtered = imfilter(a, filterBank{i}, 'conv');
    b_filtered = imfilter(b, filterBank{i}, 'conv');
    %% vectorize
    L_vectorize = reshape(L_filtered, [pixelCount, 1]);
    a_vectorize = reshape(a_filtered, [pixelCount, 1]);
    b_vectorize = reshape(b_filtered, [pixelCount, 1]);
    %% save the vectorizing result
    filterResponses(:, (i-1)*3+1) = L_vectorize;
    filterResponses(:, (i-1)*3+2) = a_vectorize;
    filterResponses(:, (i-1)*3+3) = b_vectorize;
end

end
