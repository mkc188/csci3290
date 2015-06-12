function [outputImg] = texture_transfer(inputImg, tarImg, alpha, szPatch, szOverlap, isdebug)

%% Input and Config
sizein = size(inputImg);
sizeout = size(tarImg);

inputImg = double(inputImg);
tarImg = double(tarImg);
outputImg = zeros(sizeout);

errTop = xcorr2(inputImg.^2, ones([szOverlap szPatch]));
errLeft = xcorr2(inputImg.^2, ones([szPatch szOverlap]));
errSide = xcorr2(inputImg.^2, ones([szPatch-szOverlap szOverlap]));

%% Main Function
for i=1:szPatch-szOverlap:sizeout(1)-szPatch+1,
  for j=1:szPatch-szOverlap:sizeout(2)-szPatch+1,
    %% Synthesis texture given the existing top and left image
    if (i > 1) & (j > 1)
        % TODO#1 Find the existing shared region and target patch
        % Extract shared region and target region
        sharedTop = outputImg(i:i+szOverlap-1,j:j+szPatch-1);
        sharedSide = outputImg(i+szOverlap:i+szPatch-1,j:j+szOverlap-1);

        % TODO#2 Compute the distance between existing shared texture region
        % and all patches in the input texture image
        err = errTop - 2 * xcorr2(inputImg, sharedTop) + sum(sharedTop(:).^2);
        err = err(szOverlap:end-szPatch+1,szPatch:end-szPatch+1);
        err2 = errSide - 2 * xcorr2(inputImg, sharedSide) + sum(sharedSide(:).^2);
        err = err + err2(szPatch:end-szPatch+szOverlap+1, szOverlap:end-szPatch+1);

        % % TODO#3 Compute the distance between the target patch and all patches
        % % in the input texture image
        % errTarget = ;

        % % Total error
        % err = err + alpha * errTarget;

        % Find the texture with a reasonable small error
        [ibest, jbest] = find(err <= 1.1*1.01*min(err(:)));
        c = ceil(rand * length(ibest));
        pos = [ibest(c) jbest(c)];

    elseif i > 1
        % TODO#5 Find the existing shared region and target patch
        % Extract shared region and target region
        shared = outputImg(i:i+szOverlap-1,j:j+szPatch-1);

        % TODO#6 Compute the distance between existing shared texture region
        % and all patches in the input texture image
        err = errTop - 2 * xcorr2(inputImg, shared) + sum(shared(:).^2);
        err = err(szOverlap:end-szPatch+1,szPatch:end-szPatch+1);

        % % TODO#7 Compute the distance between the target patch and all patches
        % % in the input texture image
        % errTarget = ;

        % % Total error
        % err = err + alpha * errTarget;

        % Find the texture with a reasonable small error
        [ibest, jbest] = find(err <= 1.1*1.01*min(err(:)));
        c = ceil(rand * length(ibest));
        pos = [ibest(c) jbest(c)];
    elseif j > 1
        % TODO#9 Find the existing shared region and target patch
        % Extract shared region and target region
        shared = outputImg(i:i+szPatch-1,j:j+szOverlap-1);

        % TODO#10 Compute the distance between existing shared texture region
        % and all patches in the input texture image
        err = errLeft - 2 * xcorr2(inputImg, shared) + sum(shared(:).^2);
        err = err(szPatch:end-szPatch+1,szOverlap:end-szPatch+1);

        % % TODO#11 Compute the distance between the target patch and all patches
        % % in the input texture image
        % errTarget = ;

        % % Total error
        % err = err + alpha * errTarget;

        % Find the texture with a reasonable small error
        [ibest, jbest] = find(err <= 1.1*1.01*min(err(:)));
        c = ceil(rand * length(ibest));
        pos = [ibest(c) jbest(c)];
    else
        pos = ceil(rand([1 2]) .* (sizein-szPatch+1));
    end

    outputImg(i:i+szPatch-1,j:j+szPatch-1) = inputImg(pos(1):pos(1)+szPatch-1,pos(2):pos(2)+szPatch-1);

    %% Show debug result
    if isdebug~=0
        figure(3), imshow(outputImg, []);
    end
  end
end
