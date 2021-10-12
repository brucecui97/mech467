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
mmPerSec35 = load("35.mat").output;
mmPerSec40 = load("40.mat").output;
mmPerSec50 = load("50.mat").output;
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

linear_speeds_mmPerSec=[15,20,25];
angular_speeds_radPerSec = linear_speeds_mmPerSec/1000/hp*2*pi;
forward_torques = [forwardTorque15,forwardTorque20, forwardTorque25];
plot(angular_speeds_radPerSec, forward_torques);

test_B = (forward_torques(end)-forward_torques(1))/(angular_speeds_radPerSec(end)-angular_speeds_radPerSec(1))
