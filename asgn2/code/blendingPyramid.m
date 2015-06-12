
%% config & input

Topic = 'apple';

backImageName = [Topic '.png'];
foreImageName = [Topic '2.png'];
maskName = [Topic '_mask.png'];
outputName = [Topic '_out_pyramid.png'];

backImg = im2double(imread(backImageName));
foreImg = im2double(imread(foreImageName));
mask = im2double(imread(maskName));

[rows,cols,channels] = size(backImg);

tic;

if size(mask,3) == 1
    mask = repmat(mask, [1,1,channels]);
end


%% build pyramid

pyramidN = ceil(log2(min(rows,cols) / 16));

[imageFore, gaussianFore, laplaceFore] = createPyramid(foreImg, pyramidN);
[imageBack, gaussianBack, laplaceBack] = createPyramid(backImg, pyramidN);
[imageMask, gaussianMask, laplaceMask] = createPyramid(mask, pyramidN);

%% Combine laplacian pyramid

laplaceMerge = cell(pyramidN);

% TODO 2 %
% Combine the laplacian pyramids of background and foreground

% add your code here
for i = 1:pyramidN
    laplaceMerge{i} = gaussianMask{i}.*laplaceFore{i} + (1-gaussianMask{i}).*laplaceBack{i};
end

%% Combine the smallest scale image

% TODO 3 %
% Combine the smallest scale images of background and foreground

% add your code here
img = gaussianMask{pyramidN}.*imageFore{pyramidN} + (1-gaussianMask{pyramidN}).*imageBack{pyramidN};

%% reconstruct & output

% TODO 4 %
% reconstruct the blending image by adding the gradient (in different scale) back to
% the smallest scale image while upsampling

% add your code here
for i = (pyramidN-1):-1:1
    [h, w, d] = size(laplaceMerge{i});
    img = imresize(img, [h, w]);
    img = img + laplaceMerge{i};
end

toc;

% uncomment these 2 lines after you generate the final result in matrix 'img'
figure, imshow(img);
imwrite(img, outputName);
