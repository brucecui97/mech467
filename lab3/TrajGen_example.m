%% Mech 467 - Trajectory Generation - Example

clear
close all
clc

Ti=0.001;   fc=215;   A=1000;   D=-1000;


%% Linear Segment
    
P1x=0;   P1y=0;   P2x=4;   P2y=3;

Ltot = sqrt((P2x-P1x)^2+(P2y-P1y)^2);
T2 = Ltot/fc - (1/(2*A) - 1/(2*D))*fc;

% Note that T2<0, so feed must be re-evaluated

fcm = sqrt(Ltot/(1/2/A-1/2/D)); % Simplified form 
T1 = fcm/A;
N1 = ceil(T1/Ti);
T1_=N1*Ti;
fcn = Ltot/T1_;
A_=fcn/T1_;     D_=-fcn/T1_;

for i=1:N1
    k = i;
    L(k) = 0.5*A_*(i*Ti)^2;
    f(k) = A_*i*Ti;
    a(k) = A_;
    t(k) = k*Ti;
end

L1e = L(N1);

for i=1:N1
    k=i+N1;
    L(k) = L1e + fcn*i*Ti + 0.5*D_*(i*Ti)^2;
    f(k) = fcn + D_*i*Ti;
    a(k) = D_;
    t(k) = k*Ti;    
end

x = P1x + L*(P2x-P1x)/Ltot;
y = P1y + L*(P2y-P1y)/Ltot;
x_dot = f*(P2x-P1x)/Ltot;
y_dot = f*(P2y-P1y)/Ltot;
x_2dot = a*(P2x-P1x)/Ltot;
y_2dot = a*(P2y-P1y)/Ltot;


%% Circular Segment

th_s = pi;       th_e = 2*pi;    R = 20;     xc=24;      yc=3;

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
plot(x,y,'b-','LineWidth',2)
hold on
plot(x3,y3,'b-','LineWidth',2)
hold on
plot([0,4,44],[0,3,3],'ko','MarkerSize',6,'MarkerFaceColor','k')
hold off
set(gca,'FontName','Euclid','Fontsize',12)
xlabel('X [mm]','FontSize',20,'FontWeight','bold','interpreter','latex')
ylabel('Y [mm]','FontSize',20,'FontWeight','bold','interpreter','latex')
text(1,-1,'$P_0$','FontSize',15,'FontWeight','bold','interpreter','latex')
text(5,4,'$P_1$','FontSize',15,'FontWeight','bold','interpreter','latex')
text(42,4,'$P_2$','FontSize',15,'FontWeight','bold','interpreter','latex')
grid on
grid minor
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
ax.XMinorTick='on';
ax.YMinorTick='on';
axis equal
%% 


% Plot of Displacement, Feedrate, and Acceleration of the Linear Segment
figure
subplot(3,1,1)
plot(t,L,'b-','LineWidth',2)
title('Displacement','FontSize',15,'fontweight','Bold','interpreter','latex')
ylabel('Displacement [$mm$]','FontSize',15,'FontWeight','bold','interpreter','latex')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t),max(t)])

subplot(3,1,2)
plot(t,f,'b-','LineWidth',2)
title('Feedrate','FontSize',15,'fontweight','Bold','interpreter','latex')
ylabel('Feedrate [$mm/s$]','FontSize',15,'FontWeight','bold','interpreter','latex')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t),max(t)])

subplot(3,1,3)
plot(t,a,'b-','LineWidth',2)
title('Acceleration','FontSize',15,'fontweight','Bold','interpreter','latex')
ylabel('Acceleration [$mm/s^2$]','FontSize',15,'FontWeight','bold','interpreter','latex')
xlabel('Time [$s$]','FontSize',15,'FontWeight','bold','interpreter','latex')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t),max(t)])


% Plot of Position, Velocity, and Acceleration of the Linear Segment in the x- and y-directions
figure
subplot(3,1,1)
plot(t,x,'b-','LineWidth',2)
hold on
plot(t,y,'r--','LineWidth',2)
hold off
ylabel('Position [$mm$]','FontSize',15,'FontWeight','bold','interpreter','latex')
title('Position','FontSize',15,'fontweight','Bold','interpreter','latex')
legend('x-axis','y-axis')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t),max(t)])

subplot(3,1,2)
plot(t,x_dot,'b-','LineWidth',2)
hold on
plot(t,y_dot,'r--','LineWidth',2)
hold off
ylabel('Velocity [$mm/s$]','FontSize',15,'FontWeight','bold','interpreter','latex')
title('Velocity','FontSize',15,'fontweight','Bold','interpreter','latex')
legend('x-axis','y-axis')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t),max(t)])

subplot(3,1,3)
plot(t,x_2dot,'b-','LineWidth',2)
hold on
plot(t,y_2dot,'r--','LineWidth',2)
hold off
xlabel('Time [$s$]','FontSize',15,'FontWeight','bold','interpreter','latex')
ylabel('Acceleration [$mm/s^2$]','FontSize',15,'FontWeight','bold','interpreter','latex')
title('Acceleration','FontSize',15,'fontweight','Bold','interpreter','latex')
legend('x-axis','y-axis')
grid on
ax=gca;
ax.GridLineStyle='--';
ax.GridAlpha=0.5;
xlim([min(t),max(t)])
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