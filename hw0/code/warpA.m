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

%% Resolve without loop
inv_A = inv(A);
warp_x = out_size(2);
warp_y = out_size(1);
% warp_im = zeros(out_size(1),out_size(2));
[X,Y] = meshgrid(1:warp_x,1:warp_y);
size_X = size(X);
size_Y = size(Y);
temp1 = inv_A(1:2,1)*X(1:size_X(1)*size_X(2));
temp2 = inv_A(1:2,2)*Y(1:size_Y(1)*size_Y(2));
P_source = temp1+temp2;
P_source(1,:) = P_source(1,:)+inv_A(1,3);
P_source(2,:) = P_source(2,:)+inv_A(2,3);
P_source = round(P_source);
Xs = reshape(P_source(1,:),size(X));
Ys = reshape(P_source(2,:),size(Y));
warp_im = interp2(X,Y,im,Xs,Ys);

%% resolve with Loop
% pixels = size(im);
% cx = pixels(2);
% cy = pixels(1);
% warp_im = zeros(out_size(1),out_size(2));
% for y=1:1:out_size(1)
%     for x=1:1:out_size(2)
%         P_warped = [x;y;1];
%         P_source = round(A\P_warped);
%         if P_source(1)>=1 && P_source(1)<=cx && P_source(2)>=1 && P_source(2)<=cy
%             warp_im(y,x)=im(P_source(2),P_source(1));
%         else
%             warp_im(y,x) = 0;
%         end
%     end
% end
end