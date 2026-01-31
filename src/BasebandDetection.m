function [ah, y] = BasebandDetection(r_tilde, hT, Ts, eta, Na)
% BasebandDetection - Perform baseband detection with matched filter
% Inputs:
%   r_tilde - baseband received signal
%   hT      - transmit filter (matched filter)
%   Ts      - sampling period
%   eta     - samples per symbol
%   Na      - number of symbols
% Outputs:
%   ah - detected bits
%   y  - matched filter output

y = conv(r_tilde, hT) * Ts;         % Detector (matched filter)
samplePoints = eta:eta:length(y);   % Sampling points at symbol instants
ah = y(samplePoints) > 0;           % Decision device
ah = ah(1:Na);
end
