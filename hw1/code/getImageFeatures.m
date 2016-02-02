function [ h ] = getImageFeatures( wordMap, dictionarySize )
%GETIMAGEFEATURES Summary of this function goes here
%%  Parameters description
%   Detailed explanation goes here
% Input:
%   wordMap: a H × W image containing the IDs of the visual words
%   dictionarySize: the maximum visual word ID (i.e., the number of visual words, the dictionary size)
% Output:
%   h: a dictionarySize × 1 histogram that is L1 normalized

%%  Generate the histogram
% 
h = hist(wordMap, 1:dictionarySize);
% L1 normalize
h = h / sum(h);
h = h';
end

