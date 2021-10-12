%%
mmPerSec15 = load("15.mat").output;
voltage_v15 = mmPerSec15.CH1sig;
motorCurrent_A15 = voltage_v15 * currentSensorGain;
motorTorque_Nm15 = Kt * motorCurrent_A15;
plot(motorTorque_Nm15);
forwardTorque15 = mean(motorTorque_Nm15(3111:18870));
backwardTorque15 = mean(motorTorque_Nm15(21920:37780));

%%
mmPerSec20 = load("20.mat").output;
voltage_v20 = mmPerSec20.CH1sig;
motorCurrent_A20 = voltage_v20 * currentSensorGain;
motorTorque_Nm20 = Kt * motorCurrent_A20;
plot(motorTorque_Nm20);
forwardTorque20 = mean(motorTorque_Nm20(3111:18870));
backwardTorque20 = mean(motorTorque_Nm20(21920:37780));

%%
mmPerSec25 = load("25.mat").output;
voltage_v25 = mmPerSec25.CH1sig;
motorCurrent_A25 = voltage_v25 * currentSensorGain;
motorTorque_Nm25 = Kt * motorCurrent_A25;
plot(motorTorque_Nm25);
forwardTorque25 = mean(motorTorque_Nm25(3111:18870));
backwardTorque25 = mean(motorTorque_Nm25(21920:37780));

mmPerSec30 = load("30.mat").output;
voltage_v30 = mmPerSec30.CH1sig;
motorCurrent_A30 = voltage_v30 * currentSensorGain;
motorTorque_Nm30 = Kt * motorCurrent_A30;
plot(motorTorque_Nm30);
forwardTorque30 = mean(motorTorque_Nm30(3111:18870));
backwardTorque30 = mean(motorTorque_Nm30(21920:37780));

mmPerSec35 = load("35.mat").output;
voltage_v35 = mmPerSec35.CH1sig;
motorCurrent_A35 = voltage_v35 * currentSensorGain;
motorTorque_Nm35 = Kt * motorCurrent_A35;
plot(motorTorque_Nm35);
forwardTorque35 = mean(motorTorque_Nm35(3111:18870));
backwardTorque35 = mean(motorTorque_Nm35(21920:37780));

mmPerSec40 = load("40.mat").output;
voltage_v40 = mmPerSec40.CH1sig;
motorCurrent_A40 = voltage_v40 * currentSensorGain;
motorTorque_Nm40 = Kt * motorCurrent_A40;
plot(motorTorque_Nm40);
forwardTorque40 = mean(motorTorque_Nm40(1504:9988));
backwardTorque40 = mean(motorTorque_Nm40(11530:20190));

mmPerSec50 = load("50.mat").output;
voltage_v50 = mmPerSec50.CH1sig;
motorCurrent_A50 = voltage_v50 * currentSensorGain;
motorTorque_Nm50 = Kt * motorCurrent_A50;
plot(motorTorque_Nm50);
forwardTorque50 = mean(motorTorque_Nm50(1504:9988));
backwardTorque50 = mean(motorTorque_Nm50(11530:20190));

mmPerSec60 = load("60.mat").output;
mmPerSec80 = load("80.mat").output;
mmPerSec100 = load("100.mat").output;
mmPerSec120 = load("120.mat").output;
mmPerSec140 = load("140.mat").output;
mmPerSec160 = load("160.mat").output;

%%

theta_dot = 15/1000/0.02*2*pi;
voltage_v = mmPerSec15.CH1sig;
motorCurrent_A = voltage_v * currentSensorGain;
motorTorque_Nm = Kt * motorCurrent_A;

linear_speeds_mmPerSec=[15,20,25,30,35,40,50];
angular_speeds_radPerSec = linear_speeds_mmPerSec/1000/hp*2*pi;
forward_torques = [forwardTorque15,forwardTorque20, forwardTorque25, forwardTorque30, forwardTorque35, forwardTorque40, forwardTorque50];
backward_torques = [backwardTorque15,backwardTorque20, backwardTorque25, backwardTorque30, backwardTorque35, backwardTorque40, backwardTorque50];
plot(angular_speeds_radPerSec, forward_torques);

forward_fit = polyfit(angular_speeds_radPerSec,forward_torques,1);
b_forward = forward_fit(1);
backward_fit = polyfit(angular_speeds_radPerSec,backward_torques,1);
b_backward = backward_fit(1);
