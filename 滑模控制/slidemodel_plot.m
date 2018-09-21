close all;
figure(1);
subplot(311);
plot(t,x(:,1),'b','linewidth',2);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
xlabel('Time(s)');ylabel('x(m)');
legend('x');
subplot(312);
plot(t,x(:,3),'b','linewidth',2);
xlabel('Time(s)');ylabel('y(m)');
legend('y');
subplot(313);
zd=3*t./t;
plot(t,zd,'r--',t,x(:,5),'b','linewidth',2);
xlabel('Time(s)');ylabel('z(m)');
legend('zd','z');


angle1 = 0*t./t;
figure(2);
plot(t,angle1, 'r--',t,x(:,7)/pi*180,'k','linewidth',2);
legend('\phi_d (degree)','\phi (degree)');
xlabel('time(s)')
figure(3);
plot(t,angle1, 'r--',t,x(:,9)/pi*180,'k','linewidth',2);
legend('\theta_d (degree)','\theta (degree)');
xlabel('time(s)')
figure(4);
plot(t,60 * t./t, 'r--',t,x(:,11)/pi*180,'k','linewidth',2);
legend('\psi_d (degree)','\psi (degree)');
xlabel('time(s)')