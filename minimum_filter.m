function output_image = minimum_filter(input_image, filter_size)
    % Apply a minimum filter to an input image using a square filter of size filter_size

    % Create the filter
    filter = ones(filter_size);

    % Normalize the filter
    filter = filter / sum(filter(:));

    % Apply the filter to the input image
    output_image = ordfilt2(input_image, 1, filter);
end