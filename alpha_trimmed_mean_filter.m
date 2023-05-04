function filtered_img = alpha_trimmed_mean_filter(img, window_size, alpha)
    % Get the dimensions of the image
    [rows, cols] = size(img);

    % Set the padding size so that the window can be centered at the image edges
    padding_size = floor(window_size/2);

    % Pad the image with zeros
    padded_img = padarray(img, [padding_size padding_size], 'symmetric');

    % Initialize the filtered image
    filtered_img = zeros(rows, cols);

    % Iterate over each pixel in the image
    for i = 1:rows
        for j = 1:cols
            % Get the window around the current pixel
            window = padded_img(i:i+window_size-1, j:j+window_size-1);

            % Remove the alpha fraction of the smallest and largest values in the window
            trimmed_window = trimmean(window(:), alpha*100);

            % Set the filtered pixel value to the mean of the trimmed window
            filtered_img(i,j) = trimmed_window;
        end
    end

    % Convert the filtered image back to uint8 format
    filtered_img = im2uint8(filtered_img);
end