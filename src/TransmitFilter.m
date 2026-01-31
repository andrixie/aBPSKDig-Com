function [v_tilde, t_v, Ns] = TransmitFilter(s, eta, T, Na)
% TransmitFilter - Apply transmit pulse shaping filter
% Inputs:
%   s    - mapped symbols
%   eta  - upsampling factor
%   T    - symbol period
%   Na   - number of symbols
% Outputs:
%   v_tilde - baseband transmit signal
%   t_v     - time vector
%   Ns      - total number of samples

Ns = Na * eta;
Ts = T/eta;
hT = ones(1, eta) * 1/sqrt(T);  % Rectangular pulse shaping filter

v_up = upsample(s, eta);         % Upsample symbols
v_tilde = conv(v_up, hT);        % Baseband transmit signal
v_tilde = v_tilde(1:Ns);         % Truncate
t_v = (0:length(v_tilde)-1) * Ts; % Time vector
end
