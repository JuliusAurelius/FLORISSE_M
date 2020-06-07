function initChains()
%% Test Variables
NumChains   = 6;
TurbinePos  = [magic(3),ones(3,1)];
chainLength = randi(5,NumChains*size(TurbinePos,1),1)+1;
chainLength = 5;

%% Create starting OPs and build opList
startOPs =  getChainStart(NumChains, TurbinePos);
[opList, startInd_T] = assembleOPList(startOPs,chainLength);

end

%%
function OPs = getChainStart(NumChains, TurbinePosD)
% getChainStart creates starting points of the chains based on the number
% of chains and the turbines
%
% INPUT
% NumChains     := Int
% TurbinePosD   := [nx3] vector, [x,y,z,d] // World coordinates & in m
%
% OUTPUT
% OPs           := [(n*m)x3] m Chain starts [x,y,z] per turbine
%
% [x,y,z, ux,uy,uz, r,r_t, a,yaw,d] // World coordinates

% ========================= TODO ========================= 
OPs = zeros(NumChains*size(TurbinePos,1),3);
OPs(:,1:3) = ones(NumChains*size(TurbinePos,1),3);
end

%%
function [opList, startInd_T] = assembleOPList(startOPs,chainLength)
% assembleOPList creates a list of OPs with entries for the starting points 
% and the rest being 0
% 
% INPUT
% startOPs      := [n x 3] vector [x,y,z]
% chainLength   := [n x 1] vector
% chainLength   := Int
%
% OUTPUT
% opList        := [n x vars]
% startInd_T    := [n x 2] starting Indices for all chain lengths and which 
%                   turbine they belong to.
%
% [x,y,z, ux,uy,uz, r,r_t, a,yaw,d] // World coordinates
%% Constants
NumOfVariables  = 11;
numChains       = size(startOPs,1);

%% Build Chains
if length(chainLength)==numChains
    % diverse length, for every chain there is a length.
    
    % Get starting indeces
    startInd_T = cumsum(chainLength')'-chainLength+1;
    
    % Allocate opList
    opList = zeros(sum(chainLength), NumOfVariables);
    
else
    % Uniform length
    startInd_T = cumsum(ones(1,numChains)*chainLength)'-chainLength+1;
    
    % Allocate opList
    opList = zeros(startInd_T(end), NumOfVariables);
end

opList(startInd_T,1:3) = startOPs;

end