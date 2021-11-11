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

r(1)/(s-p(1)) + r(2)/(s-p(2)) + r(3)/(s-p(3))^2
discretePlant = c2d(Vin2Xa_continous,T);

syms z
temp = z/(z-1)*(332.1895*0.0002*z/(z-1)^2-37.9955*z/(z-1)+37.9955*z/(z-0.9983))
[N,D] = numden(simplify(temp))

[N2,D2] = numden(simplify(D/z^2))

z=2
eval(temp)

