function [B,G,R] = extractChannels(image)

% Calculate the height of each part (about 1/3 of total)
ImgH = floor(size(image,1)/3);

% Separate B-G-R channels
B = image(1:ImgH,:);
G = image(ImgH+1:ImgH*2,:);
R = image(ImgH*2+1:ImgH*3,:);

end