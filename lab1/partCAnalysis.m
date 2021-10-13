
h1 = load("1.mat").output;

time = h1.time;
displacement_m = h1.CH1out/1000;
angular_position_theta = displacement_m/hp*2*pi;
Ts = 0.0005; %s
W_t = deriv(angular_position_theta, Ts);
W_dot_t = deriv(W_t,Ts);

plot(time,W_t)

h2= load("2.mat").output;
h3= load("3.mat").output;
h4= load("4.mat").output;
h5= load("5.mat").output;
h6= load("6.mat").output;
h7= load("7.mat").output;
h8= load("8.mat").output;
h9= load("9.mat").output;
h10= load("10.mat").output;

h20= load("20.mat").output;
h30= load("30.mat").output;
h40= load("40.mat").output;
h50= load("50.mat").output;
h60= load("60.mat").output;
h70= load("70.mat").output;

V_t = 10*sin(5*t)

laplace(V_t)/s

a= laplace(V_t)

a/s