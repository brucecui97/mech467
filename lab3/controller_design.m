Kax = 1;
Ktx = 0.49;
Kex = 1.59;
Jex = 4.36*10^(-4);
Bx = 0.0094;

Kay = 1;
Kty = 0.49;
Key = 1.59;
Jey = 3*10^(-4)
By = 0.0091;
Ts = 0.0001;

s = tf("s");
plantX = Kax*Ktx/(Jex*s+Bx)*(1/s)*Kex;
discretePlantX = c2d(plantX,Ts,'zoh');
plantY = Kay*Kty/(Jey*s+By)*(1/s)*Key;
discretePlantY = c2d(plantY,Ts,'zoh');

%% B
PM = 60;
lowBandWidthWcX = 20*2*pi;
lowBandWidthWcY = 20*2*pi;

highBandWidthWcX = 40*2*pi;
highBandWidthWcY = 40*2*pi;

mismatchedBandWidthWcX = 40*2*pi;
mismatchedBandWidthWcY = 20*2*pi;

LLIlowBandWidthX = getLLI(lowBandWidthWcX,PM,plantX);
LLIlowBandWidthXD = c2d(LLIlowBandWidthX,Ts,'tustin');
contlowXPole = pole(feedback(LLIlowBandWidthX*plantX,1))
discreteLowXPole = pole(feedback(LLIlowBandWidthXD*discretePlantX,1));

LLIlowBandWidthY = getLLI(lowBandWidthWcX,PM,plantY);

LLIHighBandWidthX = getLLI(highBandWidthWcX,PM,plantX);
LLIHighBandWidthY = getLLI(highBandWidthWcY,PM,plantY);

LLIMisMatchBandWidthX = getLLI(mismatchedBandWidthWcX,PM,plantX);
LLIMisMatchBandWidthY = getLLI(mismatchedBandWidthWcY,PM,plantY);

figure
bode(LLIlowBandWidthX*plantX);
hold on
bode(LLIHighBandWidthX*plantX);
hold off
title("oepnloop system of x axis");
legend("with LBW controller", "with HWB controller");

figure
bode(LLIlowBandWidthX*plantX/(1+LLIlowBandWidthX*plantX));
hold on
bode(LLIHighBandWidthX*plantX/(1+LLIHighBandWidthX*plantX));
hold off
title("close loop system of x axis");
legend("with LBW controller", "with HWB controller");




