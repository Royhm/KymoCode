function [tracks] = LionToMSD(d,N_particles,pixelsize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

N_dim = 2; % 2D

tracks = cell(N_particles, 1);

% Time step between acquisition; fast acquisition!
dT = 0.05; % s,

for i=1:N_particles
    N_time_steps = size(nonzeros(d.x{i}(:,2)),1);
    time= (0 : N_time_steps-1)' * dT;
    tracks{i}=[time nonzeros(d.x{i}(:,2))*pixelsize nonzeros(d.x{i}(:,4))*pixelsize];
end

end

