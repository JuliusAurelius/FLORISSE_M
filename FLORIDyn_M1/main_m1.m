function [] = main_m1()
%MAIN_M1 first test implementation of FLORIDyn

numOfOPs = 10;
numOfChs = 3;

%% Design and analysis of spatially heterogeneous wake equations
% u(x,y,z) := velocity deficit behind the rotor
% U_inf := free speed velocity
% C := velocity at wake center
% z_h := turbine hight
% delta := wake deflection
% sigma := wake width lateral / y and vertical / z
% I_0 := ambient turbine intensity
% C_T := Thrust coefficient
% k_y := wake expansion rate in y dir
% k_z := wake expantion rate in z dir
% D := rotor diameter
% u_r := velocity at the rotor
% yaw := turbines yaw offset
% u_0 := maximum velocity deficit

%% Experimental and theoretical study of wind turbine wakes in yawed conditions
C_T = 0;

x_0

sig_y = @(x,k_y,yaw,d) ;
sig_z = 0;


% Eq. 7.1 u/U = G_uU
G_uU = @(x,y,z,yaw,x0)...
    (1-sqrt(1-C_T*cos(yaw)/(8*sig_y*sig_z/d^2)))*...
    exp(-0.5*((y-delta)/sig_y)^2)*...
    exp(-0.5*((z-z_h)/sig_z)^2);
end

