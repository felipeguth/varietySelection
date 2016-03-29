function varargout = VarietySelection1(varargin)
% VarietySelection1 MATLAB code for VarietySelection1.fig
%      VarietySelection1, by itself, creates a new VarietySelection1 or raises the existing
%      singleton*.
%
%      H = VarietySelection1 returns the handle to a new VarietySelection1 or the handle to
%      the existing singleton*.
%
%      VarietySelection1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VarietySelection1.M with the given input arguments.
%
%      VarietySelection1('Property','Value',...) creates a new VarietySelection1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VarietySelection1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VarietySelection1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VarietySelection1

% Last Modified by GUIDE v2.5 23-Mar-2016 16:25:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VarietySelection1_OpeningFcn, ...
                   'gui_OutputFcn',  @VarietySelection1_OutputFcn, ...
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


% --- Executes just before VarietySelection1 is made visible.
function VarietySelection1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VarietySelection1 (see VARARGIN)

% Choose default command line output for VarietySelection1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VarietySelection1 wait for user response (see UIRESUME)
 uiwait(gcf);


% --- Outputs from this function are returned to the command line.
function varargout = VarietySelection1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



%market
group1 = get(handles.radiobutton1,'value'); 
group2 = get(handles.radiobutton2,'value');
group3 = get(handles.radiobutton3,'value');
group4 = get(handles.radiobutton4,'value');
group5 = get(handles.radiobutton5,'value'); 

if group1 == 1
    varargout{2} = 1;
elseif group2 == 1
    varargout{2} = 2;
elseif group3 == 1
    varargout{2} = 3;
elseif group4 == 1
    varargout{2} = 4;
elseif group5 == 1
    varargout{2} = 5;
end


%soil
soilLight = get(handles.radiobutton6,'value'); 
soilMid = get(handles.radiobutton7,'value');
soilHeavy = get(handles.radiobutton8,'value');

if soilLight == 1
    varargout{3} = 1;
elseif soilMid == 1
    varargout{3} = 2;
elseif soilHeavy == 1
    varargout{3} = 3;
end

%sowing date
sowingEarly = get(handles.radiobutton15,'value');
sowingMid = get(handles.radiobutton16,'value');
sowingLate = get(handles.radiobutton17,'value');

if sowingEarly == 1
     varargout{4} = 1;
elseif sowingMid == 1
     varargout{4} = 2;
elseif sowingLate == 1
    varargout{4} = 3;
end


%rotational position
fstCereal = get(handles.radiobutton18,'value');
scndCereal = get(handles.radiobutton19,'value');

if fstCereal == 1
    varargout{5} = 1;
elseif scndCereal == 1
    varargout{5} = 2;
end

%region
westUk = get(handles.radiobutton23,'value');
northUk = get(handles.radiobutton24,'value');
eastUk = get(handles.radiobutton25,'value');

if westUk == 1
    varargout{6} = 'W';
elseif northUk == 1
    varargout{6} = 'N';
elseif eastUk == 1
    varargout{6} = 'E';
end


%District
district = get(handles.popupmenu1,'value');

if district == 1
    dist = 'EE';%east england
elseif district == 2
    dist = 'ML';%midlands
elseif district == 3
    dist = 'NE'; %northeast england
elseif district == 4
    dist = 'NW';%Nortwest england
elseif district == 5
    dist = 'SE'; %South england
elseif district == 6
    dist = 'SW';%South west england
elseif district == 7
    dist = 'NI'; %northern ireland
elseif district == 8
    dist = 'ES'; %east scotland
elseif district == 9
    dist = 'WL'; %Wales
end

varargout{7} = dist;

%get importance factor of measurements
% varargout{8} = get(handles.popupmenu2, 'value'); %meanYield
% varargout{9} = get(handles.popupmenu3, 'value');%Yield
% varargout{10} = get(handles.popupmenu4, 'value');%number of trials









% Get default command line output from handles structure
varargout{1} = handles.output;
uiresume(gcf);

%disp(handles);

delete(hObject)

% --- Executes ovarargout{1} = handles.output;n selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%g1 = get(get(handles.uipanel1,'radiobutton1'), 'radiobutton1');
VarietySelection1_OutputFcn(hObject, eventdata, handles) 
%close(VarietySelection1);


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


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


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
