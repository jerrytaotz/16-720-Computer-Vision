function [ wordMap ] = getVisualWords( I, filterBank, dictionary )
%GETVISUALWORDS Summary of this function goes here
%   Detailed explanation goes here
% Get filter resbonses
[filter_responses] = extractFilterResponses(I, filterBank);
% Calculate the standard Euclidean distance between filter_responses and
% dictionary

distance = pdist2(filter_responses, dictionary');
% Get the minimum distance and its index
% Return a column vector, the value in column i is the minimum number of
% ith row in the matrix distance
[min_distance, index] = min(distance,[],2);
wordMap = reshape(index, [size(I,1), size(I,2)]);
end

