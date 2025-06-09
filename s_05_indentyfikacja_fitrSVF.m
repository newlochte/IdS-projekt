clc; clear; close all;

load("dane_identyfikacyjne.mat")

% parametry do modyfikacji (elementy projektowe)
TF = 0.2; % stała czasowa filtru
nF = 2; % rząd dynamiki filtru >= rząd obiektu

s = tf('s');

F0 = 1/(1+s*TF)^nF;
F1 = s/(1+s*TF)^nF;
F2 = s^2/(1+s*TF)^nF;

yF = lsim(F0,y,t,'foh');   % filtrowane wyjście
ypF = lsim(F1,y,t,'foh');  % filtrowana pochodna wyjścia
yppF = lsim(F2,y,t,'foh'); % filtrowana druga pochodna wyjścia
uF = lsim(F0,u,t,'foh');   % filtrowane wejście

Phi = [sin(yF), -uF];
parametry_SVF = pinv(Phi)*yppF;
Phi = [sin(yF), ypF -uF];
parametry_SVF_v2 = pinv(Phi)*yppF;


save("parametry_SVF","parametry_SVF", "parametry_SVF_v2")