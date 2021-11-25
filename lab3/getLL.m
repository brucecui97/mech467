function LL = getLL(wc_desired,PM,plant)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

s = tf("s");

[~,curr_phase,~] = bode(plant,wc_desired);

desiredPhaseChangeRad = (PM - (180+curr_phase))/180*pi;
alpha = (-1-sin(desiredPhaseChangeRad))/(sin(desiredPhaseChangeRad)-1);
tao = (1/wc_desired)/sqrt(alpha);

compensator = (alpha*tao*s+1)/(tao*s+1);
Cs = compensator/abs(freqresp(compensator*plant,wc_desired));
LL = Cs;
end

