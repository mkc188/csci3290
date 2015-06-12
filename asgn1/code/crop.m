% CSCI 3290 Assignment 1

function output = crop(input)

output = input;

% Resize large image
factor = 1;
[h, w, d] = size(input);
if min(h, w) >= 2000
    input = imresize(input, 0.25);
    [h, w, d] = size(input);
    factor = 4;
end

left = 1;
top = 1;
right = w;
bottom = h;

crop_ratio = 0.1;   % Only detect borders
threshold = 0.3;    % Best threshold for images with size about 500x500

% Convert image for detecting edges
input = edge(rgb2gray(input), 'canny');

% Left border
for left_col = 1:floor(w*crop_ratio)
    if count(input(:,left_col,:)) > threshold
        left = left_col;
    end
end

% Right border
for right_col = w:-1:w-floor(w*crop_ratio)
    if count(input(:,right_col,:)) > threshold
        right = right_col;
    end
end

% Top border
for top_row = 1:floor(h*crop_ratio)
    if count(input(top_row,:,:)) > threshold
        top = top_row;
    end
end

% Right border
for bottom_row = h:-1:h-floor(h*crop_ratio)
    if count(input(bottom_row,:,:)) > threshold
        bottom = bottom_row;
    end
end

output = imcrop(output, [left, top, right-left, bottom-top]*factor);

end

% Count the ratio of white pixels
function ratio = count(line)

pixels = (line == 1);
ratio = sum(pixels(:)) / length(line);

end
