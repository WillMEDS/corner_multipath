close all;
clearvars;

scene_x = 15; % Plot x dimension in m
scene_y = 15; % Plot y dimension in m

radar_pos = [1 1]; % x y position of the radar
M = 1; % Number of bounces considered

target_pos = [10 7];

wall1_x = 7; % x coordinate of wall 1
wall1_y = 5; % y coordinate of wall 1
wall2_x = 5; % x coordinate of wall 1
wall2_y = 8; % y coordinate of wall 1

%clculate the angle to the target
if mod(M, 2) == 1
    y_dist = target_pos(2) - radar_pos(2) + (M-1) * (wall2_y - wall1_y) + 2 * (wall2_y - target_pos(2));
else 
    y_dist = target_pos(2) - radar_pos(2) + M * (wall2_y - wall1_y);
end

 x_dist = target_pos(1) - radar_pos(1);
 beam_angle = atan(y_dist/x_dist);
 disp(beam_angle*180/pi);
 


figure;
hold on;
plot([wall1_x, wall1_x, scene_x], [0, wall1_y, wall1_y], 'k'); % plot wall 1
plot([wall2_x, wall2_x, scene_x], [scene_y, wall2_y, wall2_y], 'k'); % plot wall 2
scatter(radar_pos(1), radar_pos(2));
scatter(target_pos(1), target_pos(2));
xlim([0, scene_x]);
ylim([0, scene_y]);