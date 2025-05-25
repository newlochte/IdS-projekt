clc; clear; close all;
load('RWP.dat')

u = RWP(:,1);
y = RWP(:,2);
% w = RWP(:,3);

% 100Hz sampling frequency
t = 0:0.01:(length(u)-1)*0.01;

% Initial static plot
% figure;
% plot(t, u, 'b', t, y, 'r'); 
% legend('u', 'y');

% Prepare animated figure with 3 subplots
% figure;

% ==== Subplot 1: Circle plot with angle y ====
subplot(3,1,1);
axis equal;
xlim([-1.2 1.2]);
ylim([-1.2 1.2]);
hold on;
plot(cos(linspace(0,2*pi,100)), sin(linspace(0,2*pi,100)), '--k'); % unit circle
h_point = plot(0, 0, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
title('Angle (y) on Circle');
ylabel('Circle');

% ==== Subplot 2: u vs time ====
subplot(3,1,2);
h_u = plot(t, u, 'b'); hold on;
h_u_marker = plot(t(1), u(1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
xlim([t(1), t(end)]);
ylim([min(u)-0.1, max(u)+0.1]);
title('u vs Time');
ylabel('u');

% ==== Subplot 3: raw y vs time ====
subplot(3,1,3);
h_y = plot(t, y, 'r'); hold on;
h_y_marker = plot(t(1), y(1), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
xlim([t(1), t(end)]);
ylim([min(y)-0.1, max(y)+0.1]);
title('Raw y (Angle) vs Time');
xlabel('Time [s]');
ylabel('y');

% ==== Animation loop ====
r = 1;
theta = y - pi/2; % rotate by 90 degrees
x = r * cos(theta);
yy = r * sin(theta);

for k = 1:length(t)
    % Update circle
    subplot(3,1,1);
    set(h_point, 'XData', x(k), 'YData', yy(k));

    % Update u marker
    subplot(3,1,2);
    set(h_u_marker, 'XData', t(k), 'YData', u(k));

    % Update y marker
    subplot(3,1,3);
    set(h_y_marker, 'XData', t(k), 'YData', y(k));

    pause(0.01); % simulate 100Hz
end
