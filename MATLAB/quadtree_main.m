clear;
clc;
close all;

%% Execute Data.m and Exact.m first
Data;
Exact;
clear;

%% Data
% Get data from Data.txt file
path = "Data.txt";
fileID = fopen(path, 'r');
data = fscanf(fileID, '%f');
N = data(1); % Number of particles
L = data(3*N + 2); % Normalized length of the domain
H = data(3*N + 3); % Normalized height of the domain
particle_position(1, 1:N) = data(2:N + 1);
particle_position(2, 1:N) = data(N + 2:2*N + 1);
particle_charge(1:N) = 1.602e-19*data(2*N + 2:3*N + 1);
fclose(fileID);
clear fileID path data ans; % ans is given by fclose

center = [L, H];
N_max = 3; % Maximum number of particles in a node
theta = 1; % Treshold value. A good value is 0.5

%% Particles
figure(1);
hold on;
grid off;
axis([0 L 0 H]);
xlabel('$L$', 'Interpreter', 'latex');
ylabel('$H$', 'Interpreter', 'latex');
title('Quadtree');
plot(particle_position(1, 1:N), particle_position(2, 1:N), '.k');

%% Qadtree
parent_pointer = 0; % To plot the tree
tree = struct('sw', [], 'se', [], 'nw', [], 'ne', [], 'cc_plus_node', [], 'cc_minus_node', [], 'q_plus_node', [], 'q_minus_node', [], 'L_node', [], 'particle_q_node', [], 'particle_position_node', [], 'isEmpty', [], 'isLeaf', [], 'index', 0, 'parent', 0);
% I used doubled dimensions to split the whole domain also for the first step, if N > N_max
tree = quadtree(2*L, 2*H, center(1), center(2), N, N_max, particle_position, particle_charge, tree, parent_pointer);
% First node = tree.sw

%% Centers of charge
% cc_tree(tree.sw);

%% Forces on each particle
epsilon_0 = 8.85e-12;
particle_f = zeros(2, N);
for i = 1:N
    cc_force_plus = [];
    cc_force_minus = [];
    q_force_plus = [];
    q_force_minus = [];
    % I get the centers of charge/particles that fulfill the condition for each particle
    [cc_force_plus, q_force_plus] = forcetree_plus(tree.sw, particle_position(1:2, i), particle_charge(i), cc_force_plus, q_force_plus, theta);
    [cc_force_minus, q_force_minus] = forcetree_minus(tree.sw, particle_position(1:2, i), particle_charge(i), cc_force_minus, q_force_minus, theta);
    % plot(cc_force(1, :), cc_force(2, :), 'sb');
    for j = 1:size(cc_force_plus, 2)
        r = sqrt((cc_force_plus(1, j) - particle_position(1, i))^2 + (cc_force_plus(2, j) - particle_position(2, i))^2);
        particle_f(1:2, i) = particle_f(1:2, i) + particle_charge(i)*q_force_plus(j)*((cc_force_plus(1:2, j) - particle_position(1:2, i)))/(4*pi*epsilon_0*r^3);
    end
    for j = 1:size(cc_force_minus, 2)
        r = sqrt((cc_force_minus(1, j) - particle_position(1, i))^2 + (cc_force_minus(2, j) - particle_position(2, i))^2);
        particle_f(1:2, i) = particle_f(1:2, i) + particle_charge(i)*q_force_minus(j)*((cc_force_minus(1:2, j) - particle_position(1:2, i)))/(4*pi*epsilon_0*r^3);
    end
end
clear i j;

%% Forces field
% Define the mesh
q_point = 1; % 1.602e-19; % C
n_mesh = 50;
x = linspace(0, L, n_mesh);
y = linspace(0, H, n_mesh);
f_x = zeros(n_mesh, n_mesh);
f_y = zeros(n_mesh, n_mesh);
for i = 1:n_mesh
    for j = 1:n_mesh
        cc_force_plus = [];
        cc_force_minus = [];
        q_force_plus = [];
        q_force_minus = [];
        [cc_force_plus, q_force_plus] = forcetree_plus(tree.sw, [x(i); y(j)], q_point, cc_force_plus, q_force_plus, theta);
        [cc_force_minus, q_force_minus] = forcetree_minus(tree.sw, [x(i); y(j)], q_point, cc_force_minus, q_force_minus, theta);
        for k = 1:size(cc_force_plus, 2)
            r = sqrt((cc_force_plus(1, k) - x(i))^2 + (cc_force_plus(2, k) - y(j))^2);
            if (r > 0)
                f_x(i, j) = f_x(i, j) + q_point*q_force_plus(k)*((cc_force_plus(1, k) - x(i)))/(4*pi*epsilon_0*r^3);
                f_y(i, j) = f_y(i, j) + q_point*q_force_plus(k)*((cc_force_plus(2, k) - y(j)))/(4*pi*epsilon_0*r^3);
            end
        end
        for k = 1:size(cc_force_minus, 2)
            r = sqrt((cc_force_minus(1, k) - x(i))^2 + (cc_force_minus(2, k) - y(j))^2);
            if (r > 0)
                f_x(i, j) = f_x(i, j) + q_point*q_force_minus(k)*((cc_force_minus(1, k) - x(i)))/(4*pi*epsilon_0*r^3);
                f_y(i, j) = f_y(i, j) + q_point*q_force_minus(k)*((cc_force_minus(2, k) - y(j)))/(4*pi*epsilon_0*r^3);
            end
        end
    end
end
clear center i j k;

% Import exact data
data_exact = load('Exact.mat');

% Prepare to plot the tree node
parent_pointer = [];
parent_pointer = get_parents(tree.sw, parent_pointer);

%% Plots
% Force components
figure("Name", "Quadtree");
title('Componente x della forza su ogni particella');
xlabel('Particella');
ylabel('$F_x$', 'Interpreter', 'latex');
hold on;
grid on;
plot(data_exact.force_exact(1, 1:end), 'r');
plot(particle_f(1, 1:end), 'b');
legend("Esatto", "Approssimato");

figure("Name", "Quadtree");
title('Componente y della forza su ogni particella');
xlabel('Particella');
ylabel('$F_y$', 'Interpreter', 'latex');
hold on;
grid on;
plot(data_exact.force_exact(2, 1:end), 'r');
plot(particle_f(2, 1:end), 'b');
legend("Esatto", "Approssimato");

% Plot tree
figure("Name", "Quadtree");
title('Albero dei nodi');
hold on;
grid off;
set(gca, 'xtick', []);
set(gca, 'XColor', 'none', 'YColor', 'none');
treeplot(parent_pointer, 'or', 'k');

% Field drections
mod_f = sqrt(f_x(:, :).^2 + f_y(:, :).^2);
f_x_norm = f_x./mod_f;
f_y_norm = f_y./mod_f;
figure("Name", "Quadtree");
title('Direzione del campo');
hold on;
grid off;
axis([0 L 0 H]);
xlabel('$L$', 'Interpreter', 'latex');
ylabel('$H$', 'Interpreter', 'latex');
quiver(x, y, f_x_norm(:, :), f_y_norm(:, :), 'autoscalefactor', 0.5);
plot(particle_position(1, 1:N), particle_position(2, 1:N), 'or');

% Field amplitude
figure("Name", "Quadtree");
title('Modulo del campo');
hold on;
grid off;
axis([0 L 0 H]);
xlabel('$L$', 'Interpreter', 'latex');
ylabel('$H$', 'Interpreter', 'latex');
pcolor(x, y , mod_f);
shading interp;
h = colorbar;
h.Label.String = '|e| [V/m]';
clear h;
