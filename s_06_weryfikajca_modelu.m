close all; clear all; clc;

load("dane_weryfikacyjne.mat")
% load("parametry_SVF.mat")
load("parametry_inercja.mat")

phi = [-y(1:end-1),u(1:end-1)];
y_czapka = [0;phi*p2];

Gm = tf(p2(2), [1, p2(1)], Tp);
ym = lsim(Gm, u, t);

figure('Name','2 rząd inercji')
plot(t,y,'DisplayName', 'y')
legend('y')
hold on
plot(t,y_czapka,'DisplayName', 'y_{czapka}')
plot(t,ym,'DisplayName', 'y_m')
hold off

% 3 rząd
phi = [-y(2:end-1),-y(1:end-2),u(2:end-1)];
y_czapka = [0;phi*p3];

Gm = tf(p3(3), [1, p3(1), p3(2)], Tp);
ym = lsim(Gm, u, t);

figure('Name','3 rząd inercji')
plot(t,y,'DisplayName', 'y')
legend('y')
hold on
plot(t(1:end-1),y_czapka,'DisplayName', 'y_{czapka}')
plot(t,ym,'DisplayName', 'y_m')
hold off

% 4 rząd
phi = [-y(3:end-1),-y(2:end-2),-y(1:end-3),u(3:end-1)];
y_czapka = [0;phi*p4];

Gm = tf(p4(4), [1, p4(1), p4(2), p4(3)], Tp);
ym = lsim(Gm, u, t);

figure('Name','4 rząd inercji')
plot(t,y,'DisplayName', 'y')
legend('y')
hold on
plot(t(1:end-2),y_czapka,'DisplayName', 'y_{czapka}')
plot(t,ym,'DisplayName', 'y_m')
hold off

% 5 rząd
phi = [-y(4:end-1),-y(3:end-2),-y(2:end-3),-y(1:end-4),u(4:end-1)];
y_czapka = [0;phi*p5];

Gm = tf(p5(5), [1, p5(1), p5(2), p5(3), p5(4)], Tp);
ym = lsim(Gm, u, t);

figure('Name','5 rząd inercji')
plot(t,y,'DisplayName', 'y')
legend('y')
hold on
plot(t(1:end-3),y_czapka,'DisplayName', 'y_{czapka}')
plot(t,ym,'DisplayName', 'y_m')
hold off
