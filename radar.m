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

function radar(radar_pos, target_pos, target_vel, gam, p_t, g, f, noise_fig, L, B, Steptime, endTime)

    range1 = []; %Ranges to target given by the wall function
    SNR = [];
    spin_f = 5; %The speed of rotation of the beam in Hz
    c = 2.998e8; %Speed of light in m/s
    lambda = c/f; %The wavelength of the signal
    sigma = 1; %Target RCS in m^2 for a human
    k = 1.38064852e-23; %Boltzmaan's Constant
    To = 290; %Standard Temp in Kelvin
    t = 0;
    
    for time = 0:Steptime:endTime
        
        t = t + Steptime;
        %Update target x-position
        target_pos(1) = target_vel * Steptime + target_pos(1);
        
        %Calculate angle of beam
        %.25 * spin_f because only considering 1/4 of the sweep
        theta = mod((.25*spin_f*time*360), 90);
        
        %Get range to target and number of bounces till detection
        [j,range1] = wall(radar_pos, theta, target_pos, 1);
        
        %Calculate SNR in dB
        SNR = [SNR, 10*log10((((p_t * (g^2) * (lambda^2) * sigma)/((4*pi)^3 *...
            (range1^4) * k * To * B * noise_fig * L))*gam^(2*j)))];
        
        if SNR(end) <0
             SNR(end) = 0;
        end
        
        subplot(2,1,2);
        plot(SNR)
    end

    end
    
    % Calculate SNR for all range values. If range = 0, assume SNR = 0
    % (natural units)
