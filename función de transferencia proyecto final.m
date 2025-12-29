clear; clc; close all;

% Laplace variable for transfer functions
s = tf('s');

% Motor electrical parameters
Kt = 0.026;        % torque constant
Kb = 0.5;          % back emf constant
R  = 6.8;          % armature resistance
L  = 0.000057;     % armature inductance

% Mechanical parameters
Jm = 0.00000688;   % motor inertia
Jc = 0.002516;     % satellite inertia

% Gear ratio
n  = 300;

% Viscous friction (not given, assumed zero)
b_eq = 0;

% Total inertia seen by the motor
J_eq = Jm + (Jc / n^2);

% Combined electrical + mechanical denominator
Den = (J_eq*s + b_eq) * (L*s + R) + Kt*Kb;

% Transfer function from voltage to motor speed
G_omega_m_V = Kt / Den;

% Transfer function from voltage to satellite angle
G_theta_V = (1/(n*s)) * G_omega_m_V;

% Transfer function from disturbance torque to satellite angle
G_theta_tau = -(L*s + R) / (n^2 * s * Den);

% PI controller parameters
Kp = 0.10927;
ti = 147;

% PI controller
C = Kp * (1 + 1/(ti*s));

% Open-loop system
L_open = C * G_theta_V;

% Closed-loop transfer function (angle tracking)
T_cl = feedback(L_open, 1);

% Sensitivity function
S = feedback(1, L_open);

% Closed-loop disturbance response
T_d = G_theta_tau * S;

% Open-loop plant response
figure;
step(G_theta_V);
grid on;
title('Plant response: Voltage to Load Angle');

% Closed-loop tracking response
figure;
step(T_cl);
grid on;
title('Closed-loop response with PI controller');

% Stability margins
figure;
margin(L_open);
grid on;
title('Open-loop stability margins');

% Pole-zero map of the closed-loop system
figure;
pzmap(T_cl);
grid on;
title('Closed-loop pole-zero map');

% Disturbance rejection test
Td_step = 0.0189633675;
figure;
step(Td_step * T_d);
grid on;
title('Response to step disturbance torque');

% Display poles and margins in command window
pole(T_cl)

[Gm,Pm,Wcg,Wcp] = margin(L_open);
Gm, Pm, Wcg, Wcp