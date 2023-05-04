function output_image = mean_filter(input_image, filter_size)
    % Apply a mean filter to an input image using a square filter of size filter_size

    % Create the filter
    filter = ones(filter_size);

    % Normalize the filter
    filter = filter / sum(filter(:));

    % Apply the filter to the input image
    output_image = imfilter(input_image, filter);
end