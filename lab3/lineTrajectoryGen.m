%% Mech 467 - Trajectory Generation - Example

function [x,y] =lineTrajectoryGen(P1x, P1y, P2x,P2y)


Ti=0.0001;   fc=200;   A=1000;   D=-1000;


%% Linear Segment
    
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


%% Plots

% Plot of Trajectory
figure
plot(x,y,'b-','LineWidth',2)
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
close all
end
