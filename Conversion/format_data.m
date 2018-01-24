% This script takes a subject directory output by the experiment and 
% reformats it so it is ready for R.

addpath(genpath('/Users/nickhedger/Downloads/TobiiPro.SDK.Matlab_1.2.1.54'))
directory = (which('rescale'));cd(directory(1:end-20));

% Add paths
% ---------------
addpath('Data');
cd ('Data')

% Prompt user for subject directory
folder = uigetdir();


% Gaze directory
gaze_dir=strcat(folder,'/gaze');

% Const directory
const_dir=strcat(folder,'/const');

% Get all the gaze.mat files
filelist = dir([gaze_dir filesep '**_gaze.mat']);
files = {filelist.name}';

% Get all the const.mat files
filelistconst = dir([const_dir filesep '**.mat']);
filesconst = {filelistconst.name}';

% From the config file, get the events for each trial.
trialinfo=load(strcat(const_dir,'/',filesconst{1}));
events=trialinfo.config.Trialevents.trialmat;



% By default, the trials will be ordered in an odd way (my fault), so
% extract the trial numbers from the filename.
B = regexp(files,'\d*','Match');
for ii= 1:length(B)
  if ~isempty(B{ii})
      Num(ii,1)=str2double(B{ii}(end));
  else
      Num(ii,1)=NaN;
  end
end

% Now use this to reorder the way files are read in.
trial=cell(1,length(files));
for i=1:length(Num)
    trial{Num(i)}=load(strcat(gaze_dir,'/',files{i}));
end


% Create cells for all the variables we want to record.
times=cell(1,length(trial));
leftfixX=cell(1,length(trial));
leftfixY=cell(1,length(trial));
rightfixX=cell(1,length(trial));
rightfixY=cell(1,length(trial));
sidevec=cell(1,length(trial));
scvec=cell(1,length(trial));
modvec=cell(1,length(trial));
trialnum=cell(1,length(trial));

for i=1:length(trial)
    % The total number of timestamps
    stamps=max(size(trial{i}.collected_gaze_data));
    % The trial number is a repetition of i.
    trialnum{i}=repmat(i,1,stamps);
    % Side of social stimulus
    sidevec{i}=repmat(events(i,2),1,stamps);
    % Scrambled or unscrambled
    scvec{i}=repmat(events(i,3),1,stamps);
    % The model
    modvec{i}=repmat(events(i,5),1,stamps);
    
    for j=1:stamps
        %For each timestamp add the corresponding fixation coordinates
        times{i}(j)=double((trial{i}.collected_gaze_data(j).DeviceTimeStamp-trial{i}.collected_gaze_data(1).DeviceTimeStamp)/1000);
        leftfixX{i}(j)=double(trial{i}.collected_gaze_data(j).LeftEye.GazePoint.OnDisplayArea(1));
        
        % Y coordinate is inverted.-
        leftfixY{i}(j)=1-double(trial{i}.collected_gaze_data(j).LeftEye.GazePoint.OnDisplayArea(2));
        rightfixX{i}(j)=double(trial{i}.collected_gaze_data(j).RightEye.GazePoint.OnDisplayArea(1));
        rightfixY{i}(j)=1-double(trial{i}.collected_gaze_data(j).RightEye.GazePoint.OnDisplayArea(2));
    end
    
end


% Flatten to matrix.
result=horzcat(cell2mat(trialnum)',cell2mat(times)',cell2mat(leftfixX)',cell2mat(leftfixY)',cell2mat(sidevec)',cell2mat(scvec)',cell2mat(modvec)');

% Write the text file
dlmwrite(strcat(folder,'/',trialinfo.config.const.sbj.subname{1},'_summary.txt'),result)
