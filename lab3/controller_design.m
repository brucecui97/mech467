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
bandwidth(feedback(LLIlowBandWidthXD*discretePlantX,1))
stepinfo(feedback(LLIlowBandWidthXD*discretePlantX,1))

LLIlowBandWidthY = getLLI(lowBandWidthWcY,PM,plantY);
LLIlowBandWidthYD = c2d(LLIlowBandWidthY,Ts,'tustin');
contlowYPole = pole(feedback(LLIlowBandWidthY*plantY,1))
discreteLowYPole = pole(feedback(LLIlowBandWidthYD*discretePlantY,1));
bandwidth(feedback(LLIlowBandWidthYD*discretePlantY,1))
stepinfo(feedback(LLIlowBandWidthYD*discretePlantY,1))

LLIHighBandWidthX = getLLI(highBandWidthWcX,PM,plantX);
LLIHighBandWidthXD = c2d(LLIHighBandWidthX,Ts,'tustin');
contHighXPole = pole(feedback(LLIHighBandWidthX*plantX,1));
discreteHighXPole = pole(feedback(LLIHighBandWidthXD*discretePlantX,1));
bandwidth(feedback(LLIHighBandWidthXD*discretePlantX,1))
stepinfo(feedback(LLIHighBandWidthXD*discretePlantX,1))

LLIHighBandWidthY = getLLI(highBandWidthWcY,PM,plantY);
LLIHighBandWidthYD = c2d(LLIHighBandWidthY,Ts,'tustin');
contHighYPole = pole(feedback(LLIHighBandWidthY*plantY,1));
discreteHighYPole = pole(feedback(LLIHighBandWidthYD*discretePlantY,1));
bandwidth(feedback(LLIHighBandWidthYD*discretePlantY,1))
stepinfo(feedback(LLIHighBandWidthYD*discretePlantY,1))

LLIMisMatchBandWidthX = getLLI(mismatchedBandWidthWcX,PM,plantX);
LLIMisMatchBandWidthXD = c2d(LLIMisMatchBandWidthX,Ts,'tustin');

LLIMisMatchBandWidthY = getLLI(mismatchedBandWidthWcY,PM,plantY);
LLIMisMatchBandWidthYD = c2d(LLIMisMatchBandWidthY,Ts,'tustin');


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

%% C

[xline1,yline1,tline1] = lineTrajectoryGen(0,0,40,30);
[xline2,yline2,tline2] = lineTrajectoryGen(40,30,60,30);
[xc,yc, tc] = circularTrajectoryGen(pi,pi+2*pi,30,90,30);

x = [xline1,xline2,xc];
y = [yline1,yline2,yc];
t = linspace(Ts,Ts*length(x),length(x));
traj.t = t;
traj.x = x;
traj.y = y;
save traj traj
%% E.1
figure
plot(out.xTrackingError)
hold on;
plot(out.xTrackingError1);
legend("low band width x LLI", "high bandwidth x LLI");
title("x tracking error over time")

figure
plot(out.yTrackingError)
hold on;
plot(out.yTrackingError1);
legend("low band width y LLI", "high bandwidth y LLI");
title("y Tracking Error vs time")

%% E.2
R1 = [21.16,15.8];
R2 = [40,30];
R3 = [60,30];
R4 = [110,55];
winSize = 0.2;

subplot(2,2,1)
R = R1;
plot(x,y)
hold on
plot(out.xout.Data,out.yout.Data);
legend("reference","LLI low bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])

subplot(2,2,2)
R = R2;
plot(x,y)
hold on
plot(out.xout.Data,out.yout.Data);
legend("reference","LLI low bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])


subplot(2,2,3)
R = R3;
plot(x,y)
hold on
plot(out.xout.Data,out.yout.Data);
legend("reference","LLI low bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])


subplot(2,2,4)
R = R4;
plot(x,y)
hold on
plot(out.xout.Data,out.yout.Data);
legend("reference","LLI low bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
sgtitle("LLI low bandwidth controller");

%%
subplot(2,2,1)
R = R1;
plot(x,y)
hold on
plot(out.xout1.Data,out.yout1.Data);
legend("reference","LLI high bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])

subplot(2,2,2)
R = R2;
plot(x,y)
hold on
plot(out.xout1.Data,out.yout1.Data);
legend("reference","LLI high bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])


subplot(2,2,3)
R = R3;
plot(x,y)
hold on
plot(out.xout1.Data,out.yout1.Data);
legend("reference","LLI high bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])


subplot(2,2,4)
R = R4;
plot(x,y)
hold on
plot(out.xout1.Data,out.yout1.Data);
legend("reference","LLI high bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
sgtitle("LLI high bandwidth controller");


%%
subplot(2,2,1)
R = R1;
plot(x,y)
hold on
plot(out.xout2.Data,out.yout2.Data);
legend("reference","LLI mismatched bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])

subplot(2,2,2)
R = R2;
plot(x,y)
hold on
plot(out.xout2.Data,out.yout2.Data);
legend("reference","LLI mismatched bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])


subplot(2,2,3)
R = R3;
plot(x,y)
hold on
plot(out.xout2.Data,out.yout2.Data);
legend("reference","LLI mismatched bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])


subplot(2,2,4)
R = R4;
plot(x,y)
hold on
plot(out.xout2.Data,out.yout2.Data);
legend("reference","LLI mismatched bandwidth actual")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
sgtitle("LLI mismatched bandwidth controller");

%% E.3

figure
plot(out.xTrackingError.Time, sqrt(out.xTrackingError.Data.^2 + out.yTrackingError.Data.^2))
title("contour error vs time for case 1 controller")
xlabel("time(s)");
ylabel("contour error (mm)");

%% F.2
load fastTraj

figure
plot(out.xTrackingError,'o','LineWidth',0.1)
hold on;
plot(out.xTrackingError3,'LineWidth',1);
legend("low band width x LLI 200 feedrate", "low bandwidth x LLI 250 feedrate");
title("x tracking error over time")
ylabel("tracking error (mm)")

figure
plot(out.yTrackingError,'o','LineWidth',0.1)
hold on;
plot(out.yTrackingError3,'LineWidth',1);
legend("low band width y LLI 200 feedrate", "low bandwidth y LLI 250 feedrate");
title("y Tracking Error vs time")
ylabel("tracking error (mm)")

%% F.3

R1 = [21.16,15.8];
R2 = [40,30];
R3 = [60,30];
R4 = [110,55];
winSize = 0.2;

subplot(2,2,1)
R = R1;
plot(x,y)
hold on
plot(out.xout.Data,out.yout.Data,'LineWidth',5);
plot(out.xout3.Data,out.yout3.Data,'.','color', 'g','LineWidth',0.1);
legend("reference","LLI low bandwidth 200 feedrate", "LLI low bandwidth 250 feedrate")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");


subplot(2,2,2)
R = R2;
plot(x,y)
hold on
plot(out.xout.Data,out.yout.Data,'LineWidth',5);
plot(out.xout3.Data,out.yout3.Data,'.','color', 'g','LineWidth',0.1);
legend("reference","LLI low bandwidth 200 feedrate", "LLI low bandwidth 250 feedrate")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");


subplot(2,2,3)
R = R3;
plot(x,y)
hold on
plot(out.xout.Data,out.yout.Data,'LineWidth',5);
plot(out.xout3.Data,out.yout3.Data,'.','color', 'g','LineWidth',0.1);
legend("reference","LLI low bandwidth 200 feedrate", "LLI low bandwidth 250 feedrate")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");

subplot(2,2,4)
R = R4;
plot(x,y)
hold on
plot(out.xout.Data,out.yout.Data,'LineWidth',5);
plot(out.xout3.Data,out.yout3.Data,'.','color', 'g','LineWidth',0.1);
legend("reference","LLI low bandwidth 200 feedrate", "LLI low bandwidth 250 feedrate")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");
sgtitle("How Feedrate affects LLI low bandwidth controller performance");

%% G1.1
load linecircle_lli.mat
load linecircle_ppc.mat

x_tracking_error = linecircle_lli.Y(1).Data - linecircle_lli.Y(3).Data;
y_tracking_error = linecircle_lli.Y(2).Data - linecircle_lli.Y(4).Data;

plot(out.xTrackingError);
hold on;
plot(linecircle_lli.X.Data-1, -x_tracking_error);
legend("simulated tracking error", "experimentally determiend tracking error");
ylabel("x position (mm)")
title("x tracking error vs time");

plot(out.yTrackingError);
hold on;
plot(linecircle_lli.X.Data-1, -y_tracking_error);
legend("simulated tracking error", "experimentally determiend tracking error");
ylabel("y position (mm)")
title("y tracking error vs time");
%% G1.2

load linecircle_lli.mat
load linecircle_ppc.mat

plot(linecircle_lli.Y.Data)
legend("lli", "reference")


R1 = [21.16,15.8];
R2 = [40,30];
R3 = [60,30];
R4 = [110,55];
winSize = 0.2;

subplot(2,2,1)
R = R1;
hold on
plot(linecircle_lli.Y.Data)
plot(out.xout.Data,out.yout.Data,'.','color', 'g','LineWidth',0.1);
legend("lli actual", "reference", "lli simulated")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");


subplot(2,2,2)
R = R2;
hold on
plot(linecircle_lli.Y.Data)
plot(out.xout.Data,out.yout.Data,'.','color', 'g','LineWidth',0.1);
legend("lli actual", "reference", "lli simulated")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");


subplot(2,2,3)
R = R3;
hold on
plot(linecircle_lli.Y.Data)
plot(out.xout.Data,out.yout.Data,'.','color', 'g','LineWidth',0.1);
legend("lli actual", "reference", "lli simulated")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");

subplot(2,2,4)
R = R4;
hold on
plot(linecircle_lli.Y.Data)
plot(out.xout.Data,out.yout.Data,'.','color', 'g','LineWidth',0.1);
legend("lli actual", "reference", "lli simulated")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");
sgtitle("Simulated for experimental result - LLI low bandwidth controller performance");

%% G.2.1
load bruce.mat

x_tracking_error = bruce.Y(1).Data - bruce.Y(3).Data;
y_tracking_error = bruce.Y(2).Data - bruce.Y(4).Data;

contouringError = sqrt(x_tracking_error.^2 + y_tracking_error.^2);

plot(bruce.X.Data,contouringError);
title("contouring error plot for custom cutting pattern");
xlabel("time (seconds)");
ylabel("contour error (mm)")

%% G.2.2

subplot(2,2,1)
R = [40.3,30.09];
hold on
plot(bruce.Y.Data)
plot(out.xout4.Data,out.yout4.Data,'.','color', 'g','LineWidth',0.1);
legend("lli actual", "reference", "lli simulated")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");


subplot(2,2,2)
R = [91.4,-0.58];
hold on
plot(bruce.Y.Data)
plot(out.xout4.Data,out.yout4.Data,'.','color', 'g','LineWidth',0.1);
legend("lli actual", "reference", "lli simulated")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");



subplot(2,2,3)
R = [120.1,30.47];
hold on
plot(bruce.Y.Data)
plot(out.xout4.Data,out.yout4.Data,'.','color', 'g','LineWidth',0.1);
legend("lli actual", "reference", "lli simulated")
axis([R(1)-winSize,R(1)+winSize,R(2)-winSize,R(2)+winSize])
xlabel("tool x position (mm)");
ylabel("tool y position (mm)");

sgtitle("Simulated for experimental result - LLI low bandwidth controller performance");

