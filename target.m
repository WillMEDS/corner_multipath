function [M,hit_info] = target(radar_x,radar_y,target_x,target_y,target_size,wall1_y,wall2_y,input_angle)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% RCS =1 dbsm


% mirror_y = (wall2_y - target_y)*2 + target_y;


% 
% 
% %% reflect zero times
% 
% 
% %% define ru she jiao , reflect one time
% 
% max_input_angle_1 = atan((target_left_after_reflect(2) - radar_y)/(target_left_after_reflect(1) - radar_x));
% min_input_angle_1 = atan((target_right_after_reflect(2) - radar_y)/(target_right_after_reflect(1) - radar_x));
% 
% D_max_input_angle_1 = rad2deg(max_input_angle_1);
% D_min_input_angle_1 = rad2deg(min_input_angle_1);

%% reflect for multi times, using for loop

%% fan she dian zuo biao
target_left_after_reflect = [target_x-(0.5 * target_size),target_y];
target_right_after_reflect = [target_x + (0.5 * target_size), target_y];

target_0_x = ((target_y - radar_y)/tand(input_angle)) + radar_x;
if ((target_0_x > target_left_after_reflect(1)) && (target_0_x < target_right_after_reflect(1))) == 1
    M = 0;
    fprintf( 'The radar hit the target with %d reflection \n', M);
    hit_info = true;
else
        for i = 1:20      %% i: reflect times
            if rem(i,2) == 1 
                y_after_mirror = (i+1) * wall2_y - (i-1) * wall1_y - target_y;
            else
                y_after_mirror = i * (wall2_y - wall1_y) + target_y;
            end
        
        
        
        target_mult_x = ((y_after_mirror - radar_y)/tand(input_angle)) + radar_x;
        
        
        
        
        
            if ((target_mult_x > target_left_after_reflect(1)) && (target_mult_x < target_right_after_reflect(1))) == 1
                 M = i;
                 fprintf( 'The radar hit the target with %d reflection \n', M);
                 hit_info = true;
                 break
            end
            while i > 19
                fprintf(' the radar miss the target \n')
                hit_info =false;
                M = 20;
                break
            end
            
                 
            end
        end

      
end
    
     
    



