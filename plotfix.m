struct=load('gtu.mat');
data=struct.config.gaze.collected_gaze_data(3).gaze
Xval=zeros(1,299);
Yval=zeros(1,299);
for i=1:299
instance=data(i);
Xval(i)=instance.LeftEye.GazePoint.OnDisplayArea(1);
Yval(i)=instance.LeftEye.GazePoint.OnDisplayArea(2);
end
plot(Xval,Yval)