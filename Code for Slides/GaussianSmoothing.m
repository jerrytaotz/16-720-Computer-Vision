matrix_size = 5;
sigma = 0.5;
Gaussian_matrix = zeros(matrix_size, matrix_size);
if mod(matrix_size,2)==1
    x = (matrix_size - 1)/2;
else
    x = matrix_size/2;
end
for i=-x:1:x
    for j=-x:1:x
        Gaussian_matrix(i+x+1,j+x+1) = (1/(2*pi*sigma^2))*exp(-1/2*(i^2+j^2)/sigma^2);
    end
end
Gaussian_matrix