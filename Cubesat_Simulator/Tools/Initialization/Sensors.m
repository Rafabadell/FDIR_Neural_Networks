%% GNSS
GNSS.rate = 1;                                                              % GNSS rate [s]
GNSS.pos  = [1; 1; 1]*10;                                                   % Position accuracy [m] (Standard Deviation)
GNSS.vel  = [1; 1; 1]*0.25;                                                 % Velocity acccuracy [m/s] (Standadard Deviation)

%% Gyroscope                      
gyr.rate      = 0.25;                                                       % Gyro update rate [s]                                                 % Gyro Damping ratio
gyr.scale     = 0.02;                                                       % Gyro Scale factor (1-sigma) [%]
gyr.bias      = 0.12*pi/180/3600;                                           % Gyro long term bias (Allan Variance) [rad/s]
gyr.range     = 400*pi/180;                                                 % Gyro range (+/-) [rad/s]
gyr.ARW       = 0.017*(1/60)*(pi/180);                                      % PSD or Angular Random Walk [rad/s/sqrt(Hz)]
gyr.RRW       = 0.35*pi/180/(3600)^(3/2);                                   % Rate Random Walk
gyr.bits      = 24;                                                         % For Quantization

gyr.H = [sind(54.7)  cosd(54.7)*sind(15) -cosd(54.7)*cosd(15);              % Configuration matrix
         sind(54.7)  cosd(54.7)*cosd(15) -cosd(54.7)*sind(15);
         sind(54.7)  cosd(54.7)*sind(45)  cosd(54.7)*cosd(45);
         sind(54.7) -cosd(54.7)*sind(15)  cosd(54.7)*cosd(15);
         sind(54.7) -cosd(54.7)*cosd(15)  cosd(54.7)*sind(15);
         sind(54.7) -cosd(54.7)*sind(45) -cosd(54.7)*cosd(45)];
 
%% Star tracker 
star.rate = 1;                                                              % Star tracker update rate(s)
star.accu = [70;5;5]*(1/3600)*(pi/180);                                     % Star tracker accuracy 1-sigma (rad)