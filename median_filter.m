function output_image = median_filter(input_image, filter_size)
    % Apply a median filter to an input image using a square filter of size filter_size

    % Apply the filter to the input image
    output_image = medfilt2(input_image, [filter_size filter_size]);
end