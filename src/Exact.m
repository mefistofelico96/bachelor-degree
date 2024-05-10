clear;
clc;
close all;

%% Data
% Get data from Data.txt file
in_path = "src/Data.txt";
fileID = fopen(in_path, "r");
data = fscanf(fileID, "%f");
N = data(1); % Number of particles
L = data(3*N + 2); % Length of the domain
H = data(3*N + 3); % Heigth of the domain
particle_position(1, 1:N) = data(2:N + 1);
particle_position(2, 1:N) = data(N + 2: 2*N + 1);
particle_charge(1:N) = 1.602e-19*data(2*N + 2:3*N + 1);
fclose(fileID);
clear fileID data ans; % ans is given by fclose

%% Forces
epsilon_0 = 8.85e-12;
force_exact = zeros(2, N);
for i = 1:size(particle_position, 2)
    for j = 1:N
        r = sqrt((particle_position(1, i) - particle_position(1, j))^2 + (particle_position(2, i) - particle_position(2, j))^2);
        if (r > 0)
            force_exact(1:2, i) = force_exact(1:2, i) + (particle_charge(i)*particle_charge(j)*(particle_position(1:2, j) - particle_position(1:2, i)))/(4*pi*epsilon_0*r^3);
        end
    end
end

out_path = "src/Exact.mat";
save(out_path, "force_exact");
clear r i j in_path out_path;
