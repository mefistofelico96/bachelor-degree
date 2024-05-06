% Center of charge and total charge in a node
function [cc_plus, cc_minus, q_plus, q_minus] = centerOfCharge (n, index, particle_position, particle_charge)
    cc_plus = [0; 0];
    q_plus = 0;
    cc_minus = [0; 0];
    q_minus = 0;
    for i = 1:n
        if (particle_charge(index(i)) >= 0)
            cc_plus(1) = cc_plus(1) + particle_charge(index(i))*particle_position(1, index(i));
            cc_plus(2) = cc_plus(2) + particle_charge(index(i))*particle_position(2, index(i));
            q_plus = q_plus + particle_charge(index(i));
        else
            cc_minus(1) = cc_minus(1) + particle_charge(index(i))*particle_position(1, index(i));
            cc_minus(2) = cc_minus(2) + particle_charge(index(i))*particle_position(2, index(i));
            q_minus = q_minus + particle_charge(index(i));
        end
    end
    cc_plus = cc_plus/q_plus;
    cc_minus = cc_minus/q_minus;
end
