m=load("/MATLAB Drive/MobileSensorData/sensorlog_20250331_200313.mat");
x = m.Acceleration.X;
y = m.Acceleration.Y;
z = m.Acceleration.Z;
t_s=m.Acceleration.Timestamp;
mag = sqrt(sum(x.^2 + y.^2 + z.^2, 2)); % to find magnitude of acceleration
plot(t_s,mag)
title("acceleration magnitude");
mag_2 = mag-mean(mag);
fs = 10; 
fc = 3; % Cutoff frequency for low-pass filter
[b, c] = butter(2, fc/(fs/2), 'low');
Acc_Mag_Filtered = filtfilt(b, c, mag_2);
[pks, locs] = findpeaks(Acc_Mag_Filtered, 'MinPeakHeight', mean(Acc_Mag_Filtered) + std(Acc_Mag_Filtered), 'MinPeakDistance', fs/2);
step_count = length(locs);
figure;
plot(Acc_Mag_Filtered);
hold on;
plot(locs, pks, 'ro');
title(['Step Count: ', num2str(step_count)]);
xlabel('Sample Index');
ylabel('Filtered Acceleration Magnitude');
grid on;
hold off;
