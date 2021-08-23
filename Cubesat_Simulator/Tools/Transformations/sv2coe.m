function [a, e, i, RA, w, TA] = sv2coe(R,V)
%-------------------------------------------------------------------------
% This function computes the classical orbital elements (coe)
% from the state vector (R,V).
%
% mu - gravitational parameter (mˆ3/sˆ2)
% R - position vector in ECI (m)
% V - velocity vector in ECI (m)
% r, v - the moduli of R and V
% vr - radial velocity component (m/s)
% H - the angular momentum vector (mˆ2/s)
% h - the moduli of H (mˆ2/s)
% i - inclination of the orbit (rad)
% N - the node line vector (mˆ2/s)
% n - the moduli of N
% cp - cross product of N and R
% RA - right ascension of the ascending node (rad)
% E - eccentricity vector
% e - eccentricity (moduli of E)
% eps - a small number below which the eccentricity is
% considered to be zero
% w - argument of perigee (rad)
% TA - true anomaly (rad)
% a - semimajor axis (m)
% coe - vector of orbital elements [a, e, i, RA, w, TA]
%
% ------------------------------------------------------------------------
%% Inputs
mu = 3.986004418e14;
eps = 1.e-10;

r = norm(R);
v = norm(V);
vr = dot(R,V)/r;

H = cross(R,V);
h = norm(H);

%% Inclination
i = acos(H(3)/h);

%% Node line
N = cross([0 0 1],H);
n = norm(N);

%% Right Ascension
if n ~= 0
    RA = acos(N(1)/n);
    if N(2) < 0
        RA = 2*pi - RA;
    end
else
    RA= 0;                 % No defined asceding node (Equatorial orbit)
end

%% Eccentricity
E = 1/mu*((v^2 - mu/r)*R - r*vr*V);
e = norm(E);

%% Argument of periapsis
if n ~= 0
    if e > eps
        w = acos(dot(N,E)/n/e);
        if E(3) < 0
            w = 2*pi - w;
        end
    else
        w = 0;             % No defined periapsis (Circular orbit)    
    end
else
    w = 0;                 % No defined ascending node (Equatorial orbits)
end

%% True anomaly
if e > eps
    TA = acos(dot(E,R)/e/r);
    if vr < 0
        TA = 2*pi - TA;
    end
else
    cp = cross(N,R);
    if cp(3) >= 0
        TA = acos(dot(N,R)/n/r);
    else
        TA = 2*pi - acos(dot(N,R)/n/r);
    end
end

%% Semimajor axis
a = h^2/mu/(1 - e^2);
