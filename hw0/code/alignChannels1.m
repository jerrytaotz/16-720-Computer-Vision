function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a 
%       color image, compute the best aligned result with minimum 
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%   corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
% red = [1,2,3,4;
%         5,6,7,8;
%         9,8,7,6;
%         5,4,3,2]
pixels = size(red);
row = pixels(1);
col = pixels(2);
SSD = inf;
green_align = zeros(row,col);
blue_align = zeros(row,col);
green_UD = 0;
% for i =-11:1:-11
for i=-30:1:30
    green_move = zeros(row, col);
    green_move = uint8(green_move);
    if i>=0
        green_move(1+i:end, :) = green(1:end-i,:);
        for x=1:1:i
            green_move(x,:)=green(1,:);
        end
    else
        green_move(1:end+i, :) = green(1-i:end,:);
        for x=row+i+1:1:row
            green_move(x,:)=green(end,:);
        end
    end
    dif = zeros(row,col);
    dif = green_move-red;
    temp = sum(sum((dif.*dif)));
    if temp < SSD
        green_align = green_move;
        SSD = temp;
        green_UD = i;
    end
end

green(:,:) = green_align(:,:);
SSD = inf;
green_LR = 0;
% for i=-1:1:-1
for i=-30:1:30
    green_move = zeros(row, col);
    green_move = uint8(green_move);
    if i>=0
        green_move(:, 1+i:end) = green(:, 1:end-i);
        for x=1:1:i
            green_move(:, x)=green(:, 1);
        end
    else
        green_move(:, 1:end+i) = green(:, 1-i:end);
        for x=col+i+1:1:col
            green_move(:, x)=green(:, end);
        end
    end
    dif = zeros(row,col);
    dif = green_move-red;
    temp = sum(sum((dif.*dif)));
    if temp < SSD
        green_align = green_move;
        SSD = temp;
        green_LR = i;
    end
end


SSD = inf;
blue_UD = 0;
% for i=-22:1:-22
for i=-30:1:30
    blue_move = zeros(row, col);
    blue_move = uint8(blue_move);
    if i>=0
        blue_move(1+i:end, :) = blue(1:end-i,:);
        for x=1:1:i
            blue_move(x,:)=blue(1,:);
        end
    else
        blue_move(1:end+i, :) = blue(1-i:end,:);
        for x=row+i+1:1:row
            blue_move(x,:)=blue(end,:);
        end
    end
    dif = zeros(row,col);
    dif = blue_move-red;
    temp = sum(sum((dif.*dif)));
    if temp < SSD
        blue_align = blue_move;
        SSD = temp;
        blue_UD = i;
    end
end

blue(:,:) = blue_align(:,:);
SSD = inf;
blue_LR = 0;
% for i=-9:1:-9
for i=-30:1:30
    blue_move = zeros(row, col);
    blue_move = uint8(blue_move);
    if i>=0
        blue_move(:, 1+i:end) = blue(:, 1:end-i);
        for x=1:1:i
            blue_move(:, x)=blue(:, 1);
        end
    else
        blue_move(:, 1:end+i) = blue(:, 1-i:end);
        for x=col+i+1:1:col
            blue_move(:, x)=blue(:, end);
        end
    end
    dif = zeros(row,col);
    dif = blue_move-red;
    temp = sum(sum((dif.*dif)));
    if temp < SSD
        blue_align = blue_move;
        SSD = temp;
        blue_LR = i;
    end
end

% green_UD
% green_LR
% blue_UD
% blue_LR

rgbResult = cat(3,red, green_align, blue_align);
end