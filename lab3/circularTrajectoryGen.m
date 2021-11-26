%% Mech 467 - Trajectory Generation - Example

function [x3,y3,t3] =circularTrajectoryGen(th_s, th_e, R,xc, yc)

Ti=0.0001;   fc=200;   A=1000;   D=-1000;

%% Circular Segment

%th_s = pi;       th_e = pi+2*pi;    R = 30;     xc=90;      yc=30;

Ltot = R*(th_e-th_s);

T2 = Ltot/fc - (1/2/A - 1/2/D)*fc;

% T2 Positive
T1 = fc/A;     T3 = -fc/D;
N1 = ceil(T1/Ti);    N2 = ceil(T2/Ti);      N3 = ceil(T3/Ti);     Ntot=N1+N2+N3;
T1_=N1*Ti;      T2_=N2*Ti;      T3_=N3*Ti;
fcn = 2*Ltot/(T1_+2*T2_+T3_);
A_=fcn/T1_;     D_=-fcn/T3_;

L1e = 0.5*A_*T1_^2;
L2e = L1e + fcn*T2_;

for i=1:N1
    k = i;
    L3(k) = 0.5*A_*(i*Ti)^2;
    f3(k) = A_*i*Ti;
    a3(k) = A_;
    x3(k) = xc + R*cos(th_s+L3(k)/R);
    y3(k) = yc + R*sin(th_s+L3(k)/R);
    x3_dot(k) = -f3(k)*sin(th_s+L3(k)/R);
    y3_dot(k) = f3(k)*cos(th_s+L3(k)/R);
    x3_2dot(k) = -a3(k)*sin(th_s+L3(k)/R) - (f3(k)^2/R)*cos(th_s+L3(k)/R);
    y3_2dot(k) = a3(k)*cos(th_s+L3(k)/R) - (f3(k)^2/R)*sin(th_s+L3(k)/R);
    t3(k) = k*Ti;
end

for i=1:N2
    k=i+N1;
    L3(k) = L1e + fcn*i*Ti;
    f3(k) = fcn;
    a3(k) = 0;
    x3(k) = xc + R*cos(th_s+L3(k)/R);
    y3(k) = yc + R*sin(th_s+L3(k)/R);
    x3_dot(k) = -f3(k)*sin(th_s+L3(k)/R);
    y3_dot(k) = f3(k)*cos(th_s+L3(k)/R);
    x3_2dot(k) = -a3(k)*sin(th_s+L3(k)/R) - (f3(k)^2/R)*cos(th_s+L3(k)/R);
    y3_2dot(k) = a3(k)*cos(th_s+L3(k)/R) - (f3(k)^2/R)*sin(th_s+L3(k)/R);
    t3(k) = k*Ti;    
end

for i=1:N3
    k=i+N1+N2;
    L3(k) = L2e + fcn*i*Ti + 0.5*D_*(i*Ti)^2;
    f3(k) = fcn+D_*i*Ti;
    a3(k) = D_;
    x3(k) = xc + R*cos(th_s+L3(k)/R);
    y3(k) = yc + R*sin(th_s+L3(k)/R);
    x3_dot(k) = -f3(k)*sin(th_s+L3(k)/R);
    y3_dot(k) = f3(k)*cos(th_s+L3(k)/R);
    x3_2dot(k) = -a3(k)*sin(th_s+L3(k)/R) - (f3(k)^2/R)*cos(th_s+L3(k)/R);
    y3_2dot(k) = a3(k)*cos(th_s+L3(k)/R) - (f3(k)^2/R)*sin(th_s+L3(k)/R);
    t3(k) = k*Ti;    
end


%% Plots

% Plot of Trajectory
figure
plot(x3,y3,'b-','LineWidth',2)
hold on
set(gca,'FontName','Euclid','Fontsize',12)
xlabel('X [mm]','FontSize',20,'FontWeight','bold','interpreter','latex')
ylabel('Y [mm]','FontSize',20,'FontWeight','bold','interpreter','latex')
grid on
grid minor
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
ax.XMinorTick='on';
ax.YMinorTick='on';
axis equal
%% 

% Plot of Displacement, Feedrate, and Acceleration of the Circular Segment
figure
subplot(3,1,1)
plot(t3,L3,'b-','LineWidth',2)
title('Displacement','FontSize',15,'fontweight','Bold','interpreter','latex')
ylabel('Displacement [$mm$]','FontSize',15,'FontWeight','bold','interpreter','latex')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t3),max(t3)])

subplot(3,1,2)
plot(t3,f3,'b-','LineWidth',2)
title('Feedrate','FontSize',15,'fontweight','Bold','interpreter','latex')
ylabel('Feedrate [$mm/s$]','FontSize',15,'FontWeight','bold','interpreter','latex')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t3),max(t3)])

subplot(3,1,3)
plot(t3,a3,'b-','LineWidth',2)
title('Acceleration','FontSize',15,'fontweight','Bold','interpreter','latex')
ylabel('Acceleration [$mm/s^2$]','FontSize',15,'FontWeight','bold','interpreter','latex')
xlabel('Time [$s$]','FontSize',15,'FontWeight','bold','interpreter','latex')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t3),max(t3)])


% Plot of Position, Velocity, and Acceleration of the Circular Segment in the x- and y-directions
figure
subplot(3,1,1)
plot(t3,x3,'b-','LineWidth',2)
hold on
plot(t3,y3,'r--','LineWidth',2)
hold off
ylabel('Position [$mm$]','FontSize',15,'FontWeight','bold','interpreter','latex')
title('Position','FontSize',15,'fontweight','Bold','interpreter','latex')
legend('x-axis','y-axis','FontSize',15,'FontWeight','bold','location','best','interpreter','latex')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t3),max(t3)])

subplot(3,1,2)
plot(t3,x3_dot,'b-','LineWidth',2)
hold on
plot(t3,y3_dot,'r--','LineWidth',2)
hold off
ylabel('Velocity [$mm/s$]','FontSize',15,'FontWeight','bold','interpreter','latex')
title('Velocity','FontSize',15,'fontweight','Bold','interpreter','latex')
legend('x-axis','y-axis','FontSize',15,'FontWeight','bold','location','best','interpreter','latex')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t3),max(t3)])

subplot(3,1,3)
plot(t3,x3_2dot,'b-','LineWidth',2)
hold on
plot(t3,y3_2dot,'r--','LineWidth',2)
hold off
xlabel('Time [$s$]','FontSize',15,'FontWeight','bold','interpreter','latex')
ylabel('Acceleration [$mm/s^2$]','FontSize',15,'FontWeight','bold','interpreter','latex')
title('Acceleration','FontSize',15,'fontweight','Bold','interpreter','latex')
legend('x-axis','y-axis','FontSize',15,'FontWeight','bold','location','best','interpreter','latex')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t3),max(t3)])
close all
end