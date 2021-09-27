clear;
clc;

%% Generate uniformly distributed whiteNoise (mean=0, var=1)
noise1 = rand(20000, 1);
noise1 = (noise1 - mean(noise1)) / std(noise1);
disp("Noise1   mean: " + mean(noise1) + "  std: " + std(noise1));
x1 = xcorr(noise1);
figure();
plot(x1);
title("white noise of uniform distribution");

%% Generate Gaussian distributed whiteNoise (mean=0, var=1)
noise2 = randn(20000, 1);
disp("Noise2   mean: " + mean(noise2) + "  std: " + std(noise2));
x2 = xcorr(noise2);
figure();
plot(x2);
title("white noise of normalized distribution");


y2 = filter(0.1, [1 -0.95], noise2);
figure();
plot(noise2, 'r');
hol
plot(y2, 'b');

%% colored noise sequence 
[A, B, C, D] = tf2ss([0.1], [1 -0.95]);
e = noise2;
n = length(e);
xt = 0;
v =0;
for i = 1 : n
    xt1 = A * xt(end) + B * e(i);
    vt = C * xt(end) + D * e(i);
    xt = [xt xt1];
    v = [v vt];
end

figure();
plot(v);
title("Time Series Value of colored noise using white noise");

% power spectra analysis 
fs = 1000;
y = fft(v);
f = (0:n-1) * fs / n;
power = abs(y).^2 / n; 

figure();
plot(f(1:n/2), power(1:n/2));
title("Power Spectra of colored noise using white noise");