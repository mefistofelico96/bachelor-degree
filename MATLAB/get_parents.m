function parent_pointer = get_parents(tree, parent_pointer)
    parent_pointer(end + 1) = tree.parent;
    if (~tree.isLeaf)
        % South - West
        if (~tree.sw.isEmpty)
            parent_pointer = get_parents(tree.sw, parent_pointer);
        end
        % South - East
        if (~tree.se.isEmpty)
            parent_pointer = get_parents(tree.se, parent_pointer);
        end
        % North - West
        if (~tree.nw.isEmpty)
            parent_pointer = get_parents(tree.nw, parent_pointer);
        end
        % North - East
        if (~tree.ne.isEmpty)
            parent_pointer = get_parents(tree.ne, parent_pointer);
        end
    end
end
