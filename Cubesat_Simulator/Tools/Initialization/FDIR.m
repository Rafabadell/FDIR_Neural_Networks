%% Gyroscope
% Sudden Death
th_SD_gyr_der  = 0.01;                                                      % Threshold of the derivative of the signal
th_SD_gyr_null = gyr.ARW*3/sqrt(gyr.rate);                                  % Threshold of null signal due to Sudden Death

% Frozen signal
th_FR_gyr  = 1.2*gyr.ARW/sqrt(gyr.rate);                                    % Threshold of the standard deviation of the signal
win_length = 60/gyr.rate;                                                   % Window length for online statistics

% Level 2
sigma1 = 2e-5;                                                              % Standard Deviation of fault free r1, r2 and r3 residuals
sigma2 = 4.2e-5;                                                            % Standard Deviation of fault free r4, r5, r6 and r7 residuals

th_2_gyr = 15;                                                              % Threshold of the GLR test

%% Reaction Wheels
win_length_RW = 60/RW1.rate;                                                % Window length for online statistics
T_friction    = 1e-8;                                                    
th_RW         = 1e-7;                                                       % Threshold

%% Thrusters
win_length_T = 120;                                                         % Window length for online statistics
th_thruster  = 8;                                                           % Threshold of the GLR tes