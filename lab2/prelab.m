%% define constants
Ka = 0.887;
Kt = 0.72;
Je = 7*10^(-4);
Be = 0.00612;
Ke = 20/(2*pi);
T = 0.0002;

%% question1
s = tf("s");
continousPlant = Ka*Kt*(1/(Je*s+Be))*Ke/s;

b = [2904.286];
a = [1, 8.743,0,0];
[r,p,k] = residue(b,a);

partial_fraction = r(1)/(s-p(1)) + r(2)/(s-p(2)) + r(3)/(s-p(3))^2

discretePlant = c2d(continousPlant,T);

%% question2

numerator = cell2mat(discretePlant.Numerator);
denominator = cell2mat(discretePlant.Denominator);
[A,B,C,D] = tf2ss(numerator,denominator);

stateSpacePlant = ss(A,B,C,D,T);

%% question3

%a
rlocus(continousPlant)
rlocus(discretePlant)

%b
margin(continousPlant)
margin(discretePlant)

%c
hold on
margin(c2d(continousPlant,0.02))
margin(c2d(continousPlant,0.002))
margin(c2d(continousPlant,0.0002))

%% question4
wout = linspace(-0.00001,1000,100000);
[mag,phase,wout] = bode(discretePlant,wout);


eps = 0.01;
mag = squeeze(mag);
phase = squeeze(phase);
wout = squeeze(wout);

W_60_indexes = find((wout-60).^2<eps);
W_60_index = W_60_indexes(1);

Kp = 1/mag(W_60_index);

%pick R4 = 3.9e+04 ohms

%% Question 5

wc_desired = 60*2*pi;

%choose maxPhaseChange = 61 degrees
desiredPhaseChangeRad = 61/180*pi;
alpha = (-1-sin(desiredPhaseChangeRad))/(sin(desiredPhaseChangeRad)-1)
tao = (1/wc_desired)/sqrt(alpha)

compensator = (alpha*tao*s+1)/(tao*s+1)
[Gm,Pm,Wcg,Wcp] = margin(c2d(Cs,T)*discretePlant);

Cs = compensator/abs(freqresp(c2d(compensator,T)*discretePlant,wc_desired));
[Gm,Pm,Wcg,Wcp] = margin(c2d(Cs,T)*discretePlant);

