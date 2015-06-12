% CSCI 3290 Assignment 1

function aimg = alignMulti(img1,img2)

[h,w] = size(img1);
retimg = img1;
% Crop borders of the images
img1 = imcrop(img1, [0.1*h, 0.1*w, 0.8*h, 0.8*w]);
img2 = imcrop(img2, [0.1*h, 0.1*w, 0.8*h, 0.8*w]);
% Convert to imgradient
img1 = imgradient(img1);
img2 = imgradient(img2);

% Initial the image pyramid
pyramidlevel = ceil(log2(h/100))+1;
pyramid1 = cell(pyramidlevel);
pyramid2 = cell(pyramidlevel);
pyramid1{1} = img1;
pyramid2{1} = img2;

% TODO #2 %
% add your code here: build 2 pyramid for 2 images
H = fspecial('gaussian');
for level = 2:1:pyramidlevel
    tmp1 = imfilter(pyramid1{level-1}, H);
    tmp2 = imfilter(pyramid2{level-1}, H);
    pyramid1{level} = tmp1(1:2:end, 1:2:end);
    pyramid2{level} = tmp2(1:2:end, 1:2:end);
end

% Calculate bestVector in coarse-to-fine scheme
bestVector = zeros(2,1);
range = level+1;
for level = pyramidlevel:-1:1
    % TODO #3 %
    % add your code here: find the bestVector
    % Search bestVector by sum of squared differences
    minimum = inf;
    bestVector = bestVector*2;
    for i = bestVector(1)-range:bestVector(1)+range
        for j = bestVector(2)-range:bestVector(2)+range
            tmp = circshift(pyramid1{level}, [i;j]);
            ssd = sum((pyramid2{level}(:)-tmp(:)).^2);
            if ssd < minimum
                minimum = ssd;
                bestVector = [i;j];
            end
        end
    end

    % Search bestVector by normalized cross correlation
    % maximum = -inf;
    % bestVector = bestVector * 2;
    % for i = bestVector(1)-range:bestVector(1)+range
    %     for j = bestVector(2)-range:bestVector(2)+range
    %         tmp = circshift(pyramid1{level}, [i;j]);
    %         ncc = dot(pyramid2{level}(:),tmp(:))/norm(pyramid2{level}(:))/norm(tmp(:));
    %         if ncc > maximum
    %             maximum = ncc;
    %             bestVector = [i;j];
    %         end
    %     end
    % end

    range = range-1;
end

aimg = circshift(retimg,bestVector);

end
