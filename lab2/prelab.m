%% define constants
Ka = 0.887;
Kt = 0.72;
Je = 7*10^(-4);
Be = 0.00612;
Ke = 20/(2*pi);
T = 0.0002;

%% question1
s = tf("s");
continous_plant = Ka*Kt*(1/(Je*s+Be))*Ke/s;

b = [2904.286];
a = [1, 8.743,0,0];
[r,p,k] = residue(b,a);

partial_fraction = r(1)/(s-p(1)) + r(2)/(s-p(2)) + r(3)/(s-p(3))^2

discretePlant = c2d(continous_plant,T);

%% question2

numerator = cell2mat(discretePlant.Numerator);
denominator = cell2mat(discretePlant.Denominator);
[A,B,C,D] = tf2ss(numerator,denominator);

stateSpacePlant = ss(A,B,C,D,T);

%%question3

