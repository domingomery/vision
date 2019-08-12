function varargout = CV02_Perspective(varargin)
% CV02_PERSPECTIVE M-file for CV02_Perspective.fig
%      CV02_PERSPECTIVE, by itself, creates a new CV02_PERSPECTIVE or raises the existing
%      singleton*.
%
%      H = CV02_PERSPECTIVE returns the handle to a new CV02_PERSPECTIVE or the handle to
%      the existing singleton*.
%
%      CV02_PERSPECTIVE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CV02_PERSPECTIVE.M with the given input arguments.
%
%      CV02_PERSPECTIVE('Property','Value',...) creates a new CV02_PERSPECTIVE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before perspec_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CV02_Perspective_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help CV02_Perspective

% Last Modified by GUIDE v2.5 12-Aug-2019 09:39:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CV02_Perspective_OpeningFcn, ...
                   'gui_OutputFcn',  @CV02_Perspective_OutputFcn, ...
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


% --- Executes just before CV02_Perspective is made visible.
function CV02_Perspective_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CV02_Perspective (see VARARGIN)

% Choose default command line output for CV02_Perspective
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CV02_Perspective wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CV02_Perspective_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in txplux.
function txplux_Callback(hObject, eventdata, handles)
% hObject    handle to txplux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
tx = tx+0.2;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in txminus.
function txminus_Callback(hObject, eventdata, handles)
% hObject    handle to txminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
tx = tx-0.2;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in typlus.
function typlus_Callback(hObject, eventdata, handles)
% hObject    handle to typlus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
ty = ty+0.2;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in tyminus.
function tyminus_Callback(hObject, eventdata, handles)
% hObject    handle to tyminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
ty = ty-0.2;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in tzplus.
function tzplus_Callback(hObject, eventdata, handles)
% hObject    handle to tzplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
tz = tz+0.2;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in tzminus.
function tzminus_Callback(hObject, eventdata, handles)
% hObject    handle to tzminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
tz = tz-0.2;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in wxplus.
function wxplus_Callback(hObject, eventdata, handles)
% hObject    handle to wxplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
wx = wx+pi/36;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in wxminus.
function wxminus_Callback(hObject, eventdata, handles)
% hObject    handle to wxminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
wx = wx-pi/36;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in wyplus.
function wyplus_Callback(hObject, eventdata, handles)
% hObject    handle to wyplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
wy = wy+pi/36;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in wyminus.
function wyminus_Callback(hObject, eventdata, handles)
% hObject    handle to wyminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
wy = wy-pi/36;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in wzplus.
function wzplus_Callback(hObject, eventdata, handles)
% hObject    handle to wzplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
wz = wz+pi/36;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)


% --- Executes on button press in wzminus.
function wzminus_Callback(hObject, eventdata, handles)
% hObject    handle to wzminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load perspecdata
wz = wz-pi/36;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)

% --- Executes on button press in input.
function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tx = input('tx? ');
ty = input('ty? ');
tz = input('tz? ');

wx = input('wx? ');
wy = input('wy? ');
wz = input('wz? ');

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)

% --- Executes on button press in restore.
function restore_Callback(hObject, eventdata, handles)
% hObject    handle to restore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tx = 0;
ty = 0;
tz = 3;
wx = 0;
wy = 0;
wz = 0;

save perspecdata tx ty tz wx wy wz
CV02_experspec(tx,ty,tz,wx,wy,wz)

