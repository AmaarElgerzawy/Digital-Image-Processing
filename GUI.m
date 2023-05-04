function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 04-May-2023 16:20:44

% Begin initialization code - DO NOT EDIT
% Get handles to all the axes in the GUIDE interface
axes_handles = findobj('Type', 'axes');

% Loop through each axis and disable the context menu
for i = 1:length(axes_handles)
    set(axes_handles(i), 'UIContextMenu', []);
end
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

handles.image_path = '';
handles.image_1 = '';
handles.image_2 = '';
handles.noise = 0;
handles.image_hist_1 = [];
handles.image_hist_2 = [];
handles.lastVal = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in bw_convert.
function bw_convert_Callback(hObject, eventdata, handles)
% hObject    handle to bw_convert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ndims(handles.image_2) == 3
    handles.image_2 = imbinarize(rgb2gray(handles.image_2));
else
    handles.image_2 = imbinarize(handles.image_2);
end


set(handles.axes2,'Units','pixels');
axes(handles.axes2);
imshow(handles.image_2);
set(handles.axes2,'Units','normalized');

[counts,binLocations] = imhist(handles.image_2);
stem(handles.axes4,binLocations,counts);

guidata(hObject, handles);

% --- Executes on button press in rg_convert.
function rg_convert_Callback(hObject, eventdata, handles)
% hObject    handle to rg_convert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Convert the image to grayscale if it isn't already
if ndims(handles.image_2) == 3
    handles.image_2 = rgb2gray(handles.image_2);
end

set(handles.axes2,'Units','pixels');
axes(handles.axes2);
imshow(handles.image_2);
set(handles.axes2,'Units','normalized');

[counts,binLocations] = imhist(handles.image_2);
stem(handles.axes4,binLocations,counts);

guidata(hObject, handles);

% --- Executes on button press in upload_start.
function upload_start_Callback(hObject, eventdata, handles)
% hObject    handle to upload_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.image_path = imgetfile;
%     % Convert the image to grayscale if it isn't already
handles.image_1 = imread(handles.image_path);
handles.image_2 = handles.image_1;

set(handles.axes1,'Units','pixels');
axes(handles.axes1);
imshow(handles.image_1);
set(handles.axes1,'Units','normalized');

set(handles.axes2,'Units','pixels');
axes(handles.axes2);
imshow(handles.image_2);
set(handles.axes2,'Units','normalized');

[counts,binLocations] = imhist(handles.image_1);
stem(handles.axes3,binLocations,counts);

[counts,binLocations] = imhist(handles.image_2);
stem(handles.axes4,binLocations,counts);

guidata(hObject, handles);


% --- Executes on button press in resetmain_start.
function resetmain_start_Callback(hObject, eventdata, handles)
% hObject    handle to resetmain_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.image_1 = imread(handles.image_path);

set(handles.axes1,'Units','pixels');
axes(handles.axes1);
imshow(handles.image_1);
set(handles.axes1,'Units','normalized');

[counts,binLocations] = imhist(handles.image_1);
stem(handles.axes3,binLocations,counts);

guidata(hObject, handles);


% --- Executes on button press in resetworking_start.
function resetworking_start_Callback(hObject, eventdata, handles)
% hObject    handle to resetworking_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.image_2 = handles.image_1;

set(handles.axes2,'Units','pixels');
axes(handles.axes2);
imshow(handles.image_2);
set(handles.axes2,'Units','normalized');

[counts,binLocations] = imhist(handles.image_2);
stem(handles.axes4,binLocations,counts);

guidata(hObject, handles);


% --- Executes on button press in histrogram_function.
function histrogram_function_Callback(hObject, eventdata, handles)
% hObject    handle to histrogram_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Calculate the histogram of the grayscale image
histogram = imhist(handles.image_2);
% Calculate the cumulative distribution function (CDF) of the histogram
cdf = cumsum(histogram) / numel(handles.image_2);
% Calculate the equalized intensity values using the CDF
equalized_values = uint8(255 * cdf(handles.image_2 + 1));
% Create a new image with the equalized intensity values
handles.image_2 = reshape(equalized_values, size(handles.image_2));

set(handles.axes2,'Units','pixels');
axes(handles.axes2);
imshow(handles.image_2);
set(handles.axes2,'Units','normalized');

[counts,binLocations] = imhist(handles.image_2);
stem(handles.axes4,binLocations,counts);

guidata(hObject, handles);

% --- Executes on button press in contrast_function.
function contrast_function_Callback(hObject, eventdata, handles)
% hObject    handle to contrast_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Apply contrast stretching to the image
stretched_Image = imadjust(handles.image_2, stretchlim(handles.image_2, [0.05, 0.95]),[]);

% Convert the image back to uint8 format
handles.image_2 = uint8(stretched_Image);

set(handles.axes2,'Units','pixels');
axes(handles.axes2);
imshow(handles.image_2);
set(handles.axes2,'Units','normalized');

[counts,binLocations] = imhist(handles.image_2);
stem(handles.axes4,binLocations,counts);

guidata(hObject, handles);

% --- Executes on button press in smoothing_function.
function smoothing_function_Callback(hObject, eventdata, handles)
% hObject    handle to smoothing_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.image_2 = imgaussfilt(handles.image_2,2);
    
    set(handles.axes2,'Units','pixels');
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');

    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);

    guidata(hObject, handles);

% --- Executes on button press in sharpening_function.
function sharpening_function_Callback(hObject, eventdata, handles)
% hObject    handle to sharpening_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.image_2 = imsharpen(handles.image_2,"Radius",1);

set(handles.axes2,'Units','pixels');
axes(handles.axes2);
imshow(handles.image_2);
set(handles.axes2,'Units','normalized');

[counts,binLocations] = imhist(handles.image_2);
stem(handles.axes4,binLocations,counts);

guidata(hObject, handles);


% --- Executes on button press in set_start.
function set_start_Callback(hObject, eventdata, handles)
% hObject    handle to set_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.image_1 = handles.image_2;

set(handles.axes1,'Units','pixels');
axes(handles.axes1);
imshow(handles.image_1);
set(handles.axes1,'Units','normalized');

[counts,binLocations] = imhist(handles.image_1);
stem(handles.axes3,binLocations,counts);

guidata(hObject, handles);


% --- Executes on slider movement.
function brigthness_Callback(hObject, eventdata, handles)
% hObject    handle to brigthness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    val=get(hObject, 'value')*255;
    [m, n]=size(handles.image_2);
    up = 0;down =0;
    if val > handles.lastVal
        up = 1;
        down = 0;
    elseif val < handles.lastVal
        down = 1;
        up = 0;
    end
    
    if up == 1 && val > 0
        for i=1:m
           for j=1:n
             if handles.image_2(i,j)+val <= 255    %to make sure not to increase than 255
               handles.image_2(i,j)=handles.image_2(i,j)+val;
             else
                 handles.image_2(i,j)=255;
             end
           end
        end
    end
    if down == 1 && val < 0
        for i=1:m
           for j=1:n
             if handles.image_2(i,j)-val >= 0    %to make sure not to increase than 255
               handles.image_2(i,j)=handles.image_2(i,j)+val;
             else
                 handles.image_2(i,j)=0;
             end
           end
        end
    end
    
    if down == 1 && val > 0
        for i=1:m
           for j=1:n
             if handles.image_2(i,j)-val >= 0    %to make sure not to increase than 255
               handles.image_2(i,j)=handles.image_2(i,j)-val;
             else
                 handles.image_2(i,j)=0;
             end
           end
        end
    end
    
    if up == 1 && val < 0
        for i=1:m
           for j=1:n
             if handles.image_2(i,j)-val >= 0    %to make sure not to increase than 255
               handles.image_2(i,j)=handles.image_2(i,j)-val;
             else
                 handles.image_2(i,j)=255;
             end
           end
        end
    end
    set(handles.axes2,'Units','pixels');
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');

    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);
    
    handles.lastVal = val;
    
    guidata(hObject, handles);
    
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function brigthness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brigthness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in min_basic.
function min_basic_Callback(hObject, eventdata, handles)
% hObject    handle to min_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.image_2 = minimum_filter(handles.image_2, 3);
    set(handles.axes2,'Units','pixels');
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');

    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);
    
    guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of min_basic


% --- Executes on button press in max_basic.
function max_basic_Callback(hObject, eventdata, handles)
% hObject    handle to max_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.image_2 =  maximum_filter(handles.image_2, 3);
    set(handles.axes2,'Units','pixels');
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');

    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);
    
    guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of max_basic


% --- Executes on button press in miden_basic.
function miden_basic_Callback(hObject, eventdata, handles)
% hObject    handle to miden_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.image_2 =   median_filter(handles.image_2, 3);
    set(handles.axes2,'Units','pixels');
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');

    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);
    
    guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of miden_basic


% --- Executes on button press in mean_basic.
function mean_basic_Callback(hObject, eventdata, handles)
% hObject    handle to mean_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.image_2 =   mean_filter(handles.image_2, 3);
    set(handles.axes2,'Units','pixels');
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');

    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);
    
    guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of mean_basic


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

    hmask=fspecial('sobel');
    vmask=hmask';
    
    val = get(hObject,'Value');
    if val == 1
        handles.image_2 = imfilter(handles.image_2,hmask,'replicate');
    elseif val == 2
        handles.image_2 = imfilter(handles.image_2,vmask,'replicate');
    elseif val == 3
        b_h=imfilter(handles.image_2,hmask,'replicate');
        b_v=imfilter(handles.image_2,vmask,'replicate');
        handles.image_2=b_h+b_v;
    end
    set(handles.axes2,'Units','pixels');
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');

    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);

    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function removeNoise(hObject,handles)
if handles.noise == 1
    %apply salt&pepper noise remove
    
    % Convert the image to grayscale if it isn't already
    if ndims(handles.image_2) == 3
        gray_img = rgb2gray(handles.image_2);
    else
        gray_img = handles.image_2;
    end
    
    % Apply a median filter to the image
    filter_size = 3; % Adjust this value to change the size of the filter
    handles.image_2 = medfilt2(gray_img, [filter_size filter_size]);
    
elseif handles.noise == 2 || handles.noise == 3
    %apply gaussian noise remove
    % Convert the image to grayscale if it isn't already
    if ndims(handles.image_2) == 3
        gray_img = rgb2gray(handles.image_2);
    else
        gray_img = handles.image_2;
    end
    
    % Apply a Gaussian filter to the image
    gaussianFilter = fspecial('gaussian', [3 3], 2);
    filteredImage = imfilter(gray_img, gaussianFilter);
    
    % Apply a median filter to the image
    filter_size = 3; % Adjust this value to change the size of the filter
    handles.image_2 = medfilt2(filteredImage, [filter_size filter_size]);
    
elseif handles.noise == 4
    %apply periodic noise remove
    
    % Convert the image to grayscale if it isn't already
    if ndims(handles.image_2) == 3
        gray_img = rgb2gray(handles.image_2);
    else
        gray_img = handles.image_2;
    end
    % Compute the Fourier transform of the image
    ftImage = fft2(double(gray_img));
    
    % Create a notch filter to remove the periodic noise
    D0 = 50; % distance from the origin to the notch filter
    w = 5; % width of the notch filter
    h = size(gray_img, 1);
    w1 = round(h/2) - w/2; % location of the first notch filter
    w2 = round(h/2) + w/2; % location of the second notch filter
    notchFilter = ones(h);
    notchFilter(w1:w2, round(h/2) - D0:round(h/2) + D0) = 0;
    notchFilter(round(h/2) - D0:round(h/2) + D0, w1:w2) = 0;
    
    % Apply the notch filter to the Fourier transform of the image
    filteredFtImage = ftImage .* notchFilter;
    
    % Compute the inverse Fourier transform to get the filtered image
    handles.image_2 = real(ifft2(filteredFtImage));
end
imshow(handles.image_2);
set(handles.axes2,'Units','normalized');
[counts,binLocations] = imhist(handles.image_2);
stem(handles.axes4,binLocations,counts);
handles.noise = 0;
guidata(hObject, handles);


% --- Executes on button press in resize_btn.
function resize_btn_Callback(hObject, eventdata, handles)
% hObject    handle to resize_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in sp_noise.
function sp_noise_Callback(hObject, eventdata, handles)
% hObject    handle to sp_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sp_noise
if ((get(hObject,'Value') == get(hObject,'Max')) && handles.noise ~= 1)
    removeNoise(hObject,handles);
    % Add salt and pepper noise
    noise_density = 0.05; % Adjust this value to change the density of noise
    noisy_img = imnoise(handles.image_2, 'salt & pepper', noise_density);
    
    
    
    set(handles.axes2,'Units','pixels');
    handles.image_2 = noisy_img;
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');
    
    
    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);
    
    handles.noise = 1;
    guidata(hObject, handles);
end


% --- Executes on button press in gaussian_noise.
function gaussian_noise_Callback(hObject, eventdata, handles)
% hObject    handle to gaussian_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gaussian_noise
%
if (get(hObject,'Value') == get(hObject,'Max')) && handles.noise ~= 2
    
    removeNoise(hObject,handles);
    
    % Add Gaussian noise
    noise_mean = 0; % Mean of the noise
    noise_var = 0.01; % Variance of the noise
    noisy_img = imnoise(handles.image_2, 'gaussian', noise_mean, noise_var);
    
    
    set(handles.axes2,'Units','pixels');
    handles.image_2 = noisy_img;
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');
    
    
    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);
    
    handles.noise = 2;
    guidata(hObject, handles);
end

% --- Executes on button press in speckle_noise.
function speckle_noise_Callback(hObject, eventdata, handles)
% hObject    handle to speckle_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of speckle_noise
if (get(hObject,'Value') == get(hObject,'Max'))&& handles.noise ~= 3
    removeNoise(hObject,handles);
    % Add speckle noise
    noise_density = 0.05; % Adjust this value to change the density of noise
    noisy_img = imnoise(handles.image_2, 'speckle', noise_density);
    
    set(handles.axes2,'Units','pixels');
    handles.image_2 = noisy_img;
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');
    
    
    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);
    
    handles.noise = 3;
    guidata(hObject, handles);
end

% --- Executes on button press in periodic_noise.
function periodic_noise_Callback(hObject, eventdata, handles)
% hObject    handle to periodic_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of periodic_noise
if (get(hObject,'Value') == get(hObject,'Max')) && handles.noise ~= 4
    
    
    
    %removeNoise(hObject,handles);
    % Convert the image to grayscale if it isn't already
    if ndims(handles.image_2) == 3
        gray_img = rgb2gray(handles.image_2);
    else
        gray_img = handles.image_2;
    end
    
    % Define the size of the noise pattern
    pattern_size = 20; % Adjust this value to change the size of the pattern
    
    % Create a grid of x and y coordinates
    [X, Y] = meshgrid(1:size(gray_img, 2), 1:size(gray_img, 1));
    
    % Generate a sin wave with a random frequency and amplitude
    freq = randi([1 10], 1);
    amp = randi([10 50], 1);
    noise = amp*sin(2*pi*freq*(X/pattern_size) + rand);
    
    % Add the noise to the grayscale image
    noisy_img = im2double(gray_img) + noise;
    
    % Normalize the noisy image to the range [0, 1]
    noisy_img = (noisy_img - min(noisy_img(:))) / (max(noisy_img(:)) - min(noisy_img(:)));
    
    % Convert the noisy image back to uint8
    noisy_img = im2uint8(noisy_img);
    
    % set the applied noise image to working image
    set(handles.axes2,'Units','pixels');
    handles.image_2 = noisy_img;
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');
    
    
    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);
    
    handles.noise = 4;
    guidata(hObject, handles);
end


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
removeNoise(hObject,handles)



function imagex_x_Callback(hObject, eventdata, handles)
% hObject    handle to imagex_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imagex_x as text
%        str2double(get(hObject,'String')) returns contents of imagex_x as a double


% --- Executes during object creation, after setting all properties.
function imagex_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagex_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function image_y_Callback(hObject, eventdata, handles)
% hObject    handle to image_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of image_y as text
%        str2double(get(hObject,'String')) returns contents of image_y as a double


% --- Executes during object creation, after setting all properties.
function image_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in geometric_spatial.
function geometric_spatial_Callback(hObject, eventdata, handles)
% hObject    handle to geometric_spatial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Kr = 3;
    Kc = 3;
    g=im2double(handles.image_2);
    handles.image_2 = exp(imfilter(log(g), ones(Kr, Kc), 'replicate')).^(1/(Kr*Kc));
    
    set(handles.axes2,'Units','pixels');
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');

    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);

    guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of geometric_spatial

% --- Executes on button press in harmonic_spatial.
function harmonic_spatial_Callback(hObject, eventdata, handles)
% hObject    handle to harmonic_spatial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Kr = 3;
    Kc = 3;
    handles.image_2 = im2double(handles.image_2);
    handles.image_2 = (Kr*Kc)./imfilter(1./(handles.image_2+eps), ones(Kr, Kc), 'replicate');

    set(handles.axes2,'Units','pixels');
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');

    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);

    guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of harmonic_spatial


% --- Executes on button press in Contraharmonic_spatial.
function Contraharmonic_spatial_Callback(hObject, eventdata, handles)
% hObject    handle to Contraharmonic_spatial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    Ord = 1;
    Kr = 3;
    Kc = 3;
    Img=im2double(handles.image_2);
    handles.image_2=imfilter(Img.^(Ord+1), ones(Kr, Kc), 'replicate')./imfilter(Img.^(Ord), ones(Kr,Kc), 'replicate');

    set(handles.axes2,'Units','pixels');
    axes(handles.axes2);
    imshow(handles.image_2);
    set(handles.axes2,'Units','normalized');

    [counts,binLocations] = imhist(handles.image_2);
    stem(handles.axes4,binLocations,counts);

    guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of Contraharmonic_spatial
