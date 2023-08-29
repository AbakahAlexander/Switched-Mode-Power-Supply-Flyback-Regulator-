% Step 1: Generate a random continuous-time analog signal
Fs = 10000; % Sampling rate (10 kHz)
duration = 1; % Duration of the signal in seconds
t = 0:1/Fs:duration-1/Fs; % Time vector
x_t = rand(size(t)) - 0.5; % Random continuous-time analog signal between -0.5 and 0.5

% Step 3: Apply the PCM encoder function to the generated analog signal with n = 8 bits.
n_bits = 8; % Number of bits for quantization
pcm_signal = pcm_encoder(x_t, n_bits);

% Step 4: Plot the original analog signal and the quantized PCM signal on separate graphs.
% Plot the original analog signal
figure;
plot(t, x_t);
title('Original Analog Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Plot the quantized PCM signal
figure;
plot(t, pcm_signal);
title('Quantized PCM Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Step 2: Implement the PCM encoder function
function pcm_signal = pcm_encoder(x_t, n_bits)
    % Maximum and minimum values for the quantization range
    max_val = max(x_t);
    min_val = min(x_t);
    
    % Calculate the step size of the quantization
    step_size = (max_val - min_val) / (2^n_bits);
    
    % Quantize the analog signal using PCM
    quantized_signal = floor((x_t - min_val) / step_size) * step_size + step_size/2 + min_val;
    
    % Clip values that go beyond the quantization range
    quantized_signal(quantized_signal > max_val) = max_val;
    quantized_signal(quantized_signal < min_val) = min_val;
    
    pcm_signal = quantized_signal;
end