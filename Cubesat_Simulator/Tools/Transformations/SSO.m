function [a_SSO, RAAN_SSO, i_SSO, e_SSO] = SSO(Re,mu,J2,n_orbits,...
                                        Initial_Date,Spring_Equinox,Hour,e)
%% Determine the semimajor axis as a function of the number of orbits in a day
T = 86400/n_orbits;
a_SSO = (mu*(T/(2*pi))^2)^(1/3);

%% Calculate RAAN of SSO
%-------------------------------------------------------------------------
%  - Initial_Date: Start of the propagation (UTC)
%  - Spring Equinox: The Nearest Spring Equinox (UTC). Reference:
%    http://www.astropixels.com/ephemeris/soleq2001.html
%  - Hour: Local hour from 0 to 24
%-------------------------------------------------------------------------

alfa = 360/(365.242199)*(juliandate(Initial_Date)-...
       juliandate(Spring_Equinox));

if alfa<0
    alfa = alfa+360;   
end

RAAN_SSO = alfa+(Hour-12)*360/24;

if RAAN_SSO >= 360
    RAAN_SSO = RAAN_SSO-360;
end

%% Calculate eccentricity and inclination
e_SSO = e;

i_SSO = acosd(-2*pi/(365.242199*86400)*(1.5*Re^2*sqrt(mu/a_SSO^3)*J2/(a_SSO^2*(1-e^2)^2))^-1);

end
    