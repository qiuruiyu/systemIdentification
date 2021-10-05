%%% use different orders of FIR model to approximate the step impulse model %%%  
clear;clc;
u = 3 * rand(500, 1);
y0 = filter([1, 0.5], [1, -1.5, 0.7], u);
e = randn(500, 1);
v = filter(1, [1, -0.9], e);
v = v / std(v) * std(y0) * sqrt(0.05);
y = y0 + v;
fir4 = arx([y, u], [0, 4, 0]);
fir20 = arx([y, u], [0, 20, 0]);
y_pred4 = lsim(fir4, u);
y_pred20 = lsim(fir20, u);

% use step impulse to make final test 
% compare the 2 orders of FIR models 
n = 50;
stp0 = filter([1, 0.5], [1, -1.5, 0.7], ones(n, 1));
stp4 = lsim(fir4, ones(n, 1));
stp20 = lsim(fir20, ones(n, 1));
figure(1);
subplot(211);
plot(stp0, '-b');
hold on;
plot(stp4, '--r');
legend('origin data', '4th order FIR');
title("4th order");
subplot(212);
plot(stp0, '-b');
hold on;
plot(stp20, '--r');
legend('origin data', '20th order FIR');
title("20th order");
