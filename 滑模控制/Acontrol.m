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
sizes.NumInputs      = 14;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [0 0];
function sys=mdlOutputs(t,x,u)
Init;

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

thetae=theta-thetad;dthetae=dtheta-dthetad;
s4=c4*thetae+dthetae;

psie=psi-psid;dpsie=dpsi-dpsid;
s5=c5*psie+dpsie;

phie=phi-phid;dphie=dphi-dphid;
s6=c6*phie+dphie;

delta=0.10;
if abs(s4)>delta
   	sat_s4=sign(s4);
else
sat_s4=1/delta*s4;
end
if abs(s5)>delta
   	sat_s5=sign(s5);
else
sat_s5=1/delta*s6;
end
if abs(s6)>delta
   	sat_s6=sign(s6);
else
sat_s6=1/delta*s6;
end

u2=-c4*dthetae+ddthetad-eta4*sign(s4);
u3=-c5*dpsie+ddpsid-eta5*sign(s5);
u4=-c6*dphie+ddphid-eta6*sign(s6);

sys(1)=u2;
sys(2)=u3;
sys(3)=u4;