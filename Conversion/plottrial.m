function[fig]= plottrial(const,scr,gaze)
data=gaze;
samples=size(data);
Xval=zeros(1,samples(2));
Yval=zeros(1,samples(2));
for i=1:samples(2)
instance=data(i);
Xval(i)=instance.LeftEye.GazePoint.OnDisplayArea(1)*scr.scr_sizeX;
Yval(i)=scr.scr_sizeY-(instance.LeftEye.GazePoint.OnDisplayArea(2)*scr.scr_sizeY);
XvalR(i)=instance.RightEye.GazePoint.OnDisplayArea(1)*scr.scr_sizeX;
YvalR(i)=scr.scr_sizeY-(instance.RightEye.GazePoint.OnDisplayArea(2)*scr.scr_sizeY);
end
figure
fig=plot(Xval,Yval)
hold on
plot(XvalR,YvalR,'r')
axis([-10 scr.scr_sizeX+20 -10 scr.scr_sizeY+20],'fill')
rectangle('Position',[0 0 scr.scr_sizeX scr.scr_sizeY])
rectangle('Position',[const.stimrectl(1) const.stimrectl(2) const.stimrectl(3)-const.stimrectl(1) const.stimrectl(4)-const.stimrectl(2)]);
rectangle('Position',[const.stimrectr(1) const.stimrectr(2) const.stimrectr(3)-const.stimrectr(1) const.stimrectr(4)-const.stimrectr(2)]);
drawnow()

