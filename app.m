function varargout = app(varargin)
% APP MATLAB code for app.fig
%      APP, by itself, creates a new APP or raises the existing
%      singleton*.
%
%      H = APP returns the handle to a new APP or the handle to
%      the existing singleton*.
%
%      APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APP.M with the given input arguments.
%
%      APP('Property','Value',...) creates a new APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before app_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to app_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help app

% Last Modified by GUIDE v2.5 03-Dec-2017 17:03:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @app_OpeningFcn, ...
                   'gui_OutputFcn',  @app_OutputFcn, ...
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


% --- Executes just before app is made visible.
function app_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to app (see VARARGIN)

% Choose default command line output for app
handles.output = hObject;
handles.prog = 0; %ustalam, ze domyslnie ma progowac metod¹ Otsu 
handles.progWartosc = 0; 
handles.sliderVal = 0;
set(handles.slider1, 'SliderStep', [1/(256-1), 1/(256-1)]);
handles.deg = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes app wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = app_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%wgrywam plik, który chce przetwarzaæ
function pushbutton1_Callback(hObject, eventdata, handles)

[filename pathname] = uigetfile({'*.jpg'}, 'File Sector');
if isequal(filename, 0) || isequal(pathname,0)
        msgbox('U¿ytkownik nacisna³ anuluj');
else
    fullpathname = strcat(pathname, filename);
    handles.data = imread(fullpathname);
    axes(handles.axes1);
    imshow(handles.data,[]);
end
guidata(hObject, handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imwrite(handles.img_bin, 'rozpoznany_obiekt.jpg');

%wyswietlam obraz w odcieniach szaroœci 0-255
function pushbutton3_Callback(hObject, eventdata, handles)

handles.data = rgb2gray(handles.data);
axes(handles.axes1);
imshow(handles.data,[]);
guidata(hObject, handles);

%wyswietl poziomy i pionowy histogram
function pushbutton4_Callback(hObject, eventdata, handles)
[x,y] = size(handles.img_bin) 
h_pionowy = zeros(1,x);
h_pionowy = zeros(1,y);
%histogram poziomy 
for i = 1:x 
    h_poziomy(i) = sum(handles.img_bin(i,:));
end

%histogram pionowy 
for i = 1:y
    h_pionowy(i) = sum(handles.img_bin(:,i));
end

h_pionowy = h_pionowy/max(h_pionowy);
h_poziomy = h_poziomy/max(h_poziomy);
h_suma = [h_pionowy(find(h_pionowy>0)) h_poziomy(find(h_poziomy>0))]; 

figure(1);
plot(h_pionowy);
title('Histogram pionowy');
grid on;
figure(2);
plot(h_poziomy);
title('Histogram poziomy');
grid on; 
view([90 -90]);
figure(3)
plot(h_suma);
title('Histogram sumy');
grid on; 

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

handles.progWartosc = (get(hObject,'Value'));
set(handles.text3,'String',num2str(handles.progWartosc));
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%binaryzacja obrazu metod¹ Otsu 
function pushbutton5_Callback(hObject, eventdata, handles)
handles.prog = get(handles.radiobutton1,'Value');
handles.prog
if handles.prog == 0 
    level = graythresh(handles.data);
    handles.progWartosc = level; 
    handles.img_bin = imbinarize(handles.data, level);
    set(handles.text3,'String',num2str(handles.progWartosc));
    axes(handles.axes2);
    imshow(handles.img_bin,[]);
elseif handles.prog == 1
    
    handles.img_bin = imbinarize(handles.data, handles.progWartosc);
    set(handles.text3,'String',num2str(handles.progWartosc));
    axes(handles.axes2);
    imshow(handles.img_bin,[]);
end

guidata(hObject, handles);


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.prog == 0
    handles.prog = 1;
else
    handles.prog = 0;
end
guidata(hObject, handles);

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


%usuwam artefakty z obrazu po binaryzacji 
function pushbutton6_Callback(hObject, eventdata, handles)

cc = bwconncomp(handles.img_bin, 4);

graindata = regionprops(cc, 'basic');

areaarray = [graindata.Area];
maxarea = max(areaarray);
id = find(areaarray == maxarea);

handles.img_bin = false(size(handles.img_bin));
handles.img_bin(cc.PixelIdxList{id}) = true;
axes(handles.axes2);
imshow(handles.img_bin,[]);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function edit1_Callback(hObject, eventdata, handles)
handles.deg = ceil(str2double(get(hObject, 'String')))
if handles.deg < 360 || handles.deg > 0
    guidata(hObject, handles);
else
    msgbox('Podaj wartoœæ od 0 do 360 stopni');
end


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



%obrót w lewo
function pushbutton9_Callback(hObject, eventdata, handles)

handles.img_bin = imrotate(handles.img_bin,handles.deg,'bilinear','crop');
axes(handles.axes2);
imshow(handles.img_bin,[]);
guidata(hObject, handles);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%obracam w prawo 
function pushbutton10_Callback(hObject, eventdata, handles)
handles.img_bin = imrotate(handles.img_bin,-handles.deg,'bilinear','crop');
axes(handles.axes2);
imshow(handles.img_bin,[]);
guidata(hObject, handles);


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.odleglosc, handles.odleglosc_lr] = readArrayImg(handles.img_bin);
figure(1);
bar(handles.odleglosc);

title('podobieñstwo wobec bazy danych');
xlabel('numer obrazu');
ylabel('miara podobienstwa DTW');

figure(2);
bar([-90:-1 0 1:90],handles.odleglosc_lr);
size(handles.odleglosc_lr)
title('podobieñstwo wobec obrotu obrazu -90:90 stopnia');
xlabel('k¹t alfa');
ylabel('miara podobienstwa DTW');
