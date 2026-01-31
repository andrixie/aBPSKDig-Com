%% ========================
%% 1. Data Source (Parameters)
%% ========================
[Na, eta, T, Ts, fc, Ns, f, ~] = InitializeParameters();

% Transmitted message (can also use random)
a = randi([0 1], 1, Na);
%a = [1 0 1 0 0 0 1 1 0 1];
disp(sprintf('Transmitted Message: %s', sprintf('%d ', a)));

%% ========================
%% 2. Symbol Mapping
%% ========================
s = SymbolMapper(a);
disp(['Mapped Symbols: ', num2str(s)]);

%% ========================
%% 3. Transmit Filter
%% ========================
[v_tilde, t_v, Ns] = TransmitFilter(s, eta, T, Na);
r_tilde = v_tilde;

%% ========================
%% Estimate PSD using FFT
%% ========================
[PSD, PSD_db, PSD_theoretical, PSD_theoretical_dB, ~] = EstimatePSD(v_tilde, f, T, Ns, Ts);

%% ========================
%% 4. Modulation / Demodulation
%% ========================
% Modulate to bandpass
[vc, t_v] = Modulate(v_tilde, fc, t_v);
rc = vc;                            % Ideal bandpass channel (no distortion)

% Demodulate back to baseband
hT = ones(1, eta) * 1/sqrt(T);      % Transmit filter for matched filter
[~, ro] = Demodulate(rc, fc, t_v, hT, Ts);

%% ========================
%% 5. Baseband Detection
%% ========================
[ah, y] = BasebandDetection(r_tilde, hT, Ts, eta, Na);
r = y;                              % Store filtered baseband signal

%% ========================
%% 6. Print first four oversampled points
%% ========================
for n = 0:3
    idx = (n*eta + 1):(n*eta + 4);  % First four samples of each symbol
    fprintf('For n = %d: ', n);
    fprintf('%.15g\t', r(idx));
    fprintf('\n');
end

%% ========================
%% 7. Data Sink (Compare transmitted vs received)
%% ========================
disp(sprintf('Received Message: %s', sprintf('%d ', ah)));
nErrs = sum(xor(a, ah));
disp(sprintf('Number of errors: %d', nErrs));

%% ========================
%% 8. Generate All Plots
%% ========================
PlotResults(r, Ts, eta, vc, t_v, ro, T, f, PSD_db, PSD_theoretical_dB, v_tilde);