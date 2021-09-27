# System Identification
This is a exercise repository for system identification, including various kinds of basic matlab codes


### FIR_model 
- given a FIR model coefficient, and a sequence of random inpu($u(t)$), get the output of the filter
- way1: use the function of discrete convolution (FIR definition)
- way2: get state space function ($A\quad B\quad C\quad D$) and get $y$ iteratively ($x(0)=0$)


### whiteNoise
- generate whiteNoise with rand / randn / gwn in MATLAB
- xcorr(x) of whiteNoise get the Dirichlet function 
- using fourier transfermation to calculate the power spectra of whiteNoise
- using whiteNoise $e(t)$ to get a colored noise with a transfer function($G$) (which means a low/range/high filter, etc.) 
