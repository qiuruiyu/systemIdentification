%%% SM Method %%%
clear; clc;
n = 500;
u = rand(n, 1);
y0 = filter([1, 0.5], [1, -1.5, 0.7], u);
e = rand(n, 1);
% v1 -> white noise e
v1 = e / std(e) * std(y0) * sqrt(0.1); % 10% noise 
% v2 -> wide band colored noise 
v2 = filter(1, [1, -0.6], e);
v2 = v2 / std(v2) * std(y0) * sqrt(0.1); % 10% noise 
% v3 -> narrow band colored noise 
v3 = filter(1, [1, -0.9], e);
v3 = v3 / std(v3) * std(y0) * sqrt(0.1); % 10% noise 
y1 = y0 + v1;
y2 = y0 + v2;
y3 = y0 + v3;

y1f = y1;
y2f = y2;
y3f = y3;
uf1 = u;
uf2 = u;
uf3 = u;
iters = 20;
order = 5;

for k = 1:iters
    arxSys1 = arx([y1f, uf1], [order, order, 0]);
    arxSys2 = arx([y2f, uf2], [order, order, 0]);
    arxSys3 = arx([y3f, uf3], [order, order, 0]);
    % update sys1
    [Ap1, Bp1] = th2poly(arxSys1);
    Ap1 = fstab(Ap1);
    uf1 = filter(1, Ap1, u);
    y1f = filter(1, Ap1, y1);
    % update sys2
    [Ap2, Bp2] = th2poly(arxSys2);
    Ap2 = fstab(Ap2);
    uf2 = filter(1, Ap2, u);
    y2f = filter(1, Ap2, y2);
    % update sys3
    [Ap3, Bp3] = th2poly(arxSys3);
    Ap3 = fstab(Ap3);
    uf3 = filter(1, Ap3, u);
    y3f = filter(1, Ap3, y3);
end

% step impulse test 
yp = filter([1, 0.5], [1, -1.5, 0.7], ones(50, 1));
yp1 = lsim(arxSys1, ones(50, 1));
yp2 = lsim(arxSys2, ones(50, 1));
yp3 = lsim(arxSys3, ones(50, 1));

figure(1);
subplot(311);
plot(yp, 'b');
hold on;
plot(yp1, '--r');
legend("original data", "arx data");
title("10% white noise");
subplot(312);
plot(yp, 'b');
hold on;
plot(yp2, '--r');
title("10% wide band colored noise");
legend("original data", "arx data");
subplot(313);
plot(yp, 'b');
hold on;
plot(yp3, '--r');
legend("original data", "arx data");
title("10% narrow band colored noise");
