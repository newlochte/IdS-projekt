clc; clear; close all;
load('RWP.dat')

u = RWP(:,1);
y = RWP(:,2);
% w = RWP(:,3);

% 100Hz sampling frequency
t = 0:0.01:(length(u)-1)*0.01;

plot(abs(fft(u)))