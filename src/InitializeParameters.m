function [Na, eta, T, Ts, fc, Ns, f, Ts_vec] = InitializeParameters()
% InitializeParameters - Initialize system parameters
% Outputs:
%   Na   - Message word length (in bits)
%   eta  - Upsampling factor
%   T    - Symbol period
%   Ts   - Sampling period
%   fc   - Carrier frequency
%   Ns   - Total number of samples
%   f    - Frequency vector
%   Ts_vec - Sampling period vector

Na = 128;        % Message word length (in bits)
eta = 64;        % Upsampling factor
T = 0.01;        % Symbol period
Ts = T/eta;      % Sampling period
fc = 400;        % Carrier frequency
Ns = Na * eta;   % Total number of samples
f = (-Ns/2 : Ns/2-1) / (Ns*Ts);
Ts_vec = Ts;
end
