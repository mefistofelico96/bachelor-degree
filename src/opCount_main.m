clear;
clc;
close all;

%% Data
L = 1; % Normalized length of the domain
H = 1; % Normalized height of the domain
center = [L, H];
N_max = 3; % Maximum number of particles in a node
theta = 2; % Treshold value. A good value is 0.5
n_loop = 8; % Number of loops
operation_count = zeros(2, n_loop);
rms = zeros(1, n_loop);
x_scale = zeros(1, n_loop); % Value of x axis

%% Execution
for k = 1:n_loop
    % Loop data
    N = 2^k; % Number of particles
    x_scale(k) = N; % Values on the x axis

    particle_position(1, 1:N) = L*rand(1, N);
    particle_position(2, 1:N) = H*rand(1, N);
    particle_charge(1:N) = ceil(10*rand(1, N)); % From 1 to 10 (1.602e-19*)
    % We assumed to have only positive charges

    % Exact case
    epsilon_0 = 8.85e-12;
    force_exact = zeros(2, N);
    for i = 1:size(particle_position, 2)
        for j = 1:size(particle_position, 2)
            r = sqrt((particle_position(1, i) - particle_position(1, j))^2 + (particle_position(2, i) - particle_position(2, j))^2);
            if (r > 0)
                force_exact(1:2, i) = force_exact(1:2, i) + (particle_charge(i)*particle_charge(j)*(particle_position(1:2, j) - particle_position(1:2, i)))/(4*pi*epsilon_0*r^3);
                operation_count(1, k) = operation_count(1, k) + 1;
            end
        end
    end
    clear i j;
    
    % Approx case
    tree = struct('sw', [], 'se', [], 'nw', [], 'ne', [], 'cc_plus_node', [], 'cc_minus_node', [], 'q_plus_node', [], 'q_minus_node', [], 'L_node', [], 'particle_q_node', [], 'particle_position_node', [], 'isEmpty', [], 'isLeaf', [], 'index', 0);
    tree = quadtree_opCount(2*L, 2*H, center(1), center(2), N, N_max, particle_position, particle_charge, tree);
    particle_f = zeros(2, N);
    for i = 1:N
        cc_plus_force = [];
%         cc_minus_force = [];
        q_plus_force = [];
%         q_minus_force = [];
        [cc_plus_force, q_plus_force] = forcetree_plus(tree.sw, particle_position(1:2, i), particle_charge(i), cc_plus_force, q_plus_force, theta);
%         [cc_minus_force, q_minus_force] = forcetree_minus(tree.sw, particle_position(1:2, i), particle_charge(i), cc_minus_force, q_minus_force, theta);
        for j = 1:size(cc_plus_force, 2)
            r = sqrt((cc_plus_force(1, j) - particle_position(1, i))^2 + (cc_plus_force(2, j) - particle_position(2, i))^2);
            particle_f(1:2, i) = particle_f(1:2, i) + particle_charge(i)*q_plus_force(j)*((cc_plus_force(1:2, j) - particle_position(1:2, i)))/(4*pi*epsilon_0*r^3);
            operation_count(2, k) = operation_count(2, k) + 1;
        end
    end
    clear i j;
    rms(k) = 100*sqrt(sum(abs(particle_f(1, :) - force_exact(1, :)).^2/sum(abs(force_exact(1, :)).^2)));    
end
clear center k;

%% Plot
% Number of operations
figure("Name", "Quadtree");
title("Numero di interazioni al variare di N, fissati \theta e N_{max}");
hold on;
grid on;
xlabel('$N$', 'Interpreter', 'latex');
ylabel('Numero di interazioni');
axis([x_scale(1) x_scale(end) 0 1e5]);
set(gca, 'xscale', 'log', 'yscale', 'log');
plot(x_scale, operation_count(1, :), '-r');
plot(x_scale, operation_count(2, :), '-b');
plot(x_scale, x_scale.^2, 'o-k');
plot(x_scale, x_scale.*log(x_scale.^2), '^-k');
legend("Esatto", "Barnes-Hut", "$N^2$", "$N \cdot \log{N}$", "Interpreter", "latex", ...
    "Location", "northwest");

% RMS
figure("Name", "Quadtree");
title("RMS al variare di N, fissati \theta e N_{max}");
hold on;
grid on;
axis([x_scale(1) x_scale(end) min(rms) max(rms)]);
xlabel('$N$', 'Interpreter', 'latex');
ylabel('RMS', 'Interpreter', 'latex');
set(gca, 'xscale', 'log');
plot(x_scale, rms(:), 'b');
