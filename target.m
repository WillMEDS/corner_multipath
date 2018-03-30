function [M,hit_info] = target(radar_x,radar_y,target_x,target_y,target_size,wall1_x,wall1_y,wall2_x,wall2_y,input_angle)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% RCS =1 dbsm


mirror_y = (wall2_y - target_y)*2 + target_y;

%% fan she dian zuo biao
target_left_after_reflect = [target_x-(0.5 * target_size),mirror_y];
target_right_after_reflect = [target_x + (0.5 * target_size), mirror_y];

%% define ru she jiao , fan she yi ci
max_input_angle = atan((target_left_after_reflect(2) - radar_y)/(target_left_after_reflect(2) - radar_x));
min_input_angle = atan((target_right_after_reflect(2) - radar_y)/(target_right_after_reflect(2) - radar_x));

D_max_input_angle = rad2deg(max_input_angle);
D_min_input_angle = rad2deg(min_input_angle);

if (input_angle < D_max_input_angle) && (input_angle > D_min_input_angle) ==1
    M = 1;
    hit_info = true;
    disp("the radar hit the target")
else
    M = 0;
    hit_info = false;
    disp("the radar miss the target")
end

end
