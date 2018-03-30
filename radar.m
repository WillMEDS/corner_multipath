%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function takes from the user:
%   m = Number of bounces the user wishes to allow for tracking (integer)
%   theta = a value for theta to be swept over by the wall function
%       must be greater than zero and less than 90 (degrees).
%   radar_pos = [x,y] position of the radar in the cartesian coordinate 
%       system.
%   gam = The magnitude of gamma for the attenuation factor
%   p_t = Transmit Power of the radar
%   g = Gain of the transmit and receive antenna. Just one value for this
%       to cover both
%   f = The operating frequency of the radar.
%   noise_fig = The noise figure of the radar (usually in dB).
%   L = The losses of the radar (usually in dB).
%   B = The bandwidth of the radar.
%   
% This function expects the following returns from the wall function for a
% register of a hit on the target:
%   R = The range to the target if the target is detected. 0 Otherwise.
%
% Utilizes the wall.m file and the ___.m file
%
% Author: Dylan Sewell - dks153
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function radar(m, theta, radar_pos, gam, p_t, g, f, noise_fig, L, B)

    range1 = []; %Ranges to target given by the wall function
    
    for i = 1:1:theta
        for j = 1:1:m
            %Get range to target for all values of theta and break out of m
            %      loop and continue through theta if nonzero range
           range1 = [range1, wall(radar_pos, i, gam, j, 1, 1)];
           
           %Check to see if target was hit at this angle with j number of
           %bounces
           if range1(end)
               break;
           end
        end
    end
    
    % Calculate SNR for all range values. If range = 0, assume SNR = 0
    % (natural units)

end
