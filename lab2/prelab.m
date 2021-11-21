%% define constants
Ka = 0.887;
Kt = 0.72;
Je = 7*10^(-4);
Be = 0.00612;
Ke = 20/(2*pi);
T = 0.0002;
mu = 0.3;
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

[yd,tOutd] = step(discretePlant);
[yss,tOutss]=step(stateSpacePlant,'*');
plot(tOutd,yd,'*','MarkerIndices',1:5000:length(yd))
hold on
plot(tOutss,yss)
legend("discretePlant", "discrete stateSpacePlant");
xlabel("time (seconds)");
ylabel("Xa (mm)");
title("step response of discre TF and SS")
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
plot(out.yesFrictionPControl.Time,out.yesFrictionPControl.Data)
hold on
plot(out.noFrictionPControl.Time,out.noFrictionPControl.Data)
legend("yes friction in model", "no fiction in model");
xlabel("time(s)");
ylabel("Xa (mm)");
title("closed loop system step response");
stepinfo(out.yesFrictionPControl.Data,out.yesFrictionPControl.Time)
stepinfo(out.noFrictionPControl.Data,out.noFrictionPControl.Time)
%% Question 5(a)

wc_desired = 60*2*pi;

%choose maxPhaseChange = 61 degrees
desiredPhaseChangeRad = 61/180*pi;
alpha = (-1-sin(desiredPhaseChangeRad))/(sin(desiredPhaseChangeRad)-1)
tao = (1/wc_desired)/sqrt(alpha)

compensator = (alpha*tao*s+1)/(tao*s+1)
[Gm,Pm,Wcg,Wcp] = margin(c2d(compensator,T,'tustin')*discretePlant);

Cs = compensator/abs(freqresp(c2d(compensator,T,'tustin')*discretePlant,wc_desired));
LL = Cs;
[Gm,Pm,Wcg,Wcp] = margin(c2d(Cs,T,'tustin')*discretePlant);

K= 12.6576;
%margin(c2d(compensator*K,T,'tustin')*discretePlant)

%% Question 5(b)

Ki = wc_desired/10;
IntegralController = (Ki+s)/s;
LLI = Cs*IntegralController;
margin(c2d(LLI,T,'tustin')*discretePlant);

plot(out.LLStep.Time,out.LLStep.Data)
hold on
plot(out.LLIStep.Time,out.LLIStep.Data)
legend("LL", "LLI");
xlabel("time(s)");
ylabel("Xa (mm)");
title("closed loop system step response");

scatter(out.LLRamp.Time,out.LLRamp.Data,'.')
hold on
scatter(out.LLIRamp.Time,out.LLIRamp.Data,'.')
plot(out.LLIRamp.Time,out.LLIRamp.Time)
legend("LL", "LLI","ramp_input");
xlabel("time(s)");
ylabel("Xa (mm)");
title("closed loop system ramp response");

%% Question 6
hold on
bode(continousPlant)
bode(LL);
bode(LLI);
bode(continousPlant*LL)
hold on

margin(continousPlant*LL)
margin(continousPlant*LL*1000)

bode(continousPlant*LLI)
hold on
bode(continousPlant*LLI*s^2)
xlim([-1000,1000])
legend("continousPlant", "LL","LLI","continousPlant*LL","continousPlant*LLI");

%% lab analsis
lli_step = load('lli_step.mat');
plot(lli_step.output.time-0.5018,lli_step.output.CH1out);
hold on;
plot(out.LLIStep.Time,out.LLIStep.Data)
legend("Lab", "Simulation");
xlabel("time(s)");
ylabel("Xa (mm)");
xlim([0,2])
title("closed loop system step response");

lli_ramp = load('lli_ramp.mat');
plot(lli_ramp.output.time-0.5018,lli_ramp.output.CH1out/5);
hold on;
plot(out.LLIRamp.Time,out.LLIRamp.Data)
legend("LabOutput/5", "Simulation");
xlabel("time(s)");
ylabel("Xa (mm)");
xlim([0,2])
title("closed loop system ramp response");

ll_step = load('ll_step.mat');
plot(ll_step.output.time-0.5018,ll_step.output.CH1out);
hold on;
plot(out.LLStep.Time,out.LLStep.Data)
legend("Lab", "Simulation");
xlabel("time(s)");
ylabel("Xa (mm)");
xlim([0,2])
title("closed loop system step response");

ll_ramp = load('ll_ramp.mat')
plot(ll_ramp.output.time-0.5018,ll_ramp.output.CH1out/5);
hold on;
plot(out.LLRamp.Time,out.LLRamp.Data)
plot(out.LLRamp.Time,out.LLRamp.Time)
legend("LabOutput/5", "Simulation","rampInput");
xlabel("time(s)");
ylabel("Xa (mm)");
xlim([0,2])
title("closed loop system ramp response");

Kp_step = load('Kp_step.mat');
plot(Kp_step.output.time-0.5018,Kp_step.output.CH1out);
hold on;
plot(out.yesFrictionPControl.Time,out.yesFrictionPControl.Data)
legend("Lab", "Simulation");
xlabel("time(s)");
ylabel("Xa (mm)");
xlim([0,2])
title("closed loop system step response");


Kp_ramp = load('Kp_ramp.mat')
plot(Kp_ramp.output.time-0.5018,Kp_ramp.output.CH1out/5);
hold on;
plot(out.yesFrictionPControlRamp.Time,out.yesFrictionPControlRamp.Data)
plot(out.yesFrictionPControlRamp.Time,out.yesFrictionPControlRamp.Time)
legend("LabOutput/5", "Simulation","rampInput");
xlabel("time(s)");
ylabel("Xa (mm)");
xlim([0,2])
title("closed loop system Ramp response");

