%% Size 
b      = 0.1;                                                               % Side length [m] 
A      = [2*b^2; 2*b^2; b^2; b^2; 2*b^2; 2*b^2];                            % Area [m^2]
d_face = [b/2; b/2; b; b; b/2; b/2];                                        % Distance to geometric center of the face from origin

%% Mass
% Thoretical values
m   = 1.33*2;                                                               % Mass [kg]

Ixx = 1/12*m*(b^2+(2*b)^2);
Iyy = 1/12*m*(b^2+b^2);
Izz = 1/12*m*(b^2+(2*b)^2);
I   = [Ixx 0   0;                                                           % Inertia Tensor [kg·m^2]
       0   Iyy 0; 
       0   0   Izz];
   
CG = [0; 0; 0];                                                             % Initial center of gravity in body frame

% To include uncertainty in the mass properties
I_error = 0.01*Ixx*0;
I_real  = [Ixx+I_error  I_error    -I_error;                                                           
           I_error      Iyy-I_error I_error; 
          -I_error      I_error     Izz+I_error];
CG_real = 2e-4*[1;1;-1]*0;

%% Face normals (Atmospheric Drag Model)
n = [1  0  0;                                                                
    -1  0  0;
     0  1  0;
     0 -1  0;
     0  0  1;
     0  0 -1];

%% Magnetism
Dipole_SC = m/1500*ones(1,3);                                               % Spacecraft residual dipole [A·m^2]  