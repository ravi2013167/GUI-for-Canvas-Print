function varargout = untitled2(varargin)
% UNTITLED2 MATLAB code for untitled2.fig
%      UNTITLED2, by itself, creates a new UNTITLED2 or raises the existing
%      singleton*.
%
%      H = UNTITLED2 returns the handle to a new UNTITLED2 or the handle to
%      the existing singleton*.
%
%      UNTITLED2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED2.M with the given input arguments.
%
%      UNTITLED2('Property','Value',...) creates a new UNTITLED2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled2

% Last Modified by GUIDE v2.5 12-Feb-2016 10:13:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled2_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled2_OutputFcn, ...
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


% --- Executes just before untitled2 is made visible.
function untitled2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled2 (see VARARGIN)

% Choose default command line output for untitled2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled2_OutputFcn(hObject, eventdata, handles) 
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
a=fopen('ravi.txt','r');
if a==-1
error('Error opening file.');
end
q=1;
p=1;
while feof(a)==0
L = fgetl(a);
nums_1(1,:) = sscanf(L,'%e %e', [1,inf]);
x(q)=nums_1(1,1);
y(q)=nums_1(1,2);
q=q+1;
end
q=q-1;
for i=1:1:q-1
plot([x(i) x(i+1)],[y(i) y(i+1)],'-.og')
hold on
end
plot([x(1) x(q)],[y(1) y(q)],'-.og')
ymax = max(y);
          
        
        dia=input('Enter tool Diameter');
        iy = y(1)+ dia/2;
        
        slope = (y(1)-y(q))/(x(1)-x(q));
        ix = (iy-y(1))/slope + x(1);
        turn=1;
        h(p,1)=ix;
        h(p,2)=iy;
        p=p+1;
        i=1;
        j=q;
        
        while iy < ymax(1)
     
            if mod(turn,2)==1 
                while i < q && y(i+1) < iy 
                    i=i+1;
                end
                slope = (y(i)-y(i+1))/(x(i)-x(i+1));
                ix = (iy - y(i))/slope + x(i);
                if ~((ix == x(i) & iy == y(i)) | (ix == x(i+1) & iy == y(i+1)))
                   
                    h(p,1)=ix;
                    h(p,2)=iy;
                    p=p+1;
                end
                iy = iy+dia;
                if iy >= ymax
                    break;
                end
                while i < q && y(i+1) < iy 
                    i=i+1;
                end
                slope = (y(i)-y(i+1))/(x(i)-x(i+1));
                ix=(iy-y(i))/slope + x(i);
                if ~((ix == x(i) & iy == y(i)) | (ix == x(i+1) && iy == y(i+1)))
                   
                    h(p,1)=ix;
                    h(p,2)=iy;
                    p=p+1;
                end
                       
            else
                while (j>1 && y(j) < iy) 
                    j=j-1;
                end
                k=mod(j,q)+1;
                if(k==0)
                    k=1;
                end
                slope = (y(j)-y(k))/(x(j)-x(k));
                ix = (iy - y(j))/slope + x(j);
                if(~((ix == x(i) && iy == y(i)) || (ix == x(i+1) && iy == y(i+1))))
                    
                    h(p,1)=ix;
                    h(p,2)=iy;
                    p=p+1;
                end
                iy = iy + dia;
                if iy >= ymax
                    break;
                end
                while(j>1 && y(j) < iy)
                        j=j-1;
                end
                k=mod(j,q)+1;
               if(k==0)
                   k=1;
               end     
                slope = (y(j)-y(k))/(x(j)-x(k));
                ix=(iy-y(j))/slope + x(j);
                if(~((ix == x(i) && iy == y(i)) || (ix == x(i+1) && iy == y(i+1))))
                    h(p,1)=ix;
                    h(p,2)=iy;
                    p=p+1;
                end
        end
        turn=1-turn;
        end
        for i=1:1:p-2
plot([h(i,1) h(i+1,1)],[h(i,2) h(i+1,2)],'o.og')
hold on
end






% --- Executes on selection change in popupmenu1.
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%d=str2double(get(handles.edit5,'string'));
r=1;
p=1;
q=input('Enter no. of points');
for i=1:1:q 
a(i,:)=ginput(1);
x(r)=a(i,1);
y(r)=a(i,2);
r=r+1;
end
for i=1:1:q-1
plot([a(i,1) a(i+1,1)],[a(i,2) a(i+1,2)],'-.og')
hold on
end
plot([a(1,1) a(q,1)],[a(1,2) a(q,2)],'-.og')
hold on;
ymax = max(y);
        
        dia=input('Enter Tool Diameter');
        iy = y(1)+ dia/2;
        
        slope = (y(1)-y(q))/(x(1)-x(q));
        ix = (iy-y(1))/slope + x(1);
        turn=1;
        h(p,1)=ix;
        h(p,2)=iy;
        p=p+1;
        i=1;
        j=q;
        
        while iy < ymax(1)
     
            if mod(turn,2)==1 
                while i < q && y(i+1) < iy 
                    i=i+1;
                end
                slope = (y(i)-y(i+1))/(x(i)-x(i+1));
                ix = (iy - y(i))/slope + x(i);
                if ~((ix == x(i) & iy == y(i)) | (ix == x(i+1) & iy == y(i+1)))
                    h(p,1)=ix;
                    h(p,2)=iy;
                    p=p+1;
                end
                iy = iy+dia;
                if iy >= ymax
                    break;
                end
                while i < q && y(i+1) < iy 
                    i=i+1;
                end
                slope = (y(i)-y(i+1))/(x(i)-x(i+1));
                ix=(iy-y(i))/slope + x(i);
                if ~((ix == x(i) & iy == y(i)) | (ix == x(i+1) && iy == y(i+1)))
                    h(p,1)=ix;
                    h(p,2)=iy;
                    p=p+1;
                end
                       
            else
                while (j>1 && y(j) < iy) 
                    j=j-1;
                end
                k=mod(j,q)+1;
                if(k==0)
                    k=1;
                end
                slope = (y(j)-y(k))/(x(j)-x(k));
                ix = (iy - y(j))/slope + x(j);
                if(~((ix == x(i) && iy == y(i)) || (ix == x(i+1) && iy == y(i+1))))
                     h(p,1)=ix;
                    h(p,2)=iy;
                    p=p+1;
                end
                iy = iy + dia;
                if iy >= ymax
                    break;
                end
                while(j>1 && y(j) < iy)
                        j=j-1;
                end
                k=mod(j,q)+1;
               if(k==0)
                   k=1;
               end     
                slope = (y(j)-y(k))/(x(j)-x(k));
                ix=(iy-y(j))/slope + x(j);
                if(~((ix == x(i) && iy == y(i)) || (ix == x(i+1) && iy == y(i+1))))
                    h(p,1)=ix;
                    h(p,2)=iy;
                    p=p+1;
                end
        end
        turn=1-turn;
        end
        for i=1:1:p-2
plot([h(i,1) h(i+1,1)],[h(i,2) h(i+1,2)],'-.og')
hold on
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
