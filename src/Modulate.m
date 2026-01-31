function [vc, t_v] = Modulate(v_tilde, fc, t_v)
% Modulate - Modulate baseband signal to bandpass
% Inputs:
%   v_tilde - baseband transmit signal
%   fc      - carrier frequency
%   t_v     - time vector
% Outputs:
%   vc  - bandpass modulated signal
%   t_v - time vector

vc = v_tilde .* cos(2*pi*fc*t_v);
end
