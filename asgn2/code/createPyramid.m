function [imagePyramid, gaussianPyramid, laplacePyramid] = createPyramid(img, pyramidN)

    imagePyramid = cell(pyramidN);
    gaussianPyramid = cell(pyramidN);
    laplacePyramid = cell(pyramidN);

    %% generate pyramid

    % TODO 1 %
    % Generate 3 pyramid: image, gaussian, laplacian

    % add your code here
    [h, w, d] = size(img);
    imagePyramid{1} = imresize(img, [ceil((h-1)/2)*2, ceil((w-1)/2)*2]);
    for i = 2:(pyramidN+1)
        [h, w, d] = size(imagePyramid{i-1});
        imagePyramid{i} = imresize(img, [ceil((h/2-1)/2)*2, ceil((w/2-1)/2)*2]);
        gaussianPyramid{i-1} = imresize(imagePyramid{i}, [h, w]);
        laplacePyramid{i-1} = imagePyramid{i-1} - gaussianPyramid{i-1};
    end
end
