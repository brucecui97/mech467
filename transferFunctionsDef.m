%% define constants
Kt = 0.72;
Kb = 0.4173;
Kvp = 111.55;
Kvi = 3.0019*10^5;
Sg = 0.887;
Ra = 6.5;
La = 0.0375;
Jm = 0.765*10^(-4);
mt = 20;
hp = 0.02;
Ls = 820;
ds = 20;
ps = 7800;
Jenc = 1.7*10^(-4);
Jcoup = 4*10^(-5);
Jtach = 9.3212*10^(-7);

%% define transfer functions
s = tf("s");
currentSensorGain = Sg;
pWMAmplifier = Kvp + Kvi/s;
backEmfConstant = Kb;
electricalWindingOfMotor = 4;
motorConstant = Kt;
mechanicalBlock = 6;
