function [sys,x0,str,ts] = fuzz_rule(t,x,u,flag) 
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
function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;%���Ϊ3���л�����eta4��eta5,eta6; 
sizes.NumInputs      = 6;%����Ϊs4,s5,s6����Ӧ�ĵ���
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];

function sys=mdlOutputs(t,x,u)
warning off;
persistent a1
if t == 0
    a1 = readfis('fuzz_1');
end

sys(1) = evalfis([u(1),u(2)],a1); %���eta4
sys(2) = evalfis([u(3),u(4)],a1); %���eta5
sys(3) = evalfis([u(5),u(6)],a1); %���eta6