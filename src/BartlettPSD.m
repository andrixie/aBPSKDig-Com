function PSD_avg_dB = BartlettPSD(v_tilde, eta, T, Nf)
% BartlettPSD - Estimate PSD using Bartlett's method
% Inputs:
%   v_tilde - baseband transmit signal (1D vector)
%   eta     - samples per symbol
%   T       - symbol period
%   Nf      - number of random messages to average
% Output:
%   PSD_avg_dB - averaged PSD in dB

Ns = length(v_tilde);
Ts = T/eta;
PSD_avg = zeros(1, Ns);

for m = 1:Nf
    % Generate random message of same length
    Na = Ns / eta;
    a = randi([0 1], 1, Na);

    % Symbol mapping
    s = SymbolMapper(a);

    % Baseband signal
    v_up = upsample(s, eta);
    v_msg = conv(v_up, ones(1, eta)/sqrt(T));
    v_msg = v_msg(1:Ns);  % truncate

    % PSD of this message
    Vf = fftshift(fft(v_msg));
    PSD_msg = (Vf .* conj(Vf)) * Ts / Ns;

    % Accumulate
    PSD_avg = PSD_avg + PSD_msg;
end

% Average PSD
PSD_avg = PSD_avg / Nf;

% Convert to dB
PSD_avg_dB = 10*log10(PSD_avg + 1e-12);  % avoid log(0)
end