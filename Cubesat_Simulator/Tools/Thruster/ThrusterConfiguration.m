%% Thruster Configuration (theoretical)
% Origen to determine the vectorial thrust
Origen1 = [25; -50; 25]/1000;
Origen2 = [25; -50; -25]/1000;
Origen3 = [-25; -50; -25]/1000;
Origen4 = [-25; -50; 25]/1000;

% Unit Thrust(F) and Moment(M)
F1_pos = [16; -100; 16/tand(22.5)]/1000;
F1 = -(F1_pos-Origen1)/norm(F1_pos-Origen1);
M1 = cross(F1_pos, F1);

F2_pos = [16/tand(22.5); -100; 16]/1000;
F2 = -(F2_pos-Origen1)/norm(F2_pos-Origen1);
M2 = cross(F2_pos, F2);

F3_pos = [16/tand(22.5); -100; -16]/1000;
F3 = -(F3_pos-Origen2)/norm(F3_pos-Origen2);
M3 = cross(F3_pos, F3);

F4_pos = [16; -100; -16/tand(22.5)]/1000;
F4 = -(F4_pos-Origen2)/norm(F4_pos-Origen2);
M4 = cross(F4_pos, F4);

F5_pos = [-16; -100; -16/tand(22.5)]/1000;
F5 = -(F5_pos-Origen3)/norm(F5_pos-Origen3);
M5 = cross(F5_pos, F5);

F6_pos = [-16/tand(22.5); -100; -16]/1000;
F6 = -(F6_pos-Origen3)/norm(F6_pos-Origen3);
M6 = cross(F6_pos, F6);

F7_pos = [-16/tand(22.5); -100; 16]/1000;
F7 = -(F7_pos-Origen4)/norm(F7_pos-Origen4);
M7 = cross(F7_pos, F7);

F8_pos = [-16; -100; 16/tand(22.5)]/1000;
F8 = -(F8_pos-Origen4)/norm(F8_pos-Origen4);
M8 = cross(F8_pos, F8);

A_FEEP =[F1, F2, F3, F4, F5, F6, F7, F8;
         M1, M2, M3, M4, M5, M6, M7 ,M8];

%% Thruster Configuration (real)
% Origen to determine the vectorial thrust
Origen1 = Origen1-CG_real;
Origen2 = Origen2-CG_real;
Origen3 = Origen3-CG_real;
Origen4 = Origen4-CG_real;

% Unit Thrust(F) and Moment(M)
F1_pos = [16; -100; 16/tand(22.5)]/1000-CG_real;
F1 = -(F1_pos-Origen1)/norm(F1_pos-Origen1);
M1 = cross(F1_pos, F1);

F2_pos = [16/tand(22.5); -100; 16]/1000-CG_real;
F2 = -(F2_pos-Origen1)/norm(F2_pos-Origen1);
M2 = cross(F2_pos, F2);

F3_pos = [16/tand(22.5); -100; -16]/1000-CG_real;
F3 = -(F3_pos-Origen2)/norm(F3_pos-Origen2);
M3 = cross(F3_pos, F3);

F4_pos = [16; -100; -16/tand(22.5)]/1000-CG_real;
F4 = -(F4_pos-Origen2)/norm(F4_pos-Origen2);
M4 = cross(F4_pos, F4);

F5_pos = [-16; -100; -16/tand(22.5)]/1000-CG_real;
F5 = -(F5_pos-Origen3)/norm(F5_pos-Origen3);
M5 = cross(F5_pos, F5);

F6_pos = [-16/tand(22.5); -100; -16]/1000-CG_real;
F6 = -(F6_pos-Origen3)/norm(F6_pos-Origen3);
M6 = cross(F6_pos, F6);

F7_pos = [-16/tand(22.5); -100; 16]/1000-CG_real;
F7 = -(F7_pos-Origen4)/norm(F7_pos-Origen4);
M7 = cross(F7_pos, F7);

F8_pos = [-16; -100; 16/tand(22.5)]/1000-CG_real;
F8 = -(F8_pos-Origen4)/norm(F8_pos-Origen4);
M8 = cross(F8_pos, F8);

A_FEEP_real =[F1, F2, F3, F4, F5, F6, F7, F8;
         M1, M2, M3, M4, M5, M6, M7 ,M8];