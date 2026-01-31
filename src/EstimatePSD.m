function [PSD, PSD_db, PSD_theoretical, PSD_theoretical_dB, f] = EstimatePSD(v_tilde, f, T, Ns, Ts)
% EstimatePSD - Estimate Power Spectral Density using FFT
% Inputs:
%   v_tilde - baseband transmit signal
%   f       - frequency vector
%   T       - symbol period
%   Ns      - number of samples
%   Ts      - sampling period
% Outputs:
%   PSD      - estimated PSD
%   PSD_db   - estimated PSD in dB
%   PSD_theoretical - theoretical PSD
%   PSD_theoretical_dB - theoretical PSD in dB
%   f        - frequency vector

Vf = fftshift(fft(v_tilde));
PSD = (Vf .* conj(Vf)) * Ts / Ns;
PSD_db = 10*log10(PSD);

% Theoretical PSD
HT_f = T * sinc(f*T);
PSD_theoretical = (1/T) * abs(HT_f).^2;
PSD_theoretical_dB = 10*log10(PSD_theoretical);
end
