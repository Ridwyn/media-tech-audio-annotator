function varargout = audio_annotator(varargin)
% AUDIO_ANNOTATOR MATLAB code for audio_annotator.fig
%      AUDIO_ANNOTATOR, by itself, creates a new AUDIO_ANNOTATOR or raises the existing
%      singleton*.
%
%      H = AUDIO_ANNOTATOR returns the handle to a new AUDIO_ANNOTATOR or the handle to
%      the existing singleton*.
%
%      AUDIO_ANNOTATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDIO_ANNOTATOR.M with the given input arguments.
%
%      AUDIO_ANNOTATOR('Property','Value',...) creates a new AUDIO_ANNOTATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before audio_annotator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to audio_annotator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help audio_annotator

% Last Modified by GUIDE v2.5 18-Apr-2021 11:36:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @audio_annotator_OpeningFcn, ...
                   'gui_OutputFcn',  @audio_annotator_OutputFcn, ...
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


%Globals variables
global SEEDINGAUDIO1;
global AUDIO1TRIMSTARTLINE;
global AUDIO1TRIMENDLINE;
global AUDIO1TRIMSTARTTIME;
global AUDIO1TRIMENDTIME;

global SEEDINGAUDIO2;
global AUDIO2TRIMSTARTLINE;
global AUDIO2TRIMENDLINE;
global AUDIO2TRIMSTARTTIME;
global AUDIO2TRIMENDTIME;

global AUDIO3TRIMSTARTLINE;
global AUDIO3TRIMENDLINE;
global SEEDINGAUDIO3;

global PLAYER1;
global PLAYER2;
global PLAYER3;




function setAudio(val,sr,type)
    global AUDIO1;
    global FS1;
    global AUDIO2;
    global FS2;
    global AUDIO3;
    global FS3;
    
    if(strcmp(type,'audio1'))
        AUDIO1 = val;
        FS1 = sr;
    end
    if(strcmp(type,'audio2'))
        AUDIO2 = val;
        FS2 = sr;
    end
    if(strcmp(type,'audio3'))
        AUDIO3 = val;
        FS3 = sr;
    end

function [audio,fs] = getAudio(type)
    global AUDIO1;
    global FS1;
    global AUDIO2;
    global FS2;
    global AUDIO3;
    global FS3;

    if(strcmp(type,'audio1'))
        audio = AUDIO1;
        fs = FS1;
    end
    if(strcmp(type,'audio2'))
        audio = AUDIO2;
        fs = FS2;
    end
	if(strcmp(type,'audio3'))
        audio = AUDIO3;
        fs = FS3;
    end
    
    




function [bol] = isAudiosImported__()
    [audio2,fs2]=getAudio('audio2');
    [audio1,fs1]=getAudio('audio1');
    if(fs1 ~=0)
        if((fs2~=0))
            bol = true;
        else
            bol= false;
        end
    end
    if(fs2 ~=0)
        if((fs1~=0))
            bol = true;
        else
            bol= false;
        end
    end
    
function [num]=myNumberCheck__(ObjH,limit)
    S = get(ObjH, 'String');
    % Exclude characters, which are accepted by sscanf:
    S(ismember(S, '-+eEgG')) = ' ';
    % Convert to one number and back to a string:
    S2 = sprintf('%g', sscanf(S, '%g', 1));
    
    set(ObjH, 'String', S2);
    % Perhaps a small warning in WARNDLG or inside the GUI:
    if ~all(ismember(S, '.1234567890'))
        set(ObjH, 'String', 0);
    end
      
    if (str2num(S2)>limit)
        num=limit; 
        set(ObjH, 'String', limit);
    end
    
    num=get(ObjH, 'String');
    

function  setAudioPlotLines(starttrimline,endtrimline,seedingline,axes,type)
    % Start and End bars
	global AUDIO1TRIMSTARTLINE;
    global AUDIO1TRIMENDLINE;
    global SEEDINGAUDIO1;
    
    global AUDIO2TRIMSTARTLINE;
    global AUDIO2TRIMENDLINE;
    global SEEDINGAUDIO2;
    
    global AUDIO3TRIMSTARTLINE;
    global AUDIO3TRIMENDLINE;
    global SEEDINGAUDIO3;
    
    if(strcmp(type,'audio1'))
     AUDIO1TRIMSTARTLINE=xline(axes,starttrimline,'-+r','Start');
     SEEDINGAUDIO1=xline(axes,seedingline,'-+y','');
     SEEDINGAUDIO1.LineWidth=2;
     AUDIO1TRIMENDLINE=xline(axes,endtrimline,'-+g','End');
    end
    if(strcmp(type,'audio2'))
     AUDIO2TRIMSTARTLINE=xline(axes,starttrimline,'-+r','Start');
     SEEDINGAUDIO2=xline(axes,seedingline,'-+y','');
     SEEDINGAUDIO2.LineWidth=2;
     AUDIO2TRIMENDLINE=xline(axes,endtrimline,'-+g','End');
    end
    if(strcmp(type,'audio3'))
     AUDIO3TRIMSTARTLINE=xline(axes,starttrimline,'-+r','Start');
     SEEDINGAUDIO3=xline(axes,seedingline,'-+y','');
     SEEDINGAUDIO3.LineWidth=2;
     AUDIO3TRIMENDLINE=xline(axes,endtrimline,'-+g','End');
    end
    
     %Plot Axes labels 
      axes.XLabel.String='Time (s)'; 
      axes.YLabel.String='Amplitude';
    
    % --- Executes just before audio_annotator is made visible.
function audio_annotator_OpeningFcn(hObject, eventdata, handles, varargin)

    %     Settingplot line on axes
    setAudioPlotLines(0,1,0,handles.audio1Axes,'audio1');
    setAudioPlotLines(0,1,0,handles.audio2Axes,'audio2');




% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to audio_annotator (see VARARGIN)

% Choose default command line output for audio_annotator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes audio_annotator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = audio_annotator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

         
function setAudioStatus__(player,type,statusString)
	status = findobj('Tag',['audio' type 'Status']);
    if(strcmp(statusString,'start'))
           status.String='on';
           status.BackgroundColor=[0.0 1.0 0.0];
    end
    if(strcmp(statusString,'stop'))
           status.String='off';
           status.BackgroundColor=[1.0 0.0 0.0];
    end

function audioPlayerStartStop__(obj, event,player,type,status)
     setAudioStatus__(player,type,status);

function audioPlayerPlaying__(obj,event,player,type,audiostatusgui)
    global SEEDINGAUDIO1;
    global SEEDINGAUDIO2;
    global SEEDINGAUDIO3;
    if(strcmp(type,'audio1'))            
        currenttime=floor(player.CurrentSample/player.SampleRate);
    	SEEDINGAUDIO1.Value=currenttime;
        [audiostarttime,audioendtime]=getAudioTrimTimes__('audio1');
        if((currenttime)==floor(audioendtime-1))
            audiostatusgui.String='off';
            audiostatusgui.BackgroundColor=[1.0 0.0 0.0];
        end
    end
    if(strcmp(type,'audio2'))            
        currenttime=floor(player.CurrentSample/player.SampleRate);
    	SEEDINGAUDIO2.Value=currenttime;
        [audiostarttime,audioendtime]=getAudioTrimTimes__('audio2');
        if((currenttime)==floor(audioendtime-1))
            audiostatusgui.String='off';
            audiostatusgui.BackgroundColor=[1.0 0.0 0.0];
        end
    end
    if(strcmp(type,'audio3')) 
        currenttime=floor(player.CurrentSample/player.SampleRate);
    	SEEDINGAUDIO3.Value=currenttime;
        [audiostarttime,audioendtime]=getAudioTrimTimes__('audio3');
        if((currenttime)==floor(audioendtime-1))
            audiostatusgui.String='off';
            audiostatusgui.BackgroundColor=[1.0 0.0 0.0];
        end
    end


function setAudioTrimTimes__(starttime,endtime,type) 
    global AUDIO1TRIMENDTIME;
    global AUDIO1TRIMSTARTTIME;
    
    global AUDIO2TRIMENDTIME;
    global AUDIO2TRIMSTARTTIME;
    
    global AUDIO3TRIMENDTIME;
    global AUDIO3TRIMSTARTTIME;
    
    if(strcmp(type,'audio1'))
        AUDIO1TRIMENDTIME=endtime;
        AUDIO1TRIMSTARTTIME=starttime;
    end
     if(strcmp(type,'audio2'))
        AUDIO2TRIMENDTIME=endtime;
        AUDIO2TRIMSTARTTIME=starttime;
     end
     if(strcmp(type,'audio3'))
        AUDIO3TRIMENDTIME=endtime;
        AUDIO3TRIMSTARTTIME=starttime;
    end
    
    
function[audiostarttime,audioendtime]= getAudioTrimTimes__(type)
    global AUDIO1TRIMENDTIME;
    global AUDIO1TRIMSTARTTIME;
    
    global AUDIO2TRIMENDTIME;
    global AUDIO2TRIMSTARTTIME;
    
    global AUDIO3TRIMENDTIME;
    global AUDIO3TRIMSTARTTIME;
    
    if(strcmp(type,'audio1'))    
        audiostarttime = AUDIO1TRIMSTARTTIME;
        audioendtime = AUDIO1TRIMENDTIME;
    end
    if(strcmp(type,'audio2'))    
        audiostarttime = AUDIO2TRIMSTARTTIME;
        audioendtime = AUDIO2TRIMENDTIME;
    end
	if(strcmp(type,'audio3'))    
        audiostarttime = AUDIO3TRIMSTARTTIME;
        audioendtime = AUDIO3TRIMENDTIME;
    end


function setAudioPlayer__(audio,fs,audiostatusgui,type)
    global PLAYER1;
    global PLAYER2;
    global PLAYER3;
    if(strcmp(type,'audio1'))
        PLAYER1 = audioplayer(audio, fs);
        PLAYER1.StopFcn = {@audioPlayerStartStop__,PLAYER1, '1','stop'};
        PLAYER1.StartFcn ={@audioPlayerStartStop__,PLAYER1, '1','start'};
        PLAYER1.TimerFcn = {@audioPlayerPlaying__,PLAYER1, 'audio1',audiostatusgui};
    end
    if(strcmp(type,'audio2'))
        PLAYER2 = audioplayer(audio, fs);
        PLAYER2.StopFcn = {@audioPlayerStartStop__,PLAYER2, '2','stop'};
        PLAYER2.StartFcn ={@audioPlayerStartStop__,PLAYER2, '2','start'};
        PLAYER2.TimerFcn = {@audioPlayerPlaying__,PLAYER2, 'audio2',audiostatusgui};
    end
    if(strcmp(type,'audio3'))
        PLAYER3 = audioplayer(audio, fs);
        PLAYER3.StopFcn = {@audioPlayerStartStop__,PLAYER3, '3','stop'};
        PLAYER3.StartFcn ={@audioPlayerStartStop__,PLAYER3, '3','start'};
        PLAYER3.TimerFcn = {@audioPlayerPlaying__,PLAYER3, 'audio3',audiostatusgui};
    end

    
% --- Executes on button press in importAudio1Btn.
function importAudio1Btn_Callback(hObject, eventdata, handles)
 [file,path] = uigetfile({'*.mp3;*.wav;*.m4a;';'*.raw';'*.*'},...
                          'Select File');
                      
 filepath = append(path,file);
 set(handles.audio1FilePathText,'string',filepath); 
%  Read audio file
 [audio,Fs] = audioread(filepath);
 info = audioinfo(filepath);
%  Store audio globally
 setAudio(audio,Fs,'audio1');
 [audio1,fs1] = getAudio('audio1');
 
   
%  Set audio1 player
    setAudioPlayer__(audio1, fs1,handles.audio1Status,'audio1');
    
%   Set Audio trim Lines
    setAudioTrimTimes__(1,floor(length(audio1)/fs1),'audio1');    
    
    [bol] = isAudiosImported__();
    if(bol)
      set(handles.mixMixerBtn,'Enable','on');
      set(handles.playMixerBtn,'Enable','on');
      set(handles.resumeMixerBtn,'Enable','on');
      set(handles.stopMixerBtn,'Enable','on');
      set(handles.pauseMixerBtn,'Enable','on');
      set(handles.saveMixerBtn,'Enable','on');
    end
 
    dt=1/fs1;
    time=0:dt:(length(audio)*dt)-dt;
    % Plot Audio on axes
    plot(handles.audio1Axes,time,audio(:,1));
    
%     Settingplot line on axes
      setAudioPlotLines(0,info.Duration,0,handles.audio1Axes,'audio1');    
     
%   Trim Audio Selection
 	set(handles.audio1TrimStartText,'String',1);
    set(handles.audio1TrimEndText,'String',floor(info.Duration));
    set(handles.audio1TotalTimeText,'String',[num2str(floor(info.Duration)) '(s)']);
    


% hObject    handle to importAudio1Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in playAudio1Btn.
function playAudio1Btn_Callback(hObject, eventdata, handles)
    [audio1,fs1] = getAudio('audio1');
    global PLAYER1;
    
    %     Setting the start and stop times;
    [audiostarttime,audioendtime]=getAudioTrimTimes__('audio1');
    stoptime= audioendtime * PLAYER1.SampleRate;
    starttime=   audiostarttime * PLAYER1.SampleRate;
    play(PLAYER1,[starttime,stoptime]);


% hObject    handle to playAudio1Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stopAudio1Btn.
function stopAudio1Btn_Callback(hObject, eventdata, handles)
    global PLAYER1;
    stop(PLAYER1);

% hObject    handle to stopAudio1Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pauseAudio1Btn.
function pauseAudio1Btn_Callback(hObject, eventdata, handles)
    global PLAYER1;
    pause(PLAYER1);

% hObject    handle to pauseAudio1Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in resumeAudio1Btn.
function resumeAudio1Btn_Callback(hObject, eventdata, handles)
    global PLAYER1;
    resume(PLAYER1);

% hObject    handle to resumeAudio1Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function audio1FilePathText_Callback(hObject, eventdata, handles)
% hObject    handle to audio1FilePathText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of audio1FilePathText as text
%        str2double(get(hObject,'String')) returns contents of audio1FilePathText as a double




% --- Executes on button press in importAudio2Btn.
function importAudio2Btn_Callback(hObject, eventdata, handles)
    [file,path] = uigetfile({'*.mp3;*.wav;*.m4a;';'*.raw';'*.*'},...
                          'Select File');
                      
	filepath = append(path,file);
	set(handles.audio2FilePathText,'string',filepath); 
    %  Read audio file
	[audio,Fs] = audioread(filepath);
	info = audioinfo(filepath);
    %  Store audio globally
	setAudio(audio,Fs,'audio2');
	[audio2,fs2] = getAudio('audio2');
 
   
    %  Set audio2 player
    setAudioPlayer__(audio2, fs2,handles.audio2Status,'audio2');
    
    %   Set Audio trim Lines
    setAudioTrimTimes__(1,floor(length(audio2)/fs2),'audio2');    
    
    [bol] = isAudiosImported__();
    if(bol)
      set(handles.mixMixerBtn,'Enable','on');
      set(handles.playMixerBtn,'Enable','on');
      set(handles.resumeMixerBtn,'Enable','on');
      set(handles.stopMixerBtn,'Enable','on');
      set(handles.pauseMixerBtn,'Enable','on');
      set(handles.saveMixerBtn,'Enable','on');
    end
 
    dt=1/fs2;
    time=0:dt:(length(audio)*dt)-dt;
    % Plot Audio on axes
    plot(handles.audio2Axes,time,audio(:,1));
    
    % Settingplot line on axes
	setAudioPlotLines(0,info.Duration,0,handles.audio2Axes,'audio2');    
     
%   Trim Audio Selection
 	set(handles.audio2TrimStartText,'String',1);
    set(handles.audio2TrimEndText,'String',floor(info.Duration));
    set(handles.audio2TotalTimeText,'String',[num2str(floor(info.Duration)) '(s)']);
    

% hObject    handle to importAudio2Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in playAudio2Btn.
function playAudio2Btn_Callback(hObject, eventdata, handles)
    global PLAYER2;
    %     Setting the start and stop times;
    [audiostarttime,audioendtime]=getAudioTrimTimes__('audio2');
    stoptime= audioendtime * PLAYER2.SampleRate;
    starttime=   audiostarttime * PLAYER2.SampleRate;
    play(PLAYER2,[starttime,stoptime]);
% hObject    handle to playAudio2Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stopAudio2Btn.
function stopAudio2Btn_Callback(hObject, eventdata, handles)
    global PLAYER2;
    stop(PLAYER2);
% hObject    handle to stopAudio2Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function audio2FilePathText_Callback(hObject, eventdata, handles)
% hObject    handle to audio2FilePathText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of audio2FilePathText as text
%        str2double(get(hObject,'String')) returns contents of audio2FilePathText as a double



% --- Executes on button press in pauseAudio2Btn.
function pauseAudio2Btn_Callback(hObject, eventdata, handles)
    global PLAYER2;
    pause(PLAYER2);
% hObject    handle to pauseAudio2Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in resumeAudio2Btn.
function resumeAudio2Btn_Callback(hObject, eventdata, handles)
     global PLAYER2;
    resume(PLAYER2);
% hObject    handle to resumeAudio2Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in mixMixerBtn.
function mixMixerBtn_Callback(hObject, eventdata, handles)
    [audio1,fs1]= getAudio('audio1');
    [audio2,fs2]= getAudio('audio2');
	global AUDIO1TRIMSTARTTIME;
    global AUDIO1TRIMENDTIME;
	global AUDIO2TRIMSTARTTIME;
    global AUDIO2TRIMENDTIME;
    
	%get trimmed audios
	audio1=audio1((AUDIO1TRIMSTARTTIME*fs1):(AUDIO1TRIMENDTIME*fs1),:);
	audio2=audio2((AUDIO2TRIMSTARTTIME*fs2):(AUDIO2TRIMENDTIME*fs2),:);
    
%     Resample Both audios
	maxFs=max(fs1,fs2);
    audio1=resample(audio1,maxFs,fs1);
    audio2=resample(audio2,maxFs,fs2);
    diff=abs(length(audio1)-length(audio2));
    
%     Make sure both audios are the same length i.e pad shorter audio with
%     zeros
    if(length(audio1)>length(audio2))
    	audio2= padarray(audio2,[diff,0],0,'post');
    else
         audio1= padarray(audio1,[diff,0],0,'post');   
    end
    

    
    [audio1rows, audio1cols]=size(audio1);
    [audio2rows, audio2cols]=size(audio2);
    
%     Make sure the waves have same number of channels i.e pad second column with zeros 
    if(audio1cols~=2)
        audio1= padarray(audio1,[0,1],0,'post');
    end
    
	if(audio2cols~=2)
        audio2= padarray(audio2,[0,1],0,'post');
    end
    
    
    %mixed both audios
	mixedAudio=audio1+audio2;
    
    %Store audio in global variable
    setAudio(mixedAudio,maxFs,'audio3');

    % Set audio player for Mixer
    setAudioPlayer__(mixedAudio, maxFs,handles.audio3Status,'audio3');
    
    %Set Audio trim Lines
    setAudioTrimTimes__(1,floor(length(mixedAudio)/maxFs),'audio3'); 
    
    %calculate the length of mixedaudio to plot
    dt=1/maxFs;
    time=0:dt:(length(mixedAudio)*dt)-dt;   
    
    % Plot Audio on axes
    plot(handles.audio3Axes,time,mixedAudio(:,2));
    
    % Settingplot line on axes
	setAudioPlotLines(0,floor(length(mixedAudio)/maxFs),0,handles.audio3Axes,'audio3');    
     
%   Trim Audio Selection
%  	set(handles.audio3TrimStartText,'String',0);
%   set(handles.audio3TrimEndText,'String',floor(length(mixedAudio)/maxFs));
    set(handles.audio3TotalTimeText,'String',[num2str(floor(length(mixedAudio)/maxFs)) '(s)']);


%     
% hObject    handle to mixMixerBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in playMixerBtn.
function playMixerBtn_Callback(hObject, eventdata, handles)
global PLAYER3;
play(PLAYER3);
% hObject    handle to playMixerBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in stopMixerBtn.
function stopMixerBtn_Callback(hObject, eventdata, handles)
global PLAYER3;
stop(PLAYER3);
% hObject    handle to stopMixerBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pauseMixerBtn.
function pauseMixerBtn_Callback(hObject, eventdata, handles)
global PLAYER3;
pause(PLAYER3);
% hObject    handle to pauseMixerBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in resumeMixerBtn.
function resumeMixerBtn_Callback(hObject, eventdata, handles)
global PLAYER3;
resume(PLAYER3);
% hObject    handle to resumeMixerBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveMixerBtn.
function saveMixerBtn_Callback(hObject, eventdata, handles)
    [audio3,fs3]=getAudio('audio3');
    audiowrite(['Mixed_Audio_' num2str(floor(posixtime(datetime('now')))) '.wav'],audio3,fs3);
% hObject    handle to saveMixerBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function audio1TrimStartText_Callback(hObject, eventdata, handles)
    global AUDIO1TRIMSTARTLINE;
    [audio1,fs1] = getAudio('audio1');
    totalaudiosec=floor(length(audio1)/fs1);
    trimstart= myNumberCheck__(handles.audio1TrimStartText,totalaudiosec);
    trimend= get(handles.audio1TrimEndText,'String');

    % Setting the start and stop times;
    setAudioTrimTimes__(str2num(trimstart),str2num(trimend),'audio1');
    
    AUDIO1TRIMSTARTLINE.Value= str2num(trimstart);

    
% hObject    handle to audio1TrimStartText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of audio1TrimStartText as text
%        str2double(get(hObject,'String')) returns contents of audio1TrimStartText as a double



function audio1TrimEndText_Callback(hObject, eventdata, handles)
    global AUDIO1TRIMENDLINE;
    [audio1,fs1] = getAudio('audio1');
    totalaudiosec=floor(length(audio1)/fs1);
    trimend= myNumberCheck__(handles.audio1TrimEndText,totalaudiosec);
    trimstart= get(handles.audio1TrimStartText,'String');

%     Setting the start and stop times;
    setAudioTrimTimes__(str2num(trimstart),str2num(trimend),'audio1');

    AUDIO1TRIMENDLINE.Value= str2num(trimend);
   


function audio2TrimStartText_Callback(hObject, eventdata, handles)
    global AUDIO2TRIMSTARTLINE;
    [audio2,fs2] = getAudio('audio2');
    totalaudiosec=floor(length(audio2)/fs2);
    trimstart= myNumberCheck__(handles.audio2TrimStartText,totalaudiosec);
    trimend= get(handles.audio1TrimEndText,'String');

    % Setting the start and stop times;
    setAudioTrimTimes__(str2num(trimstart),str2num(trimend),'audio2');
    
    AUDIO2TRIMSTARTLINE.Value= str2num(trimstart);


function audio2TrimEndText_Callback(hObject, eventdata, handles)
    global AUDIO2TRIMENDLINE;
    [audio2,fs2] = getAudio('audio2');
    totalaudiosec=floor(length(audio2)/fs2);
    trimend= myNumberCheck__(handles.audio2TrimEndText,totalaudiosec);
    trimstart= get(handles.audio1TrimStartText,'String');

%     Setting the start and stop times;
    setAudioTrimTimes__(str2num(trimstart),str2num(trimend),'audio2');

    AUDIO2TRIMENDLINE.Value= str2num(trimend);

    
global AUDIO1RECORDER;  
% --- Executes on button press in audio1RecordStart.
function audio1RecordStart_Callback(hObject, eventdata, handles)
    global AUDIO1RECORDER;
    AUDIO1RECORDER = audiorecorder;
    record(AUDIO1RECORDER);
    
%     Disable button when recording in progress
    set(handles.importAudio1Btn,'Enable','off');
    set(handles.playAudio1Btn,'Enable','off');
    set(handles.pauseAudio1Btn,'Enable','off');
    set(handles.stopAudio1Btn,'Enable','off');
    set(handles.resumeAudio1Btn,'Enable','off');
    set(handles.audio1RecordStart,'Enable','off');
% hObject    handle to audio1RecordStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in audio1RecordStop.
function audio1RecordStop_Callback(hObject, eventdata, handles)
global AUDIO1RECORDER;
stop(AUDIO1RECORDER);
recordfs=get(AUDIO1RECORDER,'SampleRate');
recaudio=getaudiodata(AUDIO1RECORDER);
filename=['recording_' num2str(floor(posixtime(datetime('now')))) '.wav'];
audiowrite(filename,recaudio,recordfs);




%  Store audio globally
 setAudio(recaudio,recordfs,'audio1');
 [recaudio,recordfs] = getAudio('audio1');
 
   
%  Set audio1 player
    setAudioPlayer__(recaudio, recordfs,handles.audio1Status,'audio1');
    
%   Set Audio trim Lines
    setAudioTrimTimes__(1,floor(length(recaudio)/recordfs),'audio1');    
    
    [bol] = isAudiosImported__();
    if(bol)
      set(handles.mixMixerBtn,'Enable','on');
      set(handles.playMixerBtn,'Enable','on');
      set(handles.resumeMixerBtn,'Enable','on');
      set(handles.stopMixerBtn,'Enable','on');
      set(handles.pauseMixerBtn,'Enable','on');
      set(handles.saveMixerBtn,'Enable','on');
    end
 
    dt=1/recordfs;
    time=0:dt:(length(recaudio)*dt)-dt;
    % Plot Audio on axes
    plot(handles.audio1Axes,time,recaudio(:,1));
    
%     Settingplot line on axes
      setAudioPlotLines(0,floor(length(recaudio)/recordfs),0,handles.audio1Axes,'audio1');    
     
%   Trim Audio Selection
 	set(handles.audio1TrimStartText,'String',1);
    set(handles.audio1TrimEndText,'String',floor(length(recaudio)/recordfs));
    set(handles.audio1TotalTimeText,'String',[num2str(floor(length(recaudio)/recordfs)) '(s)']);
    
%     Enable all buttons
    set(handles.importAudio1Btn,'Enable','on');
    set(handles.playAudio1Btn,'Enable','on');
    set(handles.pauseAudio1Btn,'Enable','on');
    set(handles.stopAudio1Btn,'Enable','on');
    set(handles.resumeAudio1Btn,'Enable','on');
    set(handles.audio1RecordStart,'Enable','on');
    set(handles.audio1FilePathText,'String',filename);
    
    

    
    
    
    
% hObject    handle to audio1RecordStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in audio1RecordSave.
function audio1RecordSave_Callback(hObject, eventdata, handles)
% hObject    handle to audio1RecordSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
