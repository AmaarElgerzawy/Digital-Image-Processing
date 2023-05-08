function info = imgetfileinfo(img)
% Get file information for an image handle in MATLAB

% Get the filename of the image from its handle
info.Filename = getfield(imfinfo(img), 'Filename');

% Get the format of the image from its handle
info.Format = getfield(imfinfo(img), 'Format');

% Get the size of the image from its handle
info.Width = getfield(imfinfo(img), 'Width');
info.Height = getfield(imfinfo(img), 'Height');

% Get the bit depth of the image from its handle
info.BitDepth = getfield(imfinfo(img), 'BitDepth');

% Get the color type of the image from its handle
info.ColorType = getfield(imfinfo(img), 'ColorType');
end