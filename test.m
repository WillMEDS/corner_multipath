close all;
clearvars;
clc;

% for theta = 1:1:89
%     wall([1,1], theta, 1, 1, 1, 1);
% end

f = 1;
gam = 1;
noise_fig = 1;
L = 1;
B = 1;
g = 1;
p_t = 1;
radar_pos = [1,1];
m = 1;
theta = 60;
radar(m, theta, radar_pos, gam, p_t, g, f, noise_fig, L, B);