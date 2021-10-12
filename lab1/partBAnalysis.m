partBData = load("pulse.mat").output;

Je = 5*10^(-4);
Be = 0.01075;
mew_k = 0.219;

time = partBData.time;
displacement_m = partBData.CH1out/1000;
angular_position_theta = displacement_m/hp*2*pi;
Ts = 0.0005; %s
W_t = deriv(angular_position_theta, Ts);
W_dot_t = deriv(W_t,Ts);

lhs = Sg*Kt*partBData.CH1sig - Be*W_t-sign(W_t)*mew_k;
rhs = Je*W_dot_t;

scatter(time,lhs)
hold on
scatter(time,rhs)
legend("lhs","rhs");