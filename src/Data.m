clear;
clc;
close all;

%% Define data
N = 100; % Number of particles
L = 1; % Normalized length of the domain
H = 1; % Normalized height of the domain

% Particle positions
% Uniform distribution
particle_position(1, 1:N) = L*rand(1, N);
particle_position(2, 1:N) = H*rand(1, N);

% Normal distribution
% particle_position(1, 1:N) = 0.25*randn(1, N) + L/4;
% particle_position(2, 1:N) = 0.25*randn(1, N) + 3*H/4;

% Particle charge
particle_charge(1:N) = (ceil(10*rand(1, N)) - 5); % From -4 to 5 (1.602e-19*)

%% Write on Data.txt file
path = "src/Data.txt";
fileID = fopen(path, 'w');
fprintf(fileID, '%f\n', N);
fprintf(fileID, '%f\n', particle_position(1, 1:N));
fprintf(fileID, '%f\n', particle_position(2, 1:N));
fprintf(fileID, '%f\n', particle_charge);
fprintf(fileID, '%f\n', L);
fprintf(fileID, '%f\n', H);
fclose(fileID);
clear fileID path ans;
