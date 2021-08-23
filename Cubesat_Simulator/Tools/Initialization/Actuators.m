%% Thrusters
ThrusterConfiguration                                                       % Elaboration of configuration matrix

FEEP.thrust   = 30e-6;                                                      % Maximum Thrust [N]
FEEP.quant    = 0.1e-6;                                                     % Quantization [N]
FEEP.noise    = 0.01e-6;                                                    % Thrust Noise [N/sqrt(Hz)]
FEEP.rate     = 0.5;                                                        % Thrust Update rate [s]
FEEP.response = 15e-6;

%% Reaction Wheels                                                   
RW1.pos      = [1; 1; 1]./sqrt(3);                                          % RW position in body frame [m]
RW1.speed    = 8000*2*pi/60;                                                % RW maximum angular speed [rad/s]
RW1.torque   = 2.3E-4;                                                      % RW maximum torque [N·m]
RW1.momentum = 1.77E-3;                                                     % RW maximum angular momentum
RW1.bits     = 12;                                                          % RW quantization
RW1.error    = 5;                                                           % RW percentage of error (3-sigma)                                                         
RW1.rate     = 0.125;                                                       % Update rate [s]

RW2.pos      = [-1; 1; 1]./sqrt(3);
RW2.speed    = 8000*2*pi/60;                                                % RW maximum angular speed [rad/s]
RW2.torque   = 2.3E-4;                                                      % RW maximum torque [N·m]
RW2.momentum = 1.77E-3;                                                     % RW maximum angular momentum
RW2.bits     = 12;                                                          % RW quantization
RW2.error    = 5;                                                           % RW percentage of error (3-sigma)   
RW2.rate     = 0.125;                                                       % Update rate [s]

RW3.pos      = [-1; -1; 1]./sqrt(3); 
RW3.speed    = 8000*2*pi/60;                                                % RW maximum angular speed [rad/s]
RW3.torque   = 2.3E-4;                                                      % RW maximum torque [N·m]
RW3.momentum = 1.77E-3;                                                     % RW maximum angular momentum
RW3.bits     = 12;                                                          % RW quantization
RW3.error    = 5;                                                           % RW percentage of error (3-sigma)   
RW3.rate     = 0.125;                                                       % Update rate [s]

RW4.pos      = [1; -1; 1]./sqrt(3); 
RW4.speed    = 8000*2*pi/60;                                                % RW maximum angular speed [rad/s]
RW4.torque   = 2.3E-4;                                                      % RW maximum torque [N·m]
RW4.momentum = 1.77E-3;                                                     % RW maximum angular momentum
RW4.bits     = 12;                                                          % RW quantization
RW4.error    = 5;                                                           % RW percentage of error (3-sigma)   
RW4.rate     = 0.125;                                                       % Update rate [s]

A_rw =[RW1.pos, RW2.pos, RW3.pos, RW4.pos];                                 % Configuration matrix of reaction wheels

%% Magnetorquers
mag.sat     = 0.2;                                                          % Maximum magnetic moment [A·m^2]
mag.error   = 5;                                                            % Percentage of error (3-sigma)
mag.rate    = 0.125;                                                        % Magnetorquer rate [s]
mag.noise   = 1e-6;                                                         % Measurement noise of magnetic field [T]
mag.bits    = 16;                                                           % Magnetorquer Quantization
A_mag       = [1 1 0 0 0 0;                                                 % Configuration matrix of magnetorquers
               0 0 1 1 0 0;
               0 0 0 0 1 1];