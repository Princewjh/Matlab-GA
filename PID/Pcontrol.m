function [sys,x0,str,ts] = spacemodel(t,x,u,flag) 
global xek yek zek

switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
global xek yek zek
xek = 0;
yek = 0;
zek = 0;
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 6;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  =[];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
Init;
global xek yek zek
x=u(1);dx=u(2);
y=u(3);dy=u(4);
z=u(5);dz=u(6);

xe = x - xd;
ye = y - yd;
ze = z - zd;
%上一次误差




u1x= -kp1 * (xe)  + ki1 * (xek);
u1y= -kp2 * (ye)  + ki2 * (yek);
u1z= -kp3 * (ze)   + ki3 * (zek);

X=(cos(phid)*cos(phid)*u1x+cos(phid)*sin(phid)*u1y)/u1z;
%保证角度存在
if X>1 
    sin_thetad=1;
    thetad=pi/2;
elseif X<-1
    sin_thetad=-1;
    thetad=-pi/2;
else
    sin_thetad=X;
    thetad=asin(X);
end
psid=atan((sin(phid)*cos(phid)*u1x-cos(phid)*cos(phid)*u1y)/u1z);
xek = xek + xe;
yek = yek + ye;
zek = zek + ze;
u1=u1z/(cos(phid)*cos(psid));
sys(1)=u1; 
sys(2)=thetad;
sys(3)=psid;