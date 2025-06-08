clc; clear; close all;

load("dane_identyfikacyjne.mat")

% modele ARX 2 do 5 rzędu
phi2 = [-y(1:end-1), u(1:end-1)];
p2 = pinv(phi2) * y(2:end);

phi3 = [-y(2:end-1), -y(1:end-2) u(2:end-1)];
p3 = pinv(phi3) * y(3:end);

phi4 = [-y(3:end-1), -y(2:end-2), -y(1:end-3) u(3:end-1)];
p4 = pinv(phi4) * y(4:end);

phi5 = [-y(4:end-1), -y(3:end-2), -y(2:end-3), -y(1:end-4) u(4:end-1)];
p5 = pinv(phi5) * y(5:end);

save("parametry_inercja","p5","p4","p3","p2","phi5","phi4","phi3","phi2")