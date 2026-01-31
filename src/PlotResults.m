function PlotResults(r, Ts, eta, vc, t_v, ro, T, f, PSD_db, PSD_theoretical_dB, v_tilde)
% PlotResults - Generate all plots for BPSK simulation
% Inputs:
%   r                   - filtered baseband signal
%   Ts                  - sampling period
%   eta                 - samples per symbol
%   vc                  - bandpass modulated signal
%   t_v                 - time vector for bandpass
%   ro                  - demodulated signal
%   T                   - symbol period
%   f                   - frequency vector
%   PSD_db              - estimated PSD in dB
%   PSD_theoretical_dB  - theoretical PSD in dB
%   v_tilde             - baseband transmit signal

% Plot 1: Baseband Received Signal
t_r = (0:length(r)-1) * Ts;
figure;
plot(t_r, r);
ylim([-1.1 1.1]);
xlabel('Time (s)');
ylabel('r(t)');
title('Received signal r(t)');
grid on;

% Plot 2: Transmitted Bandpass Signal
figure;
plot(t_v, vc);
xlabel('Time (s)');
ylabel('v_c(t)');
title('Transmitted bandpass signal v_c(t)');
grid on;

% Plot 3: Received Baseband Signal After Demodulation
t_ro = (0:length(ro)-1) * Ts;
figure;
plot(t_ro, ro);
xlabel('Time (s)');
ylabel('r_o(t)');
title('Received baseband signal r_o(t)');
grid on;

% Plot 4: PSD Estimated vs Theoretical
figure;
plot(f, PSD_db, 'b', 'LineWidth', 1.5);      % estimated PSD in blue
hold on;
plot(f, PSD_theoretical_dB, 'r--', 'LineWidth', 1.5); % theoretical PSD in red dashed
xlim([-750 750]);
ylim([-50 10]);
xlabel('Frequency (Hz)');
ylabel('PSD (dB)');
title('PSD of transmitted baseband signal v(t)');
legend('Estimated PSD', 'Theoretical PSD');
grid on;

% Plot 5: Bartlett PSD Method
Nf = 10;
PSD_Bartlett_dB = BartlettPSD(v_tilde, eta, T, Nf);

f_bartlett = (-length(v_tilde)/2 : length(v_tilde)/2-1) / (length(v_tilde)*T/eta);

HT_f = T * sinc(f_bartlett*T);
PSD_theoretical_bartlett = (1/T) * abs(HT_f).^2;
PSD_theoretical_bartlett_dB = 10*log10(PSD_theoretical_bartlett);

figure;
plot(f_bartlett, PSD_Bartlett_dB, 'b', 'LineWidth', 1.5);
hold on;
plot(f_bartlett, PSD_theoretical_bartlett_dB, 'r--', 'LineWidth', 1.5);
xlim([-750 750]);
ylim([-50 10]);
xlabel('Frequency (Hz)');
ylabel('PSD (dB)');
title('Removing jitters using Bartlett');
legend('Estimated PSD (Bartlett)', 'Theoretical PSD');
grid on;
end
