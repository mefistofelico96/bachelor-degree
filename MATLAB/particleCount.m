% Count particles in a node and get their index
function [n, index] = particleCount(L_min, L_max, H_min, H_max, N, particle_position)
    n = 0; % Number of particles found in a node
    index = zeros(1, N); % Indexes of particles found in a node
    for i = 1:N
        if (particle_position(1, i) >= L_min && particle_position(1, i) < L_max && particle_position(2, i) >= H_min && particle_position(2, i) < H_max)
            n = n + 1;
            index(n) = i;
        end
    end
end
