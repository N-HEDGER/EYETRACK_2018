struct=load('billboy_trial1_gaze.mat');
data=struct.collected_gaze_data
Xval=zeros(1,299);
Yval=zeros(1,299);
for i=1:299
instance=data(i);
Xval(i)=instance.LeftEye.GazePoint.OnDisplayArea(1)*config.scr.;
Yval(i)=instance.LeftEye.GazePoint.OnDisplayArea(2)*1080;
end
plot(Xval,Yval)
axis([-10 1930 -10 1090],'fill')
rectangle('Position',[0 0 1920 1080])
rectangle('Position',[hj.stimrectl(1) hj.stimrectl(2) hj.stimrectl(3)-hj.stimrectl(1) hj.stimrectl(4)-hj.stimrectl(2)])
rectangle('Position',[hj.stimrectr(1) hj.stimrectr(2) hj.stimrectr(3)-hj.stimrectr(1) hj.stimrectr(4)-hj.stimrectr(2)])





