clear;clc;

% coefficent of FIR filter 
cof = [0 1 3 7 6 5 4 3 2 1];
% random input 
u = rand(300, 1);

y1 = [];
for i = 10:length(u)
    o = cof * flipud(u(i-9:i));
    y1 = [y1 o];
end


% Using state space to calculate the output 
[A, B, C, D] = tf2ss(cof, [1, zeros(1, 9)]);

x0 = zeros(9, 1);
x = [x0];
y2 = [];
for i = 10:length(u)
    xt = x(:, end);
    ut = u(i);
    xt1 = A * xt + B * ut;
    x = [x xt1];
    o = C * xt + D * ut;
    y2 = [y2 o];
end

% or you can simply use 2 lines below to calculate the output
% y1 = lsim(tf(cof,1,1,'variable','z^-1'),u(10:end));
% y2 = lsim(ss(A,B,C,D,1),u(10:end));

figure();
plot(y1, 'r');
hold on;
plot(y2, 'b');
title("outputs of FIR model using 2 calculations");

