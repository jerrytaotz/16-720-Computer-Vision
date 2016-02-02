function [ filterBank, dictionary ] = getFilterBankAndDictionary( image_names )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% K between 100 and 300 is sensible initial value
K = 200;
% alpha between 50 and 150 is sensible initial value
alpha = 75;
% T is the number of training images
T = length(image_names);
% get the filter bank by function
filterBank = createFilterBank();
% F is filter bank size
F = length(filterBank);
filter_responses_all = zeros(alpha*T, 3*F);
% Load each image file
for i=1:1:T
    img = imread(image_names{i});
    % Select alpha pixels randomly
    rand_pixels = randperm(size(img,1)*size(img,2),alpha);
    filter_responses = extractFilterResponses(img, filterBank);
    filter_responses_all(((i - 1) * alpha + 1):(i * alpha), :) = filter_responses(rand_pixels, :);
end
[~, dictionary] = kmeans(filter_responses_all, K, 'EmptyAction','drop');
dictionary = dictionary';
end

