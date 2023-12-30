function [] = cc_tree (tree)
    plot(tree.cm_plus_node(1, 1), tree.cm_plus_node(2, 1), 'or');
    plot(tree.cm_minus_node(1, 1), tree.cm_minus_node(2, 1), 'ob');
    if (~tree.isLeaf)
        % Southwest
        if (~tree.sw.isEmpty)
            cm_tree(tree.sw);
        end
        % Southeast
        if (~tree.se.isEmpty)
            cm_tree(tree.se);
        end
        % Northwest
        if (~tree.nw.isEmpty)
            cm_tree(tree.nw);
        end
        % Northeast
        if (~tree.ne.isEmpty)
            cm_tree(tree.ne);
        end
    end
end
