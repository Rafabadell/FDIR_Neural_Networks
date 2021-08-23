%% Earth model: WGS84
Re = 6371008.8;                                                             % Radius of the Earth [m]
mu = 3.986004418e14;                                                        % Standard Gravitational Parameter [m^3/s^2]
J2 = 0.0010826269;                                                          % Zonal Harmonic Coefficient
g  = 9.80665;                                                                % Mean Earth gravity acceleration [m/s^2]

w_Earth = 7.292115e-5;                                                      % Earth spin rate [Rad/s]

%% Define the spacecraft orbit
% Calculate the Sun-Synchronous Orbit(SSO)
n_orbits       = 15.5;                                                      % Orbits in a day (24 hours)
Initial_Date   = [2019,03,01,12,00,00];                                     % [Year, Month, Day, Hour, Minute, Second] Change it manually in Atmospheric Block!!!
Spring_Equinox = [2019,03,20,21,58,00];
Hour           = 12;                                                        % Local Hour (Noon-Midnight)
e              = 0;                                                         % Eccentricity

[a_SSO, RAAN_SSO, i_SSO, e_SSO] = SSO(Re,mu,J2,n_orbits,...
                                       Initial_Date,Spring_Equinox,Hour,e);
                                         
initial_date_JD = juliandate(Initial_Date);

% Classical Orbital Elements (COE)
a    = a_SSO;                                                               % Semimajor axis [m]
e    = e_SSO;                                                               % Eccentricity
i    = i_SSO;                                                               % Inclination [º]
RAAN = RAAN_SSO;                                                            % Right Ascension of Ascending Node [º]
w    = 0;                                                                   % Argument of Periapsis [º]
TA   = 360*rand;                                                            % True Anomaly [º]

% COE to ECI (Earth-Centered Inertial) 
[r,v] = coe2sv(a, e, i, RAAN, w, TA);
rx0   = r(1);
ry0   = r(2);
rz0   = r(3);
vx0   = v(1);
vy0   = v(2);
vz0   = v(3);

%% Define the spacecraft attitude
% Initial angular speed of SC [rad/s]
w_SC_0 = [0; 0; (-2*pi/(24*3600/n_orbits))*rand];                           % After detumbling

% Initial attitude (Pointing to the Earth)
i_Pointing = -r/norm(r);
k_Pointing = -cross(r,v)/norm(cross(r,v));
j_Pointing = -cross(i_Pointing,k_Pointing);

DCM_Pointing_ECI_0 = [i_Pointing'; j_Pointing'; k_Pointing'];               % Initial DCM LVLH/ECI

q_0   = dcm2quat(DCM_Pointing_ECI_0);                                       % Initial Quaternion to propagate the attitude                                     

%error = eul2quat([-5 5 5]*pi/180);                                         % Include error after detumbling
%q_0   = quatmultiply(q_0,error);

% Gain to drive the quaternion norm to 1 (6DOF Dynamics)
k_quat = 0.001;                                                             % Proportional to angular speed                                                   

%% Environment
% Third bodies properties
mu_Moon = 4.9048695e12;                                                     % [m^3/s^2]
mu_Sun  = 1.32712440018e20;                                                 % [m^3/s^2]

% Perturbations (On-->1; Off-->0)                                                                
Env_J2    = 1;
Env_Sun   = 1;
Env_Moon  = 1;
Env_Drag  = 1;
Env_TGG   = 1;
Env_TMag  = 1;