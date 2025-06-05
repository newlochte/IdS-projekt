clc; clear; close all;
load('RWP.dat')

czesc_danych_do_identyfikacji = 0.7;
ident_pierwsza = true;

u = RWP(:,1);
y = RWP(:,2);
% w = RWP(:,3);
N = length(u);

% 100Hz sampling frequency
t = 0:0.01:(length(u)-1)*0.01;
t = t';

N_cut = floor(N * czesc_danych_do_identyfikacji);

if ident_pierwsza
    u_indentyfikacyjne = u(1:N_cut);
    u_weryfikacyjne = u((N_cut+1):end);
    y_indentyfikacyjne = y(1:N_cut);
    y_weryfikacyjne = y((N_cut+1):end);
    t_indentyfikacyjne = t(1:N_cut);
    t_weryfikacyjne = t(1:(N-N_cut));
else
    u_weryfikacyjne = u(1:(N - N_cut));
    u_indentyfikacyjne = u((N - N_cut+1):end);
    y_weryfikacyjne = y(1:(N - N_cut));
    y_indentyfikacyjne = y((N - N_cut+1):end);
    t_weryfikacyjne = t(1:(N - N_cut));
    t_indentyfikacyjne = t(1:N_cut);
end

save("dane_identyfikacyjne","u_indentyfikacyjne","y_indentyfikacyjne","t_indentyfikacyjne");
save("dane_weryfikacyjne","u_weryfikacyjne","y_weryfikacyjne","t_weryfikacyjne");