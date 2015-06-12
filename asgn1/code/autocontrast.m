% CSCI 3290 Assignment 1

function output = autocontrast(input)

[h, w, d] = size(input);

% Define lower limit and upper limit
low = 0.01;
up = 0.99;

for i = 1:d
    % Sort image data and find the new range
    arr = sort(reshape(input(:, :, i), h*w, 1));
    min = arr(ceil(low*h*w));
    max = arr(ceil(up*h*w));
    % Stretch image data
    output(:, :, i) = (input(:, :, i)-min) / (max-min);
end

end
