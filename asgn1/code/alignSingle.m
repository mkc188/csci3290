% CSCI 3290 Assignment 1

function aimg = alignSingle(img1,img2)

[h,w] = size(img1);
bestVector = zeros(2,1);
retimg = img1;
% Crop borders of the images
img1 = imcrop(img1, [0.1*h, 0.1*w, 0.8*h, 0.8*w]);
img2 = imcrop(img2, [0.1*h, 0.1*w, 0.8*h, 0.8*w]);
% Convert to imgradient
img1 = imgradient(img1);
img2 = imgradient(img2);

% TODO #1 %
% Add your code here: calculate bestVector exhaustively

% Calculate search range automatically
range = floor(0.05 * min(h, w));

% Search bestVector by sum of squared differences
minimum = inf;
for i = -range:range
    for j = -range:range
        tmp = circshift(img1, [i;j]);
        ssd = sum((img2(:)-tmp(:)).^2);
        if ssd < minimum
            minimum = ssd;
            bestVector = [i;j];
        end
    end
end

% Search bestVector by normalized cross correlation
% maximum = -inf;
% for i = -range:range
%     for j = -range:range
%         tmp = circshift(img1, [i;j]);
%         ncc = dot(img2(:),tmp(:))/norm(img2(:))/norm(tmp(:));
%         if ncc > maximum
%             maximum = ncc;
%             bestVector = [i;j];
%         end
%     end
% end

aimg = circshift(retimg,bestVector);

end
