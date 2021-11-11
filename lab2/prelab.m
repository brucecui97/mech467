%% define constants
Ka = 0.887;
Kt = 0.72;
Je = 7*10^(-4);
Be = 0.00612;
Ke = 20/(2*pi);
T = 0.0002;

%% analysis
s = tf("s");
Vin2Xa_continous = Ka*Kt*(1/(Je*s+Be))*Ke/s;

b = [2904.286];
a = [1, 8.743,0,0];
[r,p,k] = residue(b,a);

partial_fraction = r(1)/(s-p(1)) + r(2)/(s-p(2)) + r(3)/(s-p(3))^2

discretePlant = c2d(2904.286/(s^3+8.743*s^2),T);

syms z
temp = 38*z/(z-exp(-8.743*T))-38*z/(z-1) + 332.2*T*z/(z-1)^2
z = 2;
eval(temp*(z-1)/z)

%%

testTfContinoius = 1/(s)

discretePlant = c2d(testTfContinoius,T)

syms z
z/(z-1)*z/(z-exp(-T))

