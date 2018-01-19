
dir = (which('expLauncher'));cd(dir(1:end-18));

% Add paths
% ---------------
addpath('Config','Conversion','Data');
addpath(genpath('/Users/nickhedger/Downloads/TobiiPro.SDK.Matlab_1.2.1.54'))

const.desiredFD      = 60;                  % Desired refresh rate
const.desiredRes    = [1280,1024];          % Desired resolution
const.name=num2str(input('SubjectID?'));
[scr] = scrConfig(const);
[const] = constConfig(scr,const);

mkdir(strcat('Data/','Calibration'));
const.calibfilename=strcat('Data/','Calibration/',const.name,'.mat'); % Filename for gaze data file

[vadegx,vadegy]=vaDeg2pix(1,scr);
vadeg=(vadegx+vadegy)/2;


Screen('Preference', 'SkipSyncTests', 1); 



tobii = EyeTrackingOperations();
eyetrackers = tobii.find_all_eyetrackers();

if length(eyetrackers)==0
    eyetracker='no eyetracker';
else
    eyetracker=eyetrackers(1);
end
 
dotSizePix=30; 

if isa(eyetracker,'EyeTracker')
    disp(['Address:',eyetracker.Address]);
    disp(['Name:',eyetracker.Name]);
    disp(['Serial Number:',eyetracker.SerialNumber]);
     disp(['Model:',eyetracker.Model]);
    disp(['Firmware Version:',eyetracker.FirmwareVersion]);
else
        hj=input('No eyetracker detected. Continue to view calibration screen without recording gaze (1= yes, 0 = no)');
    if hj==0
        error('Re-connect the eyetraacker')
    else
    end
end

screens = Screen('Screens');


screenNumber = max(screens);


white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);


[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);


[screenXpixels, screenYpixels] = Screen('WindowSize', window);
screen_pixels = [screenXpixels screenYpixels];


[xCenter, yCenter] = RectCenter(windowRect);


Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');


if isa(eyetracker,'EyeTracker')
eyetracker.get_gaze_data();
else
end

Screen('TextSize', window, 20);

while ~KbCheck

    DrawFormattedText(window, 'When correctly positioned press any key to start the calibration.', 'center', screenYpixels * 0.1, white);

    distance = [];
    if isa(eyetracker,'EyeTracker')
    gaze_data = eyetracker.get_gaze_data();

    if ~isempty(gaze_data)
        last_gaze = gaze_data(end);

        validityColor = [255 0 0];

        % Check if user has both eyes inside a reasonable tacking area.
        if last_gaze.LeftEye.GazeOrigin.Validity && last_gaze.RightEye.GazeOrigin.Validity
            left_validity = all(last_gaze.LeftEye.GazeOrigin.InTrackBoxCoordinateSystem(1:2) < 0.85) ...
                                 && all(last_gaze.LeftEye.GazeOrigin.InTrackBoxCoordinateSystem(1:2) > 0.15);
            right_validity = all(last_gaze.RightEye.GazeOrigin.InTrackBoxCoordinateSystem(1:2) < 0.85) ...
                                 && all(last_gaze.RightEye.GazeOrigin.InTrackBoxCoordinateSystem(1:2) > 0.15);
            if left_validity && right_validity
                validityColor = [0 255 0];
            end
        end
    else
        
        validityColor = [0 0 255];
    end

        origin = [screenXpixels/4 screenYpixels/4];
        size = [screenXpixels/2 screenYpixels/2];
        
        %origin2 = [screenXpixels screenYpixels];
        size2 = [screenXpixels screenYpixels];
        
 


        Screen('FrameRect', window, validityColor, frame, penWidthPixels);
        
    if isa(eyetracker,'EyeTracker')
        % Left Eye
         if last_gaze.LeftEye.GazeOrigin.Validity
            distance = [distance; round(last_gaze.LeftEye.GazeOrigin.InUserCoordinateSystem(3)/10,1)];
            left_eye_pos_x = double(1-last_gaze.LeftEye.GazeOrigin.InTrackBoxCoordinateSystem(1))*size(1) + origin(1);
            left_eye_pos_y = double(last_gaze.LeftEye.GazeOrigin.InTrackBoxCoordinateSystem(2))*size(2) + origin(2);
            left_eye_pos_x2 = double(last_gaze.LeftEye.GazePoint.OnDisplayArea(1))*size2(1);
            left_eye_pos_y2 = double(last_gaze.LeftEye.GazePoint.OnDisplayArea(2))*size2(2);
            right_eye_pos_x2 = double(last_gaze.RightEye.GazePoint.OnDisplayArea(1))*size2(1);
            right_eye_pos_y2 = double(last_gaze.RightEye.GazePoint.OnDisplayArea(2))*size2(2);
            
            Screen('DrawDots', window, [left_eye_pos_x left_eye_pos_y], dotSizePix, validityColor, [], 2);
            Screen('DrawDots', window, [left_eye_pos_x2 left_eye_pos_y2], dotSizePix, validityColor, [], 2);
        end

        % Right Eye
        if last_gaze.RightEye.GazeOrigin.Validity
            distance = [distance;round(last_gaze.RightEye.GazeOrigin.InUserCoordinateSystem(3)/10,1)];
            right_eye_pos_x = double(1-last_gaze.RightEye.GazeOrigin.InTrackBoxCoordinateSystem(1))*size(1) + origin(1);
            right_eye_pos_y = double(last_gaze.RightEye.GazeOrigin.InTrackBoxCoordinateSystem(2))*size(2) + origin(2);
            Screen('DrawDots', window, [right_eye_pos_x right_eye_pos_y], dotSizePix, validityColor, [], 2);
        end
        pause(0.01);
    end

    DrawFormattedText(window, sprintf('Current distance to the eye tracker: %.2f cm.',mean(distance)), 'center', screenYpixels * 0.85, white);
    end

    % Flip to the screen. This command basically draws all of our previous
    % commands onto the screen.
    % For help see: Screen Flip?
    penWidthPixels = 3;
    baseRect = [0 0 size(1) size(2)];
    frame = CenterRectOnPointd(baseRect, screenXpixels/2, yCenter);
    Screen('DrawLine', window, [0 0 255], screenXpixels/2, screenYpixels, screenXpixels/2, 0,[2]);
    Screen('DrawLine', window, [0 0 255], 0, screenYpixels/2, screenXpixels, screenYpixels/2,[2]);
    Screen('Flip', window);

end



if isa(eyetracker,'EyeTracker')
    eyetracker.stop_gaze_data();
end

spaceKey = KbName('Space');
RKey = KbName('R');

dotSizePix = 30;

dotColor = [[255 0 0];[255 255 255]]; % Red and white

leftColor = [255 0 0]; % Red
rightColor = [0 0 255]; % Bluesss

% Calibration points
%lb = 0.1;  % left bound
%xc = 0.5;  % horizontal center
%rb = 0.9;  % right bound
%ub = 0.1;  % upper bound
%yc = 0.5;  % vertical center
%bb = 0.9;  % bottom bound
rect1a=[303/1280, (424/1080)];
rect1b=[542/1280, (601/1080)];
rect1c=[303/1280, (601/1080)];
rect1d=[542/1280, (424/1080)];

rect2a=[739/1280, (424/1080)];
rect2b=[978/1280, (601/1080)];
rect2c=[739/1280, (601/1080)];
rect2d=[978/1280, (424/1080)];
fix=[0.5, 0.5];
 
 
 points_to_calibrate = [rect1a;rect1b;rect1c;rect1d;rect2a;rect2b;rect2c;rect2d;fix];

% Create calibration object
if isa(eyetracker,'EyeTracker')
calib = ScreenBasedCalibration(eyetracker);
end
calibrating = true;


while calibrating
    % Enter calibration mode
    if isa(eyetracker,'EyeTracker')
    calib.enter_calibration_mode();
    end
    
    for i=1:length(points_to_calibrate)

        Screen('DrawDots', window, points_to_calibrate(i,:).*screen_pixels, dotSizePix, dotColor(1,:), [], 2);
        Screen('DrawDots', window, points_to_calibrate(i,:).*screen_pixels, dotSizePix*0.5, dotColor(2,:), [], 2);

        Screen('Flip', window);

        % Wait a moment to allow the user to focus on the point
        pause(2);

        if isa(eyetracker,'EyeTracker')
        if calib.collect_data(points_to_calibrate(i,:)) ~= CalibrationStatus.Success
            % Try again if it didn't go well the first time.
            % Not all eye tracker models will fail at this point, but instead fail on ComputeAndApply.
            calib.collect_data(points_to_calibrate(i,:));
        end
        end

    end

    DrawFormattedText(window, 'Calculating calibration result....', 'center', 'center', white);

    Screen('Flip', window);

    % Blocking call that returns the calibration result
    if isa(eyetracker,'EyeTracker')
    calibration_result = calib.compute_and_apply();

    calib.leave_calibration_mode();

    if calibration_result.Status ~= CalibrationStatus.Success
        break
    end
    

    % Calibration Result

    points = calibration_result.CalibrationPoints;
    end
    
    for i=1:length(points)
        Screen('DrawDots', window, points_to_calibrate(i,:).*screen_pixels, vadeg*2, dotColor(2,:)/8, [], 2);
        Screen('DrawDots', window, points_to_calibrate(i,:).*screen_pixels, vadeg, dotColor(2,:)/4, [], 2);
        Screen('DrawDots', window, points_to_calibrate(i,:).*screen_pixels, dotSizePix*0.5, dotColor(2,:), [], 2);
    
        
        if isa(eyetracker,'EyeTracker')
        for j=1:length(points(i).RightEye)
            if points(i).LeftEye(j).Validity == CalibrationEyeValidity.ValidAndUsed
                Screen('DrawDots', window, points(i).LeftEye(j).PositionOnDisplayArea.*screen_pixels, dotSizePix*0.3, leftColor, [], 2);
                
            end
            if points(i).RightEye(j).Validity == CalibrationEyeValidity.ValidAndUsed
                Screen('DrawDots', window, points(i).RightEye(j).PositionOnDisplayArea.*screen_pixels, dotSizePix*0.3, rightColor, [], 2);
            end
        end
        end

    end

    DrawFormattedText(window, 'Press the ''R'' key to recalibrate or ''Space'' to continue....', 'center', screenYpixels * 0.95, white)

    Screen('Flip', window);
    imageArray = Screen('GetImage', window, [windowRect]);

    while 1.
        [ keyIsDown, seconds, keyCode ] = KbCheck;
        keyCode = find(keyCode, 1);

        if keyIsDown
            if keyCode == spaceKey
                calibrating = false;
                sca
                if isa(eyetracker,'EyeTracker')
                calibfile.calibration=calibration_result;
                end
                calibfile.image=imageArray;
                save(strcat(const.calibfilename),'calibfile')
                break;
                sca
            elseif keyCode == RKey
                break;
            end
            KbReleaseWait;
        end
    end
end

