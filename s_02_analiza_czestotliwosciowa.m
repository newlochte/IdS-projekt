clc; clear; close all;
load('RWP.dat')

u = RWP(:,1);
y = RWP(:,2);

N = length(u) - 1;
Tp = 0.01;
% 100Hz sampling frequency
t = 0:Tp:(length(u)-1)*Tp;

% okno Hanninga
Mw = N/10;
% autokorelacja sygnału u
for i = 0: N-1
    ruuP(i+1) = Covar([u u], i);
    if (i<=Mw)
        ruuP(i+1) = ruuP(i+1)*0.5*(1+cos(pi*i/Mw)); % okno Hanninga
    else
        ruuP(i+1) = ruuP(i+1)*0.0;
    end
end
Ruu = [ruuP(1:Mw+1) zeros(1,2*N-2*Mw-2) ruuP(Mw+1:-1:2)];
% autokorelacja sygnału y
for i = 0: N-1
    ryyP(i+1) = Covar([y y], i);
    if (i<=Mw)
        ryyP(i+1) = ryyP(i+1)*0.5*(1+cos(pi*i/Mw)); % okno Hanninga
    else
        ryyP(i+1) = ryyP(i+1)*0.0;
    end
end
Ryy = [ryyP(1:Mw+1) zeros(1,2*N-2*Mw-2) ryyP(Mw+1:-1:2)];
% korelacja sygnału y i u
for i = 0: N-1
    ryuP(i+1) = Covar([y u], i);
    if (i<=Mw)
        ryuP(i+1) = ryuP(i+1)*0.5*(1+cos(pi*i/Mw)); % okno Hanninga
    else
        ryuP(i+1) = ryuP(i+1)*0.0;
    end
end
for i = 0: N-1
    j = i-(N-1);
    ryuN(i+1) = Covar([y u], j);
    if (abs(j)<=Mw)
        ryuN(i+1) = ryuN(i+1)*0.5*(1+cos(pi*i/Mw)); % okno Hanninga
    else
        ryuN(i+1) = ryuN(i+1)*0.0;
    end
end
Ryu = [ryuP(1:Mw+1) zeros(1,2*N-2*Mw-2) ryuN(N-Mw:N-1)];

% gęstości widmowe
PHI_uu = Tp*fft(Ruu);
PHI_yy = Tp*fft(Ryy);
PHI_yu = Tp*fft(Ryu);
AmpPHI_yu = abs(PHI_yu);
YN = Tp * fft(y);
UN = Tp * fft(u);

% charakterystyka bodego ETFE
ETFE = YN./UN;
AmpETFE = abs(ETFE);
LmETFE = 20*log10(AmpETFE);
ArgETFE = unwrap(angle(ETFE))*180/pi;

%wektor pulsacji
Nmm = size(AmpETFE, 1);
dOmegam = 2*pi/Nmm;
k = (0:1:Nmm-1)';
Omegam = dOmegam*k;
omegam = Omegam/Tp;
indm = floor(Nmm/2);
omega2m = omegam(1:indm);

% estymata charakterystyki Bodego wg estymatora wygładzonego
hatGs = PHI_yu./PHI_uu;
AmphatGs = abs(hatGs);
LmhatGs = 20*log10(AmphatGs);
ArghatGs = unwrap(angle(hatGs))*180/pi;

% wektor pulsacji estymaty
Nm = size(AmphatGs,2);
dOmega = 2*pi/Nm;
k = (0:1:Nm-1)';
Omega = dOmega*k;
omega = Omega/Tp;
ind = floor(Nm/2);
% omega2 = omega(1:ind);

figure;
subplot(2,1,1)
plot(abs(fft(u)))
grid on;
title('Analiza częstotliwościowa sygnału u');
xlabel('f [Hz]');
ylabel('amplituda');
% legend({'sin(x)', 'cos(x)'}, 'Location', 'best');
xlim([0 4000]);
% ylim([-1.2 1.2]);

subplot(2,1,2)
plot(abs(fft(y)))
grid on;
title('Analiza częstotliwościowa sygnału y');
xlabel('f [Hz]');
ylabel('amplituda');
% legend({'sin(x)', 'cos(x)'}, 'Location', 'best');
xlim([0 4000]);
% ylim([-1.2 1.2]);

% wykres Nyquista
figure
subplot(2,1,1)
plot(ETFE(1:floor(end/2)));
grid on;
title('Wykres Nyquista estymatora ETFE');
subplot(2,1,2)
plot(hatGs(1:floor(end/2)));
grid on;
title('Wykres Nyquista estymatora wygładzonego');
% wykresy bodego
figure
% subplot(2,2,1)
% semilogx(omegam(1:ind), LmETFE(1:ind))
% grid on;
% title('Wykres logarytmu modułu wg estymatora ETFE');
% xlabel('\omega [rad/s]');
% ylabel('Lm [dB]');
% % legend({'sin(x)', 'cos(x)'}, 'Location', 'best');
% xlim([0 10]);
% % ylim([-1.2 1.2]);

subplot(2,1,1)
semilogx(omega(1:ind), LmhatGs(1:ind))
grid on;
title('Wykres logarytmu modułu wg estymatora');
xlabel('\omega [rad/s]');
ylabel('Lm [dB]');
% legend({'sin(x)', 'cos(x)'}, 'Location', 'best');
xlim([0 10]);
% ylim([-1.2 1.2]);

% subplot(2,2,3)
% semilogx(omegam(1:ind), ArgETFE(1:ind))
% grid on;
% title('Wykres przesunięcia kątowego wg estymatora ETFE');
% xlabel('\omega [rad/s]');
% ylabel('Arg [deg]');
% % legend({'sin(x)', 'cos(x)'}, 'Location', 'best');
% xlim([0 10]);
% % ylim([-1.2 1.2]);

subplot(2,1,2)
semilogx(omega(1:ind), ArghatGs(1:ind))
grid on;
title('Wykres przesunięcia kątowego wg estymatora');
xlabel('\omega [rad/s]');
ylabel('Arg [deg]');
% legend({'sin(x)', 'cos(x)'}, 'Location', 'best');
xlim([0 10]);
% ylim([-1.2 1.2]);