function [r,v] = coe2sv(a, e, i, RAAN, w, TA)
%-------------------------------------------------------------------------
% This function computes the state vector (r,v) from the
% classical orbital elements (coe).
%
% mu - gravitational parameter (mˆ3/sˆ2)
% coe - orbital elements [a, e, i, RA, w, TA]
% a - semimajor axis (m)
% h = angular momentum (mˆ2/s)
% e = eccentricity
% RA = right ascension of the ascending node (rad)
% i = inclination of the orbit (rad)
% w = argument of perigee (rad)
% TA = true anomaly (rad)
% R3_w - Rotation matrix about the z-axis through the angle w
% R1_i - Rotation matrix about the x-axis through the angle i
% R3_W - Rotation matrix about the z-axis through the angle RA
% Q_pX - Matrix of the transformation from perifocal to
% ECI
% rp - position vector in the perifocal frame (m)
% vp - velocity vector in the perifocal frame (m/s)
% r - position vector in the geocentric equatorial frame(m)
% v - velocity vector in the geocentric equatorial frame(m/s)
%
% ------------------------------------------------------------------------
%% Inputs
mu = 3.986004418e14;
h  = sqrt(a*(1-e^2)*mu);

%% r and v in PQW
rp = (h^2/mu) * (1/(1 + e*cosd(TA))) * (cosd(TA)*[1;0;0] ...
+ sind(TA)*[0;1;0]);
vp = (mu/h) * (-sind(TA)*[1;0;0] + (e + cosd(TA))*[0;1;0]);

%% Rotation matrixes
R3_W = [ cosd(RAAN) sind(RAAN) 0; -sind(RAAN) cosd(RAAN) 0; 0 0 1];
R1_i = [1 0 0; 0 cosd(i) sind(i); 0 -sind(i) cosd(i)];
R3_w = [ cosd(w) sind(w) 0; -sind(w) cosd(w) 0 ;0 0 1];

Q_pX = R3_W'*R1_i'*R3_w';

%% r and v are column vectors
r = Q_pX*rp;
v = Q_pX*vp;