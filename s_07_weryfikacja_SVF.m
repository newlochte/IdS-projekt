close all; clear all; clc;

load("dane_weryfikacyjne.mat")

simulation = sim("model_metoda_svf.slx");
t_out = simulation.tout;
y_sym = simulation.y_sym.Data;
y_sym_v2 = simulation.y_sym_v2.Data;

J = mean((y-y_sym).^2)
J_v2 = mean((y-y_sym_v2).^2)

m = ones(length(y),1) .* mean(y);

J_fit = (1-(norm(y-y_sym)./norm(y-m))) * 100

J_fit_v2 = (1-(norm(y-y_sym_v2)./norm(y-m))) * 100
