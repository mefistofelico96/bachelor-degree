% Draw nodes
function [quadtree_grid_x, quadtree_grid_y] = drawNode (L_min, L_max, H_min, H_max)
    quadtree_grid_x = plot([L_min L_max], [(H_max + H_min)/2 (H_max + H_min)/2], 'r-'); % X const
    quadtree_grid_y = plot([(L_max + L_min)/2 (L_max + L_min)/2], [H_min H_max], 'r-'); % Y const
end
