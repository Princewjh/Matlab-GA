clear all;
close all;
ts = 1e-4;
In = 5;
Kp = 60;
Ki = 1;
Kd = 3;
simOut = sim('demo1');
for k = 1:1:length(out)
    time(k) = k * ts;
end
figure(1);plot(time,out);grid on;