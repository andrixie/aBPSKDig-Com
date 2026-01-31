function ah = DiscreteChannel(a, errorRate)
% DiscreteChannel: Simulates a discrete-time digital channel
% Inputs:
%   a         - input bit vector (transmitted message)
%   errorRate - probability of bit flipping (0 to 1)
% Output:
%   ah        - output bit vector (received message)

ah = xor(a, rand(1, length(a)) < errorRate);
end
