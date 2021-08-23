%% Orbit
e_max_orb = [0.001; 0.01; 0.01; 0.001; 1000; 1000];                         % Maximum error of Gauss' Variational Parameters to elaborate Q matrix
u_max_orb = FEEP.thrust;                                                    % Maximum control input to define R matrix

%% Attitude
e_max_att = [0.01; 0.01; 0.01; 0.01; 0.01; 0.01];                           % Maximum error ([q1,q2,q3,wx,wy,wz]) to elaborate Q matrix
u_max_att = min([RW1.torque; RW2.torque; RW3.torque; RW4.torque]);          % Maximum control input to define R matrix

h_RW   = [-RW1.momentum; RW2.momentum; -RW3.momentum; RW4.momentum]/2;      % Initial angular momentum of each wheel
h_rw_0 = A_rw*h_RW;                                                         % Initial total angular momentum of the reactions wheels
h_ref  = h_RW;                                                              % Reference used in desaturation problem

K_det = 0.0002;