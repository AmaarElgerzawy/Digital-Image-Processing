function output_image = maximum_filter(input_image, filter_size)
    % Apply a maximum filter to an input image using a square filter of size filter_size

    % Create the filter
    filter = ones(filter_size);

    % Normalize the filter
    filter = filter / sum(filter(:));

    % Apply the filter to the input image
    output_image = ordfilt2(input_image, filter_size^2, filter);
end