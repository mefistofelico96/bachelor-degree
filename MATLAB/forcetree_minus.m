function [cc_force, q_force] = forcetree_minus(tree, particle_position, particle_charge, cc_force, q_force, theta)
    if (~tree.isEmpty)
        % Negative centers of charge
        r = sqrt((tree.cc_minus_node(1, 1) - particle_position(1, 1))^2 + (tree.cc_minus_node(2, 1) - particle_position(2, 1))^2);
        if (tree.isLeaf)
            if (r > 0 && tree.L_node/r <= theta)
                cc_force(1:2, end + 1) = tree.cc_minus_node(1:2, 1);
                q_force(end + 1) = tree.q_minus_node;
            else
                for i = 1:size(tree.particle_q_node, 2)
                    r = sqrt((tree.particle_position_node(1, i) - particle_position(1, 1))^2 + (tree.particle_position_node(2, i) - particle_position(2, 1))^2);
                    if (r > 0 && tree.particle_q_node(i) < 0)
                        cc_force(1:2, end + 1) = tree.particle_position_node(1:2, i);
                        q_force(end + 1) = tree.particle_q_node(i);
                    end
                end
            end
        else
            if (tree.L_node/r <= theta)
                cc_force(1:2, end + 1) = tree.cc_minus_node(1:2, 1);
                q_force(end + 1) = tree.q_minus_node;
            else
                [cc_force, q_force] = forcetree_minus(tree.sw, particle_position, particle_charge, cc_force, q_force, theta); % South - West
                [cc_force, q_force] = forcetree_minus(tree.se, particle_position, particle_charge, cc_force, q_force, theta); % South - East
                [cc_force, q_force] = forcetree_minus(tree.nw, particle_position, particle_charge, cc_force, q_force, theta); % North - West
                [cc_force, q_force] = forcetree_minus(tree.ne, particle_position, particle_charge, cc_force, q_force, theta); % North - East
            end
        end
    end
end
