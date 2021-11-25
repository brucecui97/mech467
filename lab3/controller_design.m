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

s = tf("s");
plantX = Kax*Ktx/(Jex*s+Bx)*(1/s)*Kex;
plantY = Kay*Kty/(Jey*s+By)*(1/s)*Key;