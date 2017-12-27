 %Time-based PM task
%created by Francesco Pupillo
%16-Oct-2017

function [TBPMscore]= TBPM()
try
   
%cd 'C:/Users/Francesco/OneDrive - University of Aberdeen/prospective memory/LDT' 
rect=Screen('Rect', 0) ; % returns an array with the top left corner and the bottom right corner coordinates of the screen
%for testing
%[MyScreen, rect] = Screen('OpenWindow', 0, [0, 0, 0], rect/4 ); %select the screen and the color (black)
[MyScreen, rect] = Screen('OpenWindow', 0, [0, 0, 0], rect); %select the screen and the color (black)

slack=Screen('GetFlipInterval', MyScreen) /2  ; %the flip interval
fps=Screen('NominalFrameRate', MyScreen); %screen per second
%get the code for the space bar and for the other keys
space=KbName('space'); 
c=KbName('c');
m=KbName('m');
y=KbName('y');
n=KbName('n');
%set the stimulus duration as a function of frame per seconds
stimDuration=round(0.5 *fps); %in fps 
%set the duration for the fixation cross
crossDuration=round(0.725*fps); %in fps
h=0; %counter
j=0; %counter
k=0; %counter
z=0;  %counter for PM time
v=0;%counter for the space bar
x=0; %counter for the y
w=0; % counter to avoid space bar to be pressed continuously
s=stimDuration; %counter to avoid repeated presses of yes and no keys
%retrieve the file with the words 
[Prwords,Prnonwords]=textread('TBPMlist4.csv', '%s%s', 'delimiter', ',');
wholepracticewords=[Prwords;Prnonwords]; %after the 42th there are only spaces
%randomise the words
practiceWorder=wholepracticewords(randperm(length(wholepracticewords)));
%create dummy coding for the length of the presentation of the stimulus(1)
%and for the fixation cross
trials=length(wholepracticewords);
rt=zeros(1,max(trials));
score=zeros(1,max(trials));
barPressed=0; %empty variable for space pressed
PMtime=0; %setting the PM time variable
a=[repelem(1,stimDuration),repelem(2,crossDuration)];% 40=stimulut presentation; 20= cross presentation
b=repmat(a, 1,trials); %length task=trials
%defining the screen size and instructions
    DrawFormattedText(MyScreen,'In this task you will still be working on the lexical task as the previous one.\n\n\n\n\n Thus, you will see a series of letters appear on the screen\n\nyour task is to press the "YES" button if the letters you see \n\n make up a word and press the "NO" button if this is not the case.','center', rect(3)/6 , [255 255 255]);
    DrawFormattedText(MyScreen,'Please press any key to continue','center', rect(3)/2, [255 255 255]);
    Screen('Flip', MyScreen);
    HideCursor()
    KbWait;
    WaitSecs(1);
    DrawFormattedText(MyScreen,'Next time that you are working on this task,\n\n Please remember to additionally press the "Y" button every time a minute has elapsed.','center', rect(3)/8  , [255 255 255]);
    DrawFormattedText(MyScreen,'A clock can be shown on the screen for a short time by pressing the ‘SPACE BAR’.\n\n Even if you missed a minute interval, you can still press the “Y’ to get the closest time to the minute','center', rect(3)/4.5  , [255 255 255]);
    DrawFormattedText(MyScreen,'Please approach the experimenter and repeat task instructions\n\n in your own words.','center', rect(3)/3 , [255 255 255]);
    DrawFormattedText(MyScreen,'Please press any key to continue','center', rect(3)/2, [255 255 255]);
    Screen('Flip', MyScreen);  
    KbWait;
    WaitSecs(1);
    Screen('FillRect',MyScreen, [0,0,0], rect);
    Screen('Flip', MyScreen); 
    KbWait;
    WaitSecs(0.5)
    DrawFormattedText(MyScreen,'Please place your right index finger on the "YES" button\n\n and your left index finger on the "NO" button.\n\n ','center', rect(3)/6 , [255 255 255]);
    DrawFormattedText(MyScreen,'Please always try to work as accurately and as quickly as possible','center', rect(3)/3 , [255 255 255]);
    DrawFormattedText(MyScreen,'Press any key to start the task','center', rect(3)/2 , [255 255 255]);
    Screen('Flip', MyScreen);
    KbWait;
    WaitSecs(1);
     DrawFormattedText(MyScreen,'Ready...','center', 'center', [255 255 255]);
     Screen('Flip', MyScreen);
     WaitSecs(2);
     DrawFormattedText(MyScreen,'Go! ','center', 'center', [255 255 255]);
     Screen('Flip', MyScreen);
     WaitSecs(2);
     HideCursor() %hide the cursor
 

%while t1<10 %this could also be eliminated
[KeyIsDown, secs, keyCode]=KbCheck; %start checking for the any key pressed


%set the time when the task start
t0=GetSecs;
%set a counter as a difference from the moment the task starts
t1=GetSecs-t0;
t1=round(t1); 
%set a counter for the first word
trial=1;
i=1.1; %starting counter for the words
space=KbName('space');

 for e=1:length( b) %for the lenght of the variable we have set, which is equal to the length of the words
     %while NO==0 
     
     if b(e)==1 %for the stimulus 
            b;
             trial= fix(i);%the trial equals the counter wihout the dot
    
[KeyIsDown, secs, keyCode]=KbCheck;

t1=GetSecs-t0;
t1=round(t1);
 
%select the word
 wordselected=char(practiceWorder (trial));
 textsize=48;  
 Screen('TextSize', MyScreen, textsize) ; %set the text size
 Screen('TextFont', MyScreen, 'Arial'); %set the font
 DrawFormattedText(MyScreen,wordselected,'center', rect(4)/2+textsize/2 , [255 255 255]); %draw text
 k=k+1;
 else if b(e)==2 %for the cross
            b;
            [KeyIsDown, secs, keyCode]=KbCheck;

t1=GetSecs-t0;
t1=round(t1);

 a=11; %length of the cross
  Screen('DrawLine', MyScreen, [255,255,255],rect(3)/2, rect(4)/2-a,rect(3)/2,rect(4)/2+a);
  Screen('DrawLine', MyScreen, [255,255,255],rect(3)/2-a,rect(4)/2, rect(3)/2+a,rect(4)/2);  
 i=1/crossDuration+i; %counter for let matlab know which word to select
 k=k+1;
 if k==stimDuration+crossDuration
     k=0;
 end
      end
        end
     if KeyIsDown || j>0 %if the key is pressed or j is more than 0
     if  keyCode(space) || j>0 %if the key is space
     j=1+j; %j becomes 1
     t3=GetSecs; %get the seconds from when the key is pressed
     t4=GetSecs-t3;
      t1=GetSecs-t0; %the seconds from when the task has started
      t1=round(t1);
      t9=GetSecs-t0;

 [KeyIsDown, secs, keyCode]=KbCheck; 
 %the following algorithm is to display the time correctly
if t1<=59
    if t1<10
    minuteSelect=num2str(t1);
time=['00', ':', '00', ':','0', minuteSelect];
else if t1>=10
        minuteSelect=[num2str(t1)];
time=['00', ':', '00', ':', minuteSelect];
    end
    end
else if t1>=60 && t1<120
        t2=t1-60;
        if t2<10
    minuteSelect=num2str(t2);
time=['00', ':', '00', ':','0', minuteSelect];
else if t2>=10
        minuteSelect=[num2str(t2)];
time=['00', ':', '00', ':', minuteSelect];
    end
        end
  else if t1>=120 && t1<180
        t3=t1-120;
        if t3<10
  minuteSelect=num2str(t3);
time=['00', ':', '00', ':','0', minuteSelect];
else if t3>=10
        minuteSelect=[num2str(t3)];
time=['00', ':', '00', ':', minuteSelect];
    end
        end
        
    else if t1>=180 && t1<240
        t4=t1-180;
        if t4<10
    minuteSelect=num2str(t4);
time=['00', ':', '00', ':','0', minuteSelect];
else if t4>=10
        minuteSelect=[num2str(t4)];
time=['00', ':', '00', ':', minuteSelect];
    end
        end
     else if t1>=240
        t5=t1-240;
        if t5<10
    minuteSelect=num2str(t5);
time=['00', ':', '00', ':','0', minuteSelect];
else if t5>=10
        minuteSelect=[num2str(t5)];
time=['00', ':', '00', ':', minuteSelect];
    end
        end
    end
        end
    end
    end
end
        
t1=round(t1);
DrawFormattedText(MyScreen,time,'center', rect(3)/2 , [255 255 255]);  %draw the time
j=round(1/(fps*2)+j); %get the time passed as a function of frames   
     if j==fps*2 %when the frames equals three seconds (fps times 2), j is 0 again and the clock stops 
         j=0;
     end
     if keyCode(space)&&  w> 35 %counter to avoid continuous presses
     v=v+1;%counter
     barPressed(v)=t9; %time for the bar presses
     w=0; %this is to avoid registering continuous presses of the space bar     
     end
     end 
     end
if KeyIsDown %if the key 
    if (keyCode(c) && ~isempty(strmatch(practiceWorder(trial), Prnonwords))) && s>stimDuration
            score(trial)=1 ; %if participant press the no button for non words
            rt(trial)=k/fps ;
            s=0;
    elseif (keyCode(c) && isempty(strmatch(practiceWorder(trial), Prnonwords))) && s>stimDuration
                 score(trial)=0; %%if participant press the no button for words
                             rt(trial)=k/fps; 
                             s=0;
         end 
            if (keyCode(m) && ~isempty(strmatch(practiceWorder(trial), Prwords))) && s>stimDuration 
            score(trial)=1;  %%if participant press the yes button for words
            rt(trial)=k/fps;
            s=0;
            elseif (keyCode(m) && isempty(strmatch(practiceWorder(trial), Prwords))) && s>stimDuration
                 score(trial)=0 ; %%if participant press the yes button for nonwords
                 rt(trial)=k/fps;
                 s=0;
            end
            if keyCode(y) && x>35
                t8=GetSecs-t0;
                 z=z+1;
                PMtime(z)=t8 ;
                x=0; %this is to avoid registering continuous presses of y
            end
end
x=x+1;
w=w+1; 
s=s+1;
     
                 %now it is time to flip everything is on the screen                   
 Screen('Flip', MyScreen);
 end
   WaitSecs(1);
   scorePR=['Your score is ',num2str((sum(score)/trial)*100),' %'];
   Screen('TextSize', MyScreen, 27  )
   DrawFormattedText(MyScreen,'Thank you for completing the task!','center', rect(3)/4   , [255 255 255]);
   DrawFormattedText(MyScreen,'Please approach the experimenter before continuing','center', rect(3)/2 , [255 255 255]);
   DrawFormattedText(MyScreen,'Press the SPACE BAR when you are ready to continue','center', rect(3)/1.5 , [255 255 255]);
   Screen('Flip', MyScreen);
   WaitSecs(1);
   KbWait();
   %wait for response to continue
 

  TBPMscore.scoreLDT=score;
  TBPMscore.LDTrt=rt;
  TBPMscore.PM=PMtime;
  TBPMscore.barPressed=barPressed;
  
 Screen('CloseAll')

 
 catch
 Screen('CloseAll')
 rethrow(lasterror)
end
end
 




