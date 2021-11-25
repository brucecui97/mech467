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

%%
PM = 60;
lowBandWidthWcX = 20*2*pi;
lowBandWidthWcY = 20*2*pi;

highBandWidthWcX = 40*2*pi;
highBandWidthWcY = 40*2*pi;

mismatchedBandWidthWcX = 40*2*pi;
mismatchedBandWidthWcY = 20*2*pi;

LLlowBandWidthX = getLL(lowBandWidthWcX,PM,plantX);
LLlowBandWidthY = getLL(lowBandWidthWcX,PM,plantY);

LLHighBandWidthX = getLL(highBandWidthWcX,PM,plantX);
LLHighBandWidthY = getLL(highBandWidthWcY,PM,plantY);

LLMisMatchBandWidthX = getLL(mismatchedBandWidthWcX,PM,plantX);
LLMisMatchBandWidthY = getLL(mismatchedBandWidthWcY,PM,plantY);

margin(getLLI(mismatchedBandWidthWcX,PM,plantX)*plantX)


