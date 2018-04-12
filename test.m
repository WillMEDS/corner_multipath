close all;
clearvars;
clc;

% for theta = 1:1:89
%     wall([1,1], theta, 1, 1, 1, 1);
% end

f = 1;
gam = 0.5;
noise_fig = 1;
L = 1;
B = 1;
g = 1;
p_t = 1;
radar_pos = [1,1];
target_pos = [6,6];
target_vel = 1;
m = 3;
steptime = 0.1;
endtime = 5;
radar(m, radar_pos, target_pos, target_vel, gam, p_t, g, f, noise_fig, L, B, steptime, endtime);

