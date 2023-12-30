function [tree, parent_pointer] = quadtree(L, H, center_x, center_y, N, N_max, particle_position, particle_charge, tree, parent_pointer)
    % plot(center_x, center_y, 'or');

    % Southwest
    % Count the particle in the node and take their indexes
    [n_sw, index_sw] = particleCount(center_x - L/2, center_x, center_y - H/2, center_y, N, particle_position);
    if (n_sw == 0)
        % If the node is empty
        tree.sw.isEmpty = true;
        tree.sw.cc_plus_node = [];
        tree.sw.cc_minus_node = [];
        tree.sw.q_node = [];
    else
        parent_pointer(end + 1) = parent_pointer(end) + 1;
        tree.sw.index = parent_pointer(end);
        tree.sw.parent = tree.index;
        % If not, calculate center of mass, total charge and pass all charges, their positions and dimension of this node
        tree.sw.isEmpty = false;
        [tree.sw.cc_plus_node, tree.sw.cc_minus_node, tree.sw.q_plus_node, tree.sw.q_minus_node] = centerOfCharge(n_sw, index_sw, particle_position, particle_charge);
        tree.sw.particle_q_node = zeros(1, n_sw);
        tree.sw.particle_position_node = zeros(2, n_sw);
        for i = 1:n_sw
            tree.sw.particle_q_node(i) = particle_charge(index_sw(i));
            tree.sw.particle_position_node(1:2, i) = particle_position(1:2, index_sw(i));
        end
        tree.sw.L_node = L/2;
        if (n_sw > N_max)
            % If there are too many particles in a node, split and plot subnodes
            drawNode(center_x - L/2, center_x, center_y - H/2, center_y);
            % Set as not leaf node
            tree.sw.isLeaf = false;
            % Recoursive call of quadtree
            [tree.sw, parent_pointer] = quadtree(L/2, H/2, center_x - L/4, center_y - H/4, N, N_max, particle_position, particle_charge, tree.sw, parent_pointer);
        else
            % If not, it is a leaf node
            tree.sw.isLeaf = true;
        end
    end

    % Southeast
    [n_se, index_se] = particleCount(center_x, center_x + L/2, center_y - H/2, center_y, N, particle_position);
    if (n_se == 0)
        tree.se.isEmpty = true;
        tree.se.cc_plus_node = [];
        tree.se.cc_minus_node = [];
        tree.se.q_node = [];
    else
        parent_pointer(end + 1) = parent_pointer(end) + 1;
        tree.se.index = parent_pointer(end);
        tree.se.parent = tree.index;
        tree.se.isEmpty = false;
        [tree.se.cc_plus_node, tree.se.cc_minus_node, tree.se.q_plus_node, tree.se.q_minus_node] = centerOfCharge(n_se, index_se, particle_position, particle_charge);
        tree.se.particle_q_node = zeros(1, n_se);
        tree.se.particle_position_node = zeros(2, n_se);
        for i = 1:n_se
            tree.se.particle_q_node(i) = particle_charge(index_se(i));
            tree.se.particle_position_node(1:2, i) = particle_position(1:2, index_se(i));
        end
        tree.se.L_node = L/2;
        if (n_se > N_max)
            drawNode(center_x, center_x + L/2, center_y - H/2, center_y);
            tree.se.isLeaf = false;
            [tree.se, parent_pointer] = quadtree(L/2, H/2, center_x + L/4, center_y - H/4, N, N_max, particle_position, particle_charge, tree.se, parent_pointer);
        else
            tree.se.isLeaf = true;
        end
    end
    
    % Northwest
    [n_nw, index_nw] = particleCount(center_x - L/2, center_x, center_y, center_y + H/2, N, particle_position);
    if (n_nw == 0)
        tree.nw.isEmpty = true;
        tree.nw.cc_plus_node = [];
        tree.nw.cc_minus_node = [];
        tree.nw.q_node = [];
    else
        parent_pointer(end + 1) = parent_pointer(end) + 1;
        tree.nw.index = parent_pointer(end);
        tree.nw.parent = tree.index;
        tree.nw.isEmpty = false;
        [tree.nw.cc_plus_node, tree.nw.cc_minus_node, tree.nw.q_plus_node, tree.nw.q_minus_node] = centerOfCharge(n_nw, index_nw, particle_position, particle_charge);
        tree.nw.particle_q_node = zeros(1, n_nw);
        tree.nw.particle_position_node = zeros(2, n_nw);
        for i = 1:n_nw
            tree.nw.particle_q_node(i) = particle_charge(index_nw(i));
            tree.nw.particle_position_node(1:2, i) = particle_position(1:2, index_nw(i));
        end
        tree.nw.L_node = L/2;
        if (n_nw > N_max)
            drawNode(center_x - L/2, center_x, center_y, center_y + H/2);
            tree.nw.isLeaf = false;
            [tree.nw, parent_pointer] = quadtree(L/2, H/2, center_x - L/4, center_y + H/4, N, N_max, particle_position, particle_charge, tree.nw, parent_pointer);
        else
            tree.nw.isLeaf = true;
        end
    end
    % Northeast
    [n_ne, index_ne] = particleCount(center_x, center_x + L/2, center_y, center_y + H/2, N, particle_position);
    if (n_ne == 0)
        tree.ne.isEmpty = true;
        tree.ne.cc_plus_node = [];
        tree.ne.cc_minus_node = [];
        tree.ne.q_node = [];
    else
        parent_pointer(end + 1) = parent_pointer(end) + 1;
        tree.ne.index = parent_pointer(end);
        tree.ne.parent = tree.index;
        tree.ne.isEmpty = false;
        [tree.ne.cc_plus_node, tree.ne.cc_minus_node, tree.ne.q_plus_node, tree.ne.q_minus_node] = centerOfCharge(n_ne, index_ne, particle_position, particle_charge);
        tree.ne.particle_q_node = zeros(1, n_ne);
        tree.ne.particle_position_node = zeros(2, n_ne);
        for i = 1:n_ne
            tree.ne.particle_q_node(i) = particle_charge(index_ne(i));
            tree.ne.particle_position_node(1:2, i) = particle_position(1:2, index_ne(i));
        end
        tree.ne.L_node = L/2;
        if (n_ne > N_max)
            drawNode(center_x, center_x + L/2, center_y, center_y + H/2);
            tree.ne.isLeaf = false;
            [tree.ne, parent_pointer] = quadtree(L/2, H/2, center_x + L/4, center_y + H/4, N, N_max, particle_position, particle_charge, tree.ne, parent_pointer);
        else
            tree.ne.isLeaf = true;
        end
    end
end
