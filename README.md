# bachelor-degree
This is my Electronic Engineering Bachelor Degree thesis project.

# Data structure for bodies interactions
## Summary
The $n$-body problem is a class of problems still continuously studied in the field of mathematical physics, but which has multiple possible applications ranging from celestial mechanics to applied engineering. These problems look at the possible interaction that occurs between a number of bodies greater than two, which makes the modeling and formulation of the laws that govern such processes quite complex. Analytically, solving such problems means setting up $n$ systems of various differential equations, to which initial conditions must be assigned. Computationally, this methodology is very expensive to address numerically. This is why simplified numerically models are used, i.e. those which considerably reduce the number of operations to be carried out, in order to reduce computational complexity and, possibly, calculation times.

This thesis work concerned the development of an algorithm for the efficient and effective solution of an $n$-body problem based on the Barnes-Hut approach. The problem considered consisted in the calculation of the electric force field established by a non-uniform network of charges all with the same sign.

Wanting to solve an $n$-body problem exactly numerically would have a computational cost equal to $O(n^2)$. The Barnes-Hut algorithm has the merit of reducing the computational complexity to a value proportional to $O(n \log{n})$ at the cost of a slight and controllable decrease in accuracy thanks to the parameter $\theta$.

The discussed approach was implemented in a code written in MATLAB language and the performances of the Barnes-Hut algorithm were compared with an exact calculation of the interactions between particles in terms of accuracy and computational cost.

## The code
The code is divided in two parts:
1. the quadtree and Barnes-Hut algorithm part;
2. the operations count part.

### Quadtree and Barnes-Hut algorithm
This part shows how the quadtree and the Barnes-Hut algorithm work. To run this part, open the `quadtree_main.m` file on MATLAB and run it.

### Operations count
This part compares the Barnes-Hut complexity with the exact method complexity. To run this part, open the `opCount_main.m` file on MATLAB and run it.
