%%% use output error criterion to get the corrent order of model %%% 
clear; clc;
n = 500;
u = rand(n, 1);
y0 = filter([1, 0.5], [1, -1.5, 0.7], u);
e = rand(n, 1);
v = filter(1, [1, -0.9], e);
v1 = v / std(v) * std(y0) * sqrt(0.01); % 1% noise 
y1 = y0 + v1;
v10 = v / std(v) * std(y0) * sqrt(0.1); % 10% noise 
y10 = y0 + v10;
v50 = v / std(v) * std(y0) * sqrt(0.5); % 50% noise 
y50 = y0 + v50;

for k = 1:8
    oe1 = oe([y1, u], [k, k, 0]);
    error1 = y1 - lsim(oe1, u);
    oe10 = oe([y10, u], [k, k, 0]);
    error10 = y10 - lsim(oe10, u);
    oe50 = oe([y50, u], [k, k, 0]);
    error50 = y50 - lsim(oe50, u);    
    v_est1(k) = cov(error1(1:n));
    v_est10(k) = cov(error10(1:n));
    v_est50(k) = cov(error50(1:n));
end

subplot(311);
plot(v_est1);
title("order evaluate with 1% noise");
subplot(312);
plot(v_est10);
title("order evaluate with 10% noise");
subplot(313);
plot(v_est50);
title("order evaluate with 50% noise");
