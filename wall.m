function [ M, R ] = wall(radar_pos, theta, M, target_pos, target_size)

R = 0; % Return 0 range if no detection is made

scene_x = 15; % Plot x dimension in m
scene_y = 15; % Plot y dimension in m

radar_pos = radar_pos; % x y position of the radar
%M = 1; % Number of bounces considered

%target_pos = [10 7];
theta = theta; % angle of radar beam in degrees

wall1_x = 7; % x coordinate of wall 1
wall1_y = 5; % y coordinate of wall 1
wall2_x = 5; % x coordinate of wall 1
wall2_y = 8; % y coordinate of wall 1

%% Code to calculate beam angle from radar to target with M bounces (depreciated)
%{
%clculate the angle to the target
if mod(M, 2) == 1
    y_dist = target_pos(2) - radar_pos(2) + (M-1) * (wall2_y - wall1_y) + 2 * (wall2_y - target_pos(2));
else 
    y_dist = target_pos(2) - radar_pos(2) + M * (wall2_y - wall1_y);
end

 x_dist = target_pos(1) - radar_pos(1);
 beam_angle = atan(y_dist/x_dist);
 disp(beam_angle*180/pi);
%} 

%% Plot the walls
figure;
hold on;
plot([wall1_x, wall1_x, scene_x], [0, wall1_y, wall1_y], 'k'); % plot wall 1
plot([wall2_x, wall2_x, scene_x], [scene_y, wall2_y, wall2_y], 'k'); % plot wall 2

%% Plot the target
plot([target_pos(1) - target_size / 2, target_pos(1) + target_size / 2], [target_pos(2), target_pos(2)]);

%% Begin painful geometry
if tand(theta) * (wall2_x - radar_pos*(1))+radar_pos(2) > wall2_y % beam overshoots the gap
    s = tand(theta) * (wall2_x - radar_pos(1))+radar_pos(2); % y-position where beam hits wall face
    plot([radar_pos(1), wall2_x, 0], [radar_pos(2), s, tand(theta) * (wall2_x - radar_pos(1)) + s]);
elseif tand(theta) * (wall1_x - radar_pos(1)) + radar_pos(2) < wall1_y % beam undershoots the gap
    s = tand(theta) * (wall1_x - radar_pos(1)) +radar_pos(2); % y-position where beam hits wall face
    plot([radar_pos(1), wall1_x, 0], [radar_pos(2), s, tand(theta) * (wall1_x - radar_pos(1)) + s]);
else
    s = (wall2_y - radar_pos(2))/tand(theta) + radar_pos(1); % x-position where beam hits upper wall
    x_inc = (wall2_y - wall1_y)/tand(theta); % x-value increment for each bounce
    
    [M, hit_status] = target(radar_pos(1), radar_pos(2), target_pos(1), target_pos(2), target_size, wall1_y, wall2_y, theta);
    
     
    % first segment to the target
    
    if target_pos(1) - target_size / 2 < s % beam hits target before walls
        s = (target_pos(2) - radar_pos(2))/tand(theta) + radar_pos(1); % x-position where beam hits target
        plot_y = [radar_pos(2), target_pos(2)];
    else
        plot_y = [radar_pos(2), wall2_y];
    end
    plot_x = [radar_pos(1), s];
    
    while M > 0
        if M > 1
            plot_x = [plot_x, s + x_inc, s + 2*x_inc];
            plot_y = [plot_y, wall1_y, wall2_y];
            s = s + 2 * x_inc;
            M = M-2;
            % stop last reflection at target
            if and(~M, hit_status)
                plot_y(end) = target_pos(2);
                plot_x(end) = ((target_pos(2) - wall1_y)/(wall2_y - wall1_y)) * x_inc + plot_x(end -1);
                s = plot_x(end);
            end            
        else
            plot_x = [plot_x, s + x_inc];
            plot_y = [plot_y, wall1_y];
            s = s + x_inc;
            M = M - 1;
            % stop last reflection at target
            if and(~M, hit_status)
                plot_y(end) = target_pos(2);
                plot_x(end) = ((wall2_y - target_pos(2))/(wall2_y - wall1_y)) * x_inc + plot_x(end -1);
                s = plot_x(end);
            end
        end
            
    end
    plot(plot_x, plot_y);
    
    % Calculate range
    %   This calculates total range of the beam.
    %   TODO: Calculate range to target after target detection code is
    %   developed
    if hit_status
        R = (s - radar_pos(1))/cosd(theta);
    else
        R = inf;
    end
end
scatter(radar_pos(1), radar_pos(2));
% scatter(target_pos(1), target_pos(2)); % Plots a point at center of
% target
xlim([0, scene_x]);
ylim([0, scene_y]); 
% saveas(gcf,sprintf('images/fig%d.png', theta))