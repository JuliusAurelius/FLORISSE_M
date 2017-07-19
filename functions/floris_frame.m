function [ turbines,wtRows ] = floris_frame( inputData,turbines )
%[ wt_order,sortvector,inputData,yawAngles_if,wt_locations_wf ] = floris_frame( inputData,turb,yawAngles_wf,wt_locations_if )
%   This function calculates the (rearranged) wind farm layout in the wind-
%   aligned frame ('*_wf'). It also groups turbines together in rows to 
%   avoid unnecessary calculations of the influence of downstream turbines 
%   on their upwind turbines (which of course is none).

    % Calculate incoming flow direction
    Rz = @(a) [cos(a) -sin(a) 0;sin(a) cos(a) 0;0 0 1]; % Rotational matrix
    
    % Wind frame turbine locations in wind frame
    wtLocationsWf = inputData.LocIF*Rz(deg2rad(-inputData.windDirection)).'; 

    % Order turbines from front to back, and project them on positive axes
    [LocX,sortvector] = sort(wtLocationsWf(:,1));
    wtLocationsWf = wtLocationsWf(sortvector,:);
    wtLocationsWf(:,2) = wtLocationsWf(:,2)-min(wtLocationsWf(:,2)); % shift vertically (up-down)
    wtLocationsWf(:,1) = wtLocationsWf(:,1)-min(wtLocationsWf(:,1)); % shift horizontally (sideways)

    % Group turbines together in rows (depending on wind direction)
    rowi = 1; j = 1;
    while j <= size(wtLocationsWf,1)
        wtRows{rowi} = [j j+find(abs(LocX(j)-LocX(j+1:end))<1e0)']; % Within 1 meter of each other
        j       = j + length(wtRows{rowi});
        rowi    = rowi + 1;
    end;
    
    % Repopulate the turbine struct ordered by wind direction x-coordinates
    turbines = turbines(sortvector);
    for i = 1:length(sortvector)
        turbines(i).LocIF = inputData.LocIF(sortvector(i),:).';
        turbines(i).LocWF = wtLocationsWf(i,:).';
        % Yaw angles (counterclockwise, inertial frame)
        turbines(i).YawIF = inputData.windDirection+turbines(i).YawWF;
    end;
end;