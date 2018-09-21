function [sys,x0,str,ts] = spacemodel(t,x,u,flag) 
global MyPID_Step
global thetaek psiek phiek
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
global MyPID_Step
global thetaek psiek phiek
MyPID_Step = 0;
thetaek = 0;
psiek = 0;
phiek = 0;
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 14;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
Init;
global MyPID_Step
global thetaek psiek phiek


dphid=0;ddphid=0;
thetad=u(1);
psid=u(2);
dthetad=u(4);
ddthetad=u(5);
dpsid=u(7);
ddpsid=u(8);

theta=u(9);dtheta=u(10);
psi=u(11);dpsi=u(12);
phi=u(13);dphi=u(14);
MyPID_Step = MyPID_Step + 1;
   
thetae=theta-thetad;%当前误差
psie=psi-psid;%当前误差
phie=phi-phid;%当前误差




u2= -kp4 * (thetae) +ki4 * (thetaek);
u3= -kp5 * (psie) + ki5 * (psiek);
u4= -kp6 * (phie) + ki6 * (phiek);

%参数更新
thetaek = thetaek + thetae;
psiek = psiek + psie;
phiek = phiek + phie;

sys(1)=u2;
sys(2)=u3;
sys(3)=u4;