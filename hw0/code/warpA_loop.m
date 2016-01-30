function [ warp_im ] = warpA( im, A, out_size )
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.
% INPUTS:
%   im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%   warp_im : result of warping im by A
pixels = size(im);
cx = pixels(2);
cy = pixels(1);
warp_im = zeros(out_size(1),out_size(2));
row = pixels(1);
col = pixels(2);
for i=1:1:out_size(1)
    for j=1:1:out_size(2)
        P_warped = [i;j;1];
        P_source = round(A\P_warped);
        if P_source(1)>=1 && P_source(1)<=row && P_source(2)>=1 && P_source(2)<=col
            warp_im(i,j)=im(P_source(1),P_source(2));
        else
            warp_im(i,j) = 0;
        end
    end
end
end