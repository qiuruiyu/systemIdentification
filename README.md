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


### stepFIR
- test the approximaton of different orders of FIR model using step impulse
- use **arx([y, u], [nb, na, nk])** to obtain the approximated system model 
- use **lsim(sys, u)** to estimate the output (y) of the system with input u 

### oeOrderSelect
- use output error critertion to get the correct order
- different level of noise will make great difference to the order choice performance 
- use **cov(error)** to calculate the ouput error 


### SMMethod
- Steiglitz and McBride (1965) Method is simple algorithm for minimizing the output error loss function 
- it can be proved that the algorithm is converged with **white noise** 
- the .m file contains 3 kinds of noise 
	- white noise 
	- wide band colored noise 
	- narrow band colored noise 
- it is obvious that when noise level is low, the approximation is quite good, but when the noise level is high, the approximation of ARX could be low efficiency and cannot converged sometimes