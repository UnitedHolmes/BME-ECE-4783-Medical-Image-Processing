function varargout = Module3_GUI(varargin)
% MODULE3_GUI MATLAB code for Module3_GUI.fig
%      MODULE3_GUI, by itself, creates a new MODULE3_GUI or raises the existing
%      singleton*.
%
%      H = MODULE3_GUI returns the handle to a new MODULE3_GUI or the handle to
%      the existing singleton*.
%
%      MODULE3_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODULE3_GUI.M with the given input arguments.
%
%      MODULE3_GUI('Property','Value',...) creates a new MODULE3_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Module3_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Module3_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Module3_GUI

% Last Modified by GUIDE v2.5 19-Apr-2016 23:19:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Module3_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Module3_GUI_OutputFcn, ...
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


% --- Executes just before Module3_GUI is made visible.
function Module3_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Module3_GUI (see VARARGIN)

% Choose default command line output for Module3_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Module3_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Module3_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

global STATE;

STATE.calculation_times = 7;

STATE.pop1 = 0;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% clear global;
%%%%%%%%%%%%%%%%%%%%% declaring global variable STATE ( used between different function definitions)
global STATE; 

% initialize the values for pops
set(handles.pushbutton2,'string', 'Ramblin On !!!');

set(handles.text1, 'string', 'Actual Class');
set(handles.text2, 'string', 'Prediction Result');

%%%%%%%%%%%%%%%%%%%%% generates pop-up window for selecting image
[filename, pathname] = uigetfile({'*.*';'*.tif';'*.jpg';'*.jpeg';'*.png'},'Select an image');
imageName = [pathname,filename];
STATE.image = filename;

%%%%%%%%%%%%%%%%%%%%% reading image
STATE.rgb=imread(imageName);

%%%%%%%%%%%%%%%%%%%%% image axes
%%%%%%% selecting axes
axes(handles.originImage) ;
%%%%%%% clearing axes
cla;
%%%%%%% Displaying image
imshow(STATE.rgb);
[file_1 remaining] = strtok(filename,'_');
STATE.image_class = file_1;
[file_2 remaining_2] = strtok(remaining,'.png');
STATE.image_number = str2num(file_2(2:end));
title(['Input RGB: ' file_1 ' ' file_2(2:end)]);
%%%%%%% resizing axes to image size
axis([0 size(STATE.rgb,2) 0 size(STATE.rgb,1)]);



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

global STATE;

selected = get(handles.popupmenu1,'value');
switch selected
    case 1
        STATE.pop1 = 0; % No selected
    case 2
        STATE.pop1 = 1; % k-Nearest Neighbor
    case 3
        STATE.pop1 = 2; % Neural Network
    case 4
        STATE.pop1 = 3; % Support Vector Machine
    otherwise        
end


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global STATE; 

set(handles.text1, 'string', [ 'Actual Class: ' STATE.image_class]);

prediction_correct = true;

load('MOD3_SCORES.mat');

switch STATE.pop1
    case 0        
        set(handles.text2, 'string', 'Please Select One Method!');
        
        set(handles.text12, 'string', 'NaN');
        set(handles.text13, 'string', 'NaN');
        set(handles.text14, 'string', 'NaN');
        set(handles.text15, 'string', 'NaN');
        set(handles.text16, 'string', 'NaN');
        set(handles.text17, 'string', 'NaN');
        set(handles.text18, 'string', 'NaN');
        set(handles.text19, 'string', 'NaN');
        set(handles.text20, 'string', 'NaN');
        set(handles.text21, 'string', 'NaN');
        set(handles.text22, 'string', 'NaN');
        set(handles.text23, 'string', 'NaN');
        
        prediction_correct = false;
        
    case 1  % k-Nearest Neighbor
        load('Input_KNN_Decision_Matrix.mat');
        
        class_no = 0;
        switch STATE.image_class
            case 'Necrosis'
                class_no = 2;
            case 'Stroma'
                class_no = 1;
            case 'Tumor'
                class_no = 3;
        end
        
        prediction_vector = KNN(STATE.image_number,class_no);
        
        switch prediction_vector
            case 1
                set(handles.text2, 'string', 'Prediction Result: Stroma');
            case 2
                set(handles.text2, 'string', 'Prediction Result: Necrosis');
            case 3
                set(handles.text2, 'string', 'Prediction Result: Tumor');
        end
        
        if class_no ~= prediction_vector
            prediction_correct = false;
        end
        
        % Display the matrix
        
        set(handles.text12, 'string', num2str(KNN_LOO_scores(1,1)));
        set(handles.text13, 'string', num2str(KNN_LOO_scores(2,1)));
        set(handles.text14, 'string', num2str(KNN_LOO_scores(3,1)));
        set(handles.text15, 'string', num2str(KNN_LOO_scores(4,1)));
        set(handles.text16, 'string', num2str(KNN_LOO_scores(1,2)));
        set(handles.text17, 'string', num2str(KNN_LOO_scores(2,2)));
        set(handles.text18, 'string', num2str(KNN_LOO_scores(3,2)));
        set(handles.text19, 'string', num2str(KNN_LOO_scores(4,2)));
        set(handles.text20, 'string', num2str(KNN_LOO_scores(1,3)));
        set(handles.text21, 'string', num2str(KNN_LOO_scores(2,3)));
        set(handles.text22, 'string', num2str(KNN_LOO_scores(3,3)));
        set(handles.text23, 'string', num2str(KNN_LOO_scores(4,3)));
        
        
    case 2  % Neural Network
        load('Input_NN_output_matrix.mat');
        
        class_no = 0;
        switch STATE.image_class
            case 'Necrosis'
                class_no = 1;
            case 'Stroma'
                class_no = 2;
            case 'Tumor'
                class_no = 3;
        end
        
        prediction_vector = y(:,(class_no-1).*100 + STATE.image_number);
        
        switch find(prediction_vector>0.75)
            case 1
                set(handles.text2, 'string', 'Prediction Result: Necrosis');
            case 2
                set(handles.text2, 'string', 'Prediction Result: Stroma');
            case 3
                set(handles.text2, 'string', 'Prediction Result: Tumor');
        end
        
        if class_no ~= find(prediction_vector>0.75)
            prediction_correct = false;
        end
        
        % Display the matrix
        
        set(handles.text12, 'string', num2str(NN_LOO_scores(1,1)));
        set(handles.text13, 'string', num2str(NN_LOO_scores(2,1)));
        set(handles.text14, 'string', num2str(NN_LOO_scores(3,1)));
        set(handles.text15, 'string', num2str(NN_LOO_scores(4,1)));
        set(handles.text16, 'string', num2str(NN_LOO_scores(1,2)));
        set(handles.text17, 'string', num2str(NN_LOO_scores(2,2)));
        set(handles.text18, 'string', num2str(NN_LOO_scores(3,2)));
        set(handles.text19, 'string', num2str(NN_LOO_scores(4,2)));
        set(handles.text20, 'string', num2str(NN_LOO_scores(1,3)));
        set(handles.text21, 'string', num2str(NN_LOO_scores(2,3)));
        set(handles.text22, 'string', num2str(NN_LOO_scores(3,3)));
        set(handles.text23, 'string', num2str(NN_LOO_scores(4,3)));
        
    case 3  % Support Vector Machine
        load('Input_SVM_output_matrix.mat');
        
        class_no = 0;
        switch STATE.image_class
            case 'Necrosis'
                class_no = 2;
            case 'Stroma'
                class_no = 1;
            case 'Tumor'
                class_no = 3;
        end
        
        prediction_vector = Cancer_num(STATE.image_number,class_no);
        
        switch prediction_vector
            case 1
                set(handles.text2, 'string', 'Prediction Result: Stroma');
            case 2
                set(handles.text2, 'string', 'Prediction Result: Necrosis');
            case 3
                set(handles.text2, 'string', 'Prediction Result: Tumor');
        end
        
        if class_no ~= prediction_vector
            prediction_correct = false;
        end
        
        % Display the matrix
        
        set(handles.text12, 'string', num2str(SVM_LOO_scores(1,1)));
        set(handles.text13, 'string', num2str(SVM_LOO_scores(2,1)));
        set(handles.text14, 'string', num2str(SVM_LOO_scores(3,1)));
        set(handles.text15, 'string', num2str(SVM_LOO_scores(4,1)));
        set(handles.text16, 'string', num2str(SVM_LOO_scores(1,2)));
        set(handles.text17, 'string', num2str(SVM_LOO_scores(2,2)));
        set(handles.text18, 'string', num2str(SVM_LOO_scores(3,2)));
        set(handles.text19, 'string', num2str(SVM_LOO_scores(4,2)));
        set(handles.text20, 'string', num2str(SVM_LOO_scores(1,3)));
        set(handles.text21, 'string', num2str(SVM_LOO_scores(2,3)));
        set(handles.text22, 'string', num2str(SVM_LOO_scores(3,3)));
        set(handles.text23, 'string', num2str(SVM_LOO_scores(4,3)));
        
    otherwise
end
        

if prediction_correct
    STATE.calculation_times = STATE.calculation_times - 1;
end

if STATE.calculation_times > 1
    pushbutton2_string = ['We are graduating in ' num2str(STATE.calculation_times) ' days!'];
    %set(handles.pushbutton2, 'string', 'We are graduating in 1 week!');
    set(handles.pushbutton2, 'string', pushbutton2_string);
end

if STATE.calculation_times == 1
    pushbutton2_string = ['We are graduating in ' num2str(STATE.calculation_times) ' day!'];
    set(handles.pushbutton2, 'string', pushbutton2_string);
end

if STATE.calculation_times == 0
    set(handles.pushbutton2, 'string', 'See you Bud Peterson!');
end

if STATE.calculation_times < 0
    set(handles.pushbutton2, 'string', 'Bye Buzz and Burdell!');
end

%% For fun section, add a picture of myself

if prediction_correct
    
    image_buzz=imread('Buzz.jpg');
    %%%%%%%%%%%%%%%%%%%%% image axes
    %%%%%%% selecting axes
    axes(handles.axes2) ;
    %%%%%%% clearing axes
    cla;
    %%%%%%% Displaying image
    imshow(image_buzz);
    
    %%%%%%% resizing axes to image size
    axis([0 size(STATE.rgb,2) 0 size(STATE.rgb,1)]);
    title('Yes, we have made it !');
    set(gca,'FontSize',18)
    
else
    
    image_chip=imread('Chip.jpg');
    %%%%%%%%%%%%%%%%%%%%% image axes
    %%%%%%% selecting axes
    
    
    axes(handles.axes2) ;
    %%%%%%% clearing axes
    cla;
    %%%%%%% Displaying image
    imshow(image_chip);
    
    %%%%%%% resizing axes to image size
    axis([0 size(STATE.rgb,2) 0 size(STATE.rgb,1)]);
    title('Wait, we have got a problem !');
    set(gca,'FontSize',18)
end
