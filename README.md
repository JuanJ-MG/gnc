GNC Projects

This repo contains a small set of guidance, navigation, and control simulations focused on spacecraft dynamics, state estimation, and control. The goal is to show practical understanding of GNC fundamentals rather than build flight-ready code.

Projects

Orbit Determination (EKF, Python)
Nonlinear two-body orbit propagation with an EKF estimating position and velocity from noisy position measurements, including random measurement dropouts.

Attitude Determination (MEKF, Python)
Quaternion-based attitude estimation using gyro, sun sensor, and magnetometer measurements. The filter estimates both attitude and gyro bias and remains stable under sensor noise and dropouts.

Attitude Control (MATLAB)
Linearized satellite and actuator dynamics with PI control for attitude regulation and disturbance rejection.

