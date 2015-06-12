%% CSCI 3290: Assignment 1 Starter Code

%% Input
% Input glass plate image
imgname = 'image.jpg';
fullimg = imread(imgname);

% Convert to double matrix
fullimg = im2double(fullimg);

%% Extract Image
[B,G,R] = extractChannels(fullimg);

%% Align the images
% Functions that might be useful:"circshift", "sum", and "imresize"

tic;   % The Timer starts. To Evalute algorithms' efficiency.
aG = alignSingle(G,B);
aR = alignSingle(R,B);
toc;   % The Timer stops and displays time elapsed.

%% Output Results

% Create a color image (3D array): "cat" command
% For your own code, "G","R" shoule be replaced to "aG","aR"
colorImg = cat(3,aR,aG,B);

% Auto crop image and then auto adjust contrast
colorImg = autocontrast(crop(colorImg));

% Show the resulting image: "imshow" command
imshow(colorImg);

% Save result image to File
imwrite(colorImg,['result-' imgname]);
