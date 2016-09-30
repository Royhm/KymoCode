function [Traj] = LionStart(N)
%% Roy's implementation
% loading utrack trajectories
% utrack to VB3 format
% saving in new structure variable

% experiment numbers

%Lower upperbound for trajectories
LB=7;
UB=300;

%Traj: all trajectories from experiments N, from utrack to VB3 format
Traj=LionPrepare(N,LB,UB);

end

