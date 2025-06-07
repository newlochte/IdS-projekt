clc; clear; close all;
load('RWP.dat')

czesc_danych_do_identyfikacji = 0.7;
ident_pierwsza = true;

u_full = RWP(:,1);
y_full = RWP(:,2);
% w = RWP(:,3);
N = length(u_full);

Tp = 0.01;
% 100Hz sampling frequency
t_full = 0:0.01:(length(u_full)-1)*Tp;
t_full = t_full';

N_cut = floor(N * czesc_danych_do_identyfikacji);

if ident_pierwsza
    u = u_full(1:N_cut);
    y = y_full(1:N_cut);
    t = t_full(1:N_cut);
    save("dane_identyfikacyjne","u","y","t","Tp");

    u = u_full((N_cut+1):end);
    y = y_full((N_cut+1):end);
    t = t_full(1:(N-N_cut));
    save("dane_weryfikacyjne","u","y","t","Tp");
else
    u = u_full(1:(N - N_cut));
    y = y_full(1:(N - N_cut));
    t = t_full(1:(N - N_cut));
    save("dane_weryfikacyjne","u","y","t","Tp");

    u = u_full((N - N_cut+1):end);
    y = y_full((N - N_cut+1):end);
    t = t_full(1:N_cut);
    save("dane_identyfikacyjne","u","y","t","Tp");
end


