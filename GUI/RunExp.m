function varargout = RunExp(varargin)
% RUNEXP M-file for RunExp.fig
%      RUNEXP, by itself, creates a new RUNEXP or raises the existing
%      singleton*.
%
%      H = RUNEXP returns the handle to a new RUNEXP or the handle to
%      the existing singleton*.
%
%      RUNEXP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUNEXP.M with the given input arguments.
%
%      RUNEXP('Property','Value',...) creates a new RUNEXP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RunExp_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RunExp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help RunExp

% Last Modified by GUIDE v2.5 14-Feb-2017 13:10:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RunExp_OpeningFcn, ...
                   'gui_OutputFcn',  @RunExp_OutputFcn, ...
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


% --- Executes just before RunExp is made visible.
function RunExp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RunExp (see VARARGIN)

% Choose default command line output for RunExp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RunExp wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RunExp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles;
delete(gcf)

function nsub_Callback(hObject, eventdata, handles)
% hObject    handle to nsub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nsub as text
%        str2double(get(hObject,'String')) returns contents of nsub as a double


% --- Executes during object creation, after setting all properties.
function nsub_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nsub (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function subname_Callback(hObject, eventdata, handles)
% hObject    handle to subname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subname as text
%        str2double(get(hObject,'String')) returns contents of subname as a double


% --- Executes during object creation, after setting all properties.
function subname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function subsex_Callback(hObject, eventdata, handles)
% hObject    handle to subsex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subsex as text
%        str2double(get(hObject,'String')) returns contents of subsex as a double


% --- Executes during object creation, after setting all properties.
function subsex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subsex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function subage_Callback(hObject, eventdata, handles)
% hObject    handle to subage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subage as text
%        str2double(get(hObject,'String')) returns contents of subage as a double


% --- Executes during object creation, after setting all properties.
function subage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function subnote_Callback(hObject, eventdata, handles)
% hObject    handle to subnote (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subnote as text
%        str2double(get(hObject,'String')) returns contents of subnote as a double


% --- Executes during object creation, after setting all properties.
function subnote_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subnote (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename as text
%        str2double(get(hObject,'String')) returns contents of filename as a double


% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in QuitExp.
function QuitExp_Callback(hObject, eventdata, handles)
% hObject    handle to QuitExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(gcf)


% --- Executes on button press in RunPractice.
function RunPractice_Callback(hObject, eventdata, handles)
% hObject    handle to RunPractice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.nsub = get(handles.nsub,'String');
handles.subname = get(handles.subname,'String');
handles.subsex = get(handles.subsex,'String');
handles.subage = str2double(get(handles.subage,'String'));
handles.subnote = get(handles.subnote,'String');
handles.isfixed = get(handles.isfixed,'Value') == get(handles.isfixed,'Max');
uiresume(handles.figure1);
 handles;


% --- Executes on button press in RunExp.
function RunExp_Callback(hObject, eventdata, handles)
% hObject    handle to RunExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.nsub = str2double(get(handles.nsub,'String'));
handles.nsub = get(handles.nsub,'String');
handles.subname = get(handles.subname,'String');
handles.subsex = get(handles.subsex,'String');
handles.subage = str2double(get(handles.subage,'String'));
handles.subnote = get(handles.subnote,'String');
handles.isfixed = get(handles.isfixed,'Value') == get(handles.isfixed,'Max');
guidata(hObject, handles);
uiresume(handles.figure1);
 handles;


% --- Executes on button press in isfixed.
function isfixed_Callback(hObject, eventdata, handles)
% hObject    handle to isfixed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isfixed
% handles.isfixed = get(hObject,'Value') == get(hObject,'Max');
