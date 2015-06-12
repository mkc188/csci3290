
%% config & input

% Topic = 'snow';
Topic = 'notebook';

backImageName = [Topic '.png'];
foreImageName = [Topic '2.png'];
maskName = [Topic '_mask.png'];
outputName = [Topic '_out_poisson.png'];

backImg = im2double(imread(backImageName));
foreImg = im2double(imread(foreImageName));
mask = im2double(imread(maskName));

[rows,cols,channels] = size(backImg);

tic;

%% build matrix A and B

A = spalloc(rows*cols, rows*cols, rows*cols*5);
B = zeros(rows*cols, 3);

% TODO 5 %
% Construct matrix A & B

% add your code here

% create matrix of index
index = zeros(rows, cols);
i = 1;
for c = 1:cols
    for r = 1:rows
        index(r, c) = i;
        i = i + 1;
    end
end

for c=1:cols
    for r=1:rows
        row = index(r, c);

        if mask(r, c) == 0
            % inside the mask
            A(row, row) = 1;
            B(row, 1) = 0;
            B(row, 2) = 0;
            B(row, 3) = 0;
        else
            % outside the mask
            A(row, row) = 4;
            A(row, row + 1) = -1;
            A(row, row - 1) = -1;
            A(row, row + rows) = -1;
            A(row, row - rows) = -1;

            for ch = 1:channels
                foreLaplacian = 4 * foreImg(r, c, ch) - foreImg(r+1, c, ch) - foreImg(r-1, c, ch) - foreImg(r, c+1, ch) - foreImg(r, c-1, ch);
                backLaplacian = 4 * backImg(r, c, ch) - backImg(r+1 , c, ch) - backImg(r-1, c, ch) - backImg(r, c+1, ch) - backImg(r, c-1, ch);
                B(row, ch) = foreLaplacian - backLaplacian;
            end
        end
    end
end

%% solve Ax=B with least square
Rr = A \ B(:, 1);
Rg = A \ B(:, 2);
Rb = A \ B(:, 3);

% TODO 6 %
% extract final result from R

% add your code here
img = zeros(size(backImg));
i = 1;
for c=1:cols
    for r=1:rows
        img(r, c, 1) = backImg(r, c, 1) + Rr(i);
        img(r, c, 2) = backImg(r, c, 2) + Rg(i);
        img(r, c, 3) = backImg(r, c, 3) + Rb(i);
        i = i + 1;
    end
end

toc;

% uncomment these 2 lines after you generate the final result in matrix 'img'
figure, imshow(img);
imwrite(img, outputName);
