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
pixels = size(red);
row = pixels(1);
col = pixels(2);
SSD = inf;
green_align = zeros(row,col);
blue_align = zeros(row,col);

green1 = 0;
green2 = 0;
for i=-30:1:30
    green_UD = zeros(row,col);
    if i<0
        green_UD(1:end+i, :) = green(1-i:end,:);
        for x=row+i+1:1:row
            green_UD(x,:)=green(end,:);
        end
    else
        green_UD(1+i:end, :) = green(1:end-i,:);
        for x=1:1:i
            green_UD(x,:)=green(1,:);
        end
    end
    for j=-30:1:30
        green_move = zeros(row,col);
        if j<0
            green_move(:, 1:end+j) = green_UD(:, 1-j:end);
            for x=col-j+1:1:col
                green_move(:, x)=green_UD(:, end);
            end
        else
            green_move(:, 1+j:end) = green_UD(:, 1:end-j);
            for x=1:1:j
                green_move(:, x)=green_UD(:, 1);
            end
        end
        dif = zeros(row,col);
        green_move = uint8(green_move);
        dif = green_move-red;
        temp = sum(sum((dif.*dif)));
        if temp < SSD
            green_align = green_move;
            SSD = temp;
            green1 = i;
            green2 = j;
        end
    end
end

SSD = inf;
blue1 = 0;
blue2 = 2;
for i=-30:1:30
    blue_UD = zeros(row,col);
    if i<0
        blue_UD(1:end+i, :) = blue(1-i:end,:);
        for x=row+i+1:1:row
            blue_UD(x,:)=blue(end,:);
        end
    else
        blue_UD(1+i:end, :) = blue(1:end-i,:);
        for x=1:1:i
            blue_UD(x,:)=blue(1,:);
        end
    end
    for j=-30:1:30
        blue_move = zeros(row,col);
        if j<0
            blue_move(:, 1:end+j) = blue_UD(:, 1-j:end);
            for x=col+j+1:1:col
                blue_move(:, x)=blue_UD(:, end);
            end
        else
            blue_move(:, 1+j:end) = blue_UD(:, 1:end-j);
            for x=1:1:j
                blue_move(:, x)=blue_UD(:, 1);
            end
        end
        dif = zeros(row,col);
        blue_move = uint8(blue_move);
        dif = blue_move-red;
        temp = sum(sum((dif.*dif)));
        if temp < SSD
            blue_align = blue_move;
            SSD = temp;
            blue1 = i;
            blue2 = j;
        end
    end
end
% 
% green1
% green2
% blue1
% blue2
rgbResult = cat(3,red, green_align, blue_align);
end