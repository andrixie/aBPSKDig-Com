function [ro_tilde, ro] = Demodulate(rc, fc, t_v, hT, Ts)
% Demodulate - Demodulate bandpass signal back to baseband
% Inputs:
%   rc   - received bandpass signal
%   fc   - carrier frequency
%   t_v  - time vector
%   hT   - transmit filter
%   Ts   - sampling period
% Outputs:
%   ro_tilde - demodulated signal before matched filter
%   ro       - demodulated signal after matched filter

ro_tilde = rc .* cos(2*pi*fc*t_v);  % Coherent demodulation
ro = conv(ro_tilde, hT) * Ts;       % Matched filter output
end
