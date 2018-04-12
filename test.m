close all;
clearvars;
clc;

% for theta = 1:1:89
%     wall([1,1], theta, 1, 1, 1, 1);
% end

f = 10e9;
gam = 0.5;
noise_fig = 10^(1.5/10);
L = 10^(4/10);
B = 108e6;
g = 10^(25/10);
p_t = 10e3;
radar_pos = [1,1];
target_pos = [6,6];
target_vel = 5;
steptime = 0.005;
endtime = 5;
radar(radar_pos, target_pos, target_vel, gam, p_t, g, f, noise_fig, L, B, steptime, endtime);

