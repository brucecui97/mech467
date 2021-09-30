%% define constants given in lab manual
Kt = 0.72;
Kb = 0.4173;
Kvp = 111.55;
Kvi = 3.0019*10^5;
Sg = 0.887;
Ra = 6.5;
La = 0.0375;
Jm = 0.765*10^(-4);
mt = 20;
hp = 0.02;%m
Ls = 0.82;%m
ds = 0.02;%m
ps = 7800;%kg/m^3
Jenc = 1.7*10^(-4);
Jcoup = 4*10^(-5);
Jtach = 9.3212*10^(-7);

%% define derived constants
rs = ds/2;
Jtable = mt*(hp/(2*pi))^2;
JLeadScrew = 1/2*(pi*rs^2*Ls*ps)*rs^2;
Jeq = Jtable + JLeadScrew + Jm + Jenc + Jcoup + Jtach;
B = 0.006; %Nm/rad/s temp value but will be found later in lab

%% define transfer functions
s = tf("s");
currentSensorGain = Sg;
pWMAmplifier = Kvp + Kvi/s;
backEmfConstant = Kb;
electricalWindingOfMotor = 1/(La*s+Ra);
motorConstant = Kt;
mechanicalBlock = 1/(Jeq*s+B);

%% plot transfer functions for Im2Ws
Im2Ws = motorConstant * mechanicalBlock;
step(Im2Ws);
margin(Im2Ws);

%% plot transfer functions for Iin2Im
Iin2Im = minreal(pWMAmplifier*electricalWindingOfMotor/(1+pWMAmplifier*electricalWindingOfMotor+electricalWindingOfMotor*motorConstant*mechanicalBlock*backEmfConstant));
step(Iin2Im);
margin(Iin2Im);
bandwidth(Iin2Im)
dcgain(Iin2Im)

%% plot transfer function for Vin to Ws
Vin2Ws = currentSensorGain * Iin2Im * Im2Ws;
step(Vin2Ws);
margin(Vin2Ws);
bandwidth(Vin2Ws)
[y,tout] = step(Vin2Ws/s/dcgain(Vin2Ws));%ramp response
plot(linspace(0,50,1000),linspace(0,50,1000));
hold on
plot(tout,y)
dcgain(Vin2Ws)