
h1 = load("1.mat").output;
h2= load("2.mat").output;
h3= load("3.mat").output;
h4= load("4.mat").output;
h5= load("5.mat").output;
h6= load("6.mat").output;
h7= load("7.mat").output;
h8= load("8.mat").output;
h9= load("9.mat").output;
h10 = load("./Group2/Part_C/10.mat").output;
h20= load("./Group2/Part_C/20.mat").output;
h30= load("./Group2/Part_C/30.mat").output;
h40= load("./Group2/Part_C/40.mat").output;
h50= load("./Group2/Part_C/50.mat").output;
h60= load("./Group2/Part_C/60.mat").output;
h70= load("./Group2/Part_C/70.mat").output;
datas = [h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h20,h30,h40,h50,h60,h70];

% peak2peakVoltage = peak2peakVoltage(1:16);
% peak2peakW_t = peak2peakW_t(1:16);
% time_lag = time_lag(1:16);
% for data = datas(15:end)
%     time = data.time;
%     displacement_m = data.CH1out/1000;
%     angular_position_theta = displacement_m/hp*2*pi;
%     Ts = 0.0005; %s
%     W_t = deriv(angular_position_theta, Ts);
%     plot(time,W_t);
%     hold on
%     plot(time,data.CH1in);
%     hold off
%     legend("W(t)", "voltage");
%     xlabel("time seconds");
%     enableDefaultInteractivity(gca);
%     [x,y] = ginput(6);
%     
%     peak2peakW_t = [peak2peakW_t, abs(y(1)-y(2))];
%     peak2peakVoltage = [peak2peakVoltage, abs(y(3)-y(4))];
%     time_lag = [time_lag, x(5)-x(6)];
%     
% end

frequencies_used_hz = [1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70];
frequencies_used_rad =frequencies_used_hz *2*pi;
phase_lags = time_lag.*frequencies_used_rad.*(180/pi);
magnitude_ratio = peak2peakW_t./peak2peakVoltage

Mag_mes = magnitude_ratio
Ang_mes = phase_lags

fruencies_for_model_rad_per_sec = linspace(1,100,500)*2*pi;
H = freqresp(Vin2Ws,[fruencies_for_model_rad_per_sec]) ;

% Bode Plot
h = figure(1);
set(h, 'Position', [0 0 800 600]+100)

% Magnitude Plot
subplot(211)
    loglog(frequencies_used_rad,Mag_mes,'o')
    xlim([5e0 2e2])
    xlabel('Frequency [rad per sec]')
    ylim([1e-5 1e3])
    yticks(10.^[-6:1:5])
    ylabel('magnitude (Rad\/s) / (Volt)')
    grid on
    
    hold on
    loglog(fruencies_for_model_rad_per_sec,squeeze(abs(H)),'.')
    legend("measured from lab", "analytical from prelab")
    

% Phase Plot
subplot(212);
    semilogx(frequencies_used_rad,Ang_mes,'o');
    ylim([-180 0])
    yticks([-360:90:180])
    grid on
    xlim([5e0 2e2])
    xlabel('Frequency [rad per sec]')
    ylabel('phase (degrees)')
    
    hold on
    semilogx(fruencies_for_model_rad_per_sec,squeeze(angle(H))*180/pi,'.')
    legend("measured from lab", "analytical from prelab")
