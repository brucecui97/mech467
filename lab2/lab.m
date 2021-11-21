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


%% analsis
s = tf("s")
Kp = 1.2527;

KL = 13.11;
alpha = 13.92;
tao = 7*10^(-4);
LL = (alpha*tao*s+1)/(tao*s+1)*13.11;

Ki = 37.7;
IntegralController = (Ki+s)/s;
LLI = LL*IntegralController;


load('lli_step.mat');
load('ll_step.mat');
load('Kp_step.mat');
load('lli_ramp.mat')
load('ll_ramp.mat')
load('Kp_ramp.mat')

stepinfo(out.LLIStep.Data,out.LLIStep.Time)