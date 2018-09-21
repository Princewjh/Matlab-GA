function [sys,x0,str,ts] = spacemodel(t,x,u,flag) 
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

x=u(1);dx=u(2);
y=u(3);dy=u(4);
z=u(5);dz=u(6);

dzd=0;ddzd=0;
ze=z-zd;
dze=dz-dzd;

s1=c1*x+dx;
s2=c2*y+dy;
s3=c3*ze+dze;

delta=0.10;
if abs(s1)>delta
   	sat_s1=sign(s1);
else
sat_s1=1/delta*s1;
end
if abs(s2)>delta
   	sat_s2=sign(s2);
else
sat_s2=1/delta*s2;
end
if abs(s3)>delta
   	sat_s3=sign(s3);
else
sat_s3=1/delta*s3;
end

u1x=m*(-c1*dx-eta1*sat_s1);%sign(s1)
u1y=m*(-c2*dy-eta2*sat_s2);%sign(s2)
u1z=m*(-c3*dze+g+ddzd-eta3*sat_s3);%sign(s3)

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

u1=u1z/(cos(phid)*cos(psid));
sys(1)=u1; 
sys(2)=thetad;
sys(3)=psid;