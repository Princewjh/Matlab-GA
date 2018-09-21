angle1 = 0*t./t;
figure(1);
plot(t,angle1, 'r--',t,x(:,7)/pi*180,'k','linewidth',2);
legend('\phi_d (degree)','\phi (degree)');
xlabel('time(s)')
figure(2);
plot(t,angle1, 'r--',t,x(:,9)/pi*180,'k','linewidth',2);
legend('\theta_d (degree)','\theta (degree)');
xlabel('time(s)')
figure(3);
plot(t,60 * t./t, 'r--',t,x(:,11)/pi*180,'k','linewidth',2);
legend('\psi_d (degree)','\psi (degree)');
xlabel('time(s)')