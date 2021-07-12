function varargout = GUI_SOM(varargin)
% GUI_SOM MATLAB code for GUI_SOM.fig
%      GUI_SOM, by itself, creates a new GUI_SOM or raises the existing
%      singleton*.
%
%      H = GUI_SOM returns the handle to a new GUI_SOM or the handle to
%      the existing singleton*.
%
%      GUI_SOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SOM.M with the given input arguments.
%
%      GUI_SOM('Property','Value',...) creates a new GUI_SOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_SOM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_SOM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_SOM

% Last Modified by GUIDE v2.5 06-Nov-2020 21:24:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_SOM_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_SOM_OutputFcn, ...
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


% --- Executes just before GUI_SOM is made visible.
function GUI_SOM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_SOM (see VARARGIN)

% Choose default command line output for GUI_SOM
handles.output = hObject;

axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_SOM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_SOM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uigetfile({'*.*'});
if isequal(filename,0)
return;
end
Img = imread(fullfile(pathname, filename));
axes(handles.axes1)
imshow(Img)
handles.Img = Img;
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    load w.mat;
    load neuron_train;

    temp_test = getimage(handles.axes1);
    temp_test = rgb2gray(temp_test);
    temp_test = imresize(temp_test,[20 20]);
    temp_test = reshape(temp_test,400,1);
    temp_test = im2double(temp_test);
    
    input = temp_test; % input vektor 400x1
%     test_label = char(lah(i)); % mengambil test label dari group
    
    min_dist = inf;
    winner_r = -1; winner_c = -1;
    for r = 1 : size(w,1) % 1 : 20
        for c = 1 : size(w,2) % 1 : 20
            dist = norm(input - shiftdim(w(r,c,:)),2); % input - shiftdim dari bobot r c 1:400 lalu di norm
            if (dist < min_dist)
                min_dist = dist; % mencari dist terkecil untuk menjadi min_dist
                winner_r = r; winner_c = c;
            end
        end
    end % END winner neuron found.
%     output_label = char(neuron_labels(winner_r,winner_c)); % mengambil cluster dari neuron_label train(r = baris c = kolom) 
    % compare output label with test label.
%     fprintf('output:%s ',output_label); % keluaran output_label
%     fprintf('testlabel:%s ',test_label);
    if min_dist <= 2.95
        output_label = char(neuron_labels(winner_r,winner_c)); % mengambil cluster dari neuron_label train(r = baris c = kolom) 
    if output_label == ['1']
        kelas = 'ASEMAN';
        citra = imread('aseman.jpg');
        handles.citra = citra;
    elseif output_label == ['2']
        kelas = 'BLEDAK';
        citra = imread('bledak.jpg');
        handles.citra = citra;
    elseif output_label == ['3']
        kelas = 'KRECAK';
        citra = imread('krecak.jpg');
        handles.citra = citra;
    elseif output_label == ['4']
        kelas = 'LATOHAN';
        citra = imread('latohan.jpg');
        handles.citra = citra;
    elseif output_label == ['5']
        kelas = 'SEKAR JAGAD';
        citra = imread('sekar_j.jpg');
        handles.citra = citra;
    elseif output_label == ['6']
        kelas = 'TUMPAL';
        citra = imread('tumpal.jpg');
        handles.citra = citra;        
    elseif output_label == ['7']
        kelas = 'GUNUNG RINGGIT';
        citra = imread('gunung_g.jpg');
        handles.citra = citra;
    end
    else
        kelas = 'Tidak Dikenal';
        citra = imread('tidak_dikenal.jpg');
        handles.citra = citra;
        
    end
    axes(handles.axes2);
    imshow(citra)
    set(handles.edit1,'String',kelas);
catch
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])

set(handles.edit1,'String','')


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
