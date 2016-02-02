function [ h ] = getImageFeaturesSPM( layerNum, wordMap, dictionarySize )
%%
%GETIMAGEFEATURESSPM Summary of this function goes here
% Spatial Pyramid Matching
% Input:
%  layerNum: the number of layers in the spatial pyramid, i.e., L + 1
%  wordMap: a H ? W image containing the IDs of the visual words
%  dictionarySize: the maximum visual word ID (i.e., the number of visual words, the dictionary size)
% Output:
%  h: a vector that is L1 normalized

%%
%   Detailed explanation goes here
% The resulting vector has dimensionality
dimension = dictionarySize * (4 ^ layerNum - 1) / 3;
% LayerNum defines level 0 ~ layerNum-1
L = layerNum - 1;
% Initialize the outoput vector 'h'
h = zeros(dimension, 1);
% Chops the image into 2^L * 2^L cells
cell_size = 2 ^ L;
% The size of wordMap
height = size(wordMap,1);
width = size(wordMap,2);
% First calculate the finest layer (Divide image to 2^L * 2^L parts)
i_step_len = floor(height / cell_size);
j_step_len = floor(width / cell_size);
for i = 1:1:cell_size
    for j = 1:1:cell_size
        wordMap_cell_num = (i - 1) * cell_size + j;
        wordMap_cell = wordMap((i-1)*i_step_len+1:i*i_step_len,(j-1)*j_step_len+1:j*j_step_len);
        
    end
end
% Calculate the weight for each level
weight = zeros(layerNum,1);
weight(1:2,1) = [2^(-L); 2^(-L)];
for i = 0:1:L
    if i == 0 || i == 1
        weight(i+1,1) = 2^(-L);
    else
        weight(i+1,1) = 2 * weight(i,1);
    end
end

end

