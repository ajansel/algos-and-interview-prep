# Graph Algorithms

* Ned's Project [link](https://github.com/ruggeri/graphs_project):
* Dijkstra's Algo Visualization [link](https://ruggeri.github.io/dijkstra-demo/):
* Project [link](https://github.com/ruggeri/graphs_project):
* Dijkstra's Project [link](https://github.com/ruggeri/dijkstra-project):

---

## Graph Types

* *Vertices* and *edges*
    * Vertex: city.
    * Edge: road.
* *Undirected* vs *directed*
    * Undirected: two-way road network
    * Directed: Airline routes. Webpage links.
* *Weighted* vs *unweighted*
    * Weighted: Roads, airline routes.
    * Unweighted: Friendship relation. Link graph.

---

## More Graph Types

* *Acyclic*
    * No *cycles*. Dependency graph.
    * Undirected version: *trees*. Minimal connected graph with no
      redundant edges.
* *Dense* vs *sparse*
    * Maximum number of edges is `O(v**2)`.
    * Max number of edges per vertex is `O(v)`.
    * If edges per vertex grows sublinearly, the graph is *sparse*.
    * Sparse: friendship connections.
    * Dense: "six-degrees" network.
    * *Complete*: every edge exists.

---

## Common Graph Problems

* *Traversal* and *shortest paths*
    * What is the shortest path from A to B?
    * Not just physical navigation. AI planning.
    * DFS, BFS, Dijkstra's algorithm, A\*.
* *Topological sorting*
    * Given a dependency graph, construct an ordering which respects
      the dependencies.
    * Kahn's algorithm. Tarjan's algorithm.

---

## More Graph Problems

* *Minimum spanning trees*
    * Give a collection of undirected edges so that there is a path
      from every A to every other B.
    * First used in early 20th century for electrical grid layout.
    * Prim's Algorithm, Kruskal's Algorithm.
* *Game playing*
    * Look ahead `n` moves in a *game tree*.
    * DFS variants: minimax, alpha-beta search.

---

## Graph Representations

* Adjacency list:
    * Vertex class: `@value`, `@out_edges`, `@in_edges`
    * Edge class: `@value`, `@from_vertex`, `@to_vertex`
    * Fast to iterate through neighbors.
    * Somewhat slow to find if two vertices are neighbors.
    * Space efficient for sparse graphs.
* Adjacency matrix:
    * `v`x`v` matrix where rows and columns are vertex numbers.
    * Has a one or zero based on whether an edge exists between the two.
    * Could be very wasteful if graph is dense.
    * Can represent with a hash map, though...

---

## DFS

* DFS searches for a goal node by recursively examining each child
  one-by-one.
* You can use a stack explicitly. Helps avoid stack overflow.
* Often used for game trees. Minimax and alpha-beta are variants.
* Prone to cycles/loops. Common problem in infinite graphs.
* *Iterative deepening*: progressively deeper runs of DFS.
* Linear time complexity in size of finite graph: `O(E)`.
* For game tree, runs in `O(b**d)` time.
* Uses `O(d)` memory at most in a tree of depth `d`.

---

## BFS

* BFS uses a queue.
* Gives shortest paths.
* Many variants for other shortest path problems (Dijkstra's algorithm).
* Example: Cheney garbage collection.
* Linear time complexity in size of finite graph: `O(E)`.
* BFS can use a great deal of memory.
* For game tree, runs in `O(b**d)` time. Uses `O(b**d)` memory.

---

## Topological Sorting

* Solves the dependency graph problem.
* Tarjan's algorithm
    * Do DFS. Whenever you exhaust the children of a vertex, add that
      vertex next to the head of the list.
* Kahn's algorithm
    * Keep a hash map from vertex to number of "active" in edges.
    * Keep a queue with vertices with zero active in edges.
    * Each time, remove from the queue, then decrement number of
      active in edges for all children.

---

## Spanning Trees: Prim's Algorithm

* Start from any vertex.
* Add minimum edge that crosses to other side.
* You want to use a heap for this.
* `E` inserts into a heap of size `V` means `O(E log V)`.
* Can run in `O(E + V log V)` time if you use a Fibonacci heap.
* Extra Reading [link](http://www.oxfordmathcenter.com/drupal7/node/685):

---

## Spanning Trees: Kruskal's Algorithm

* Every vertex starts out as its own tree.
* Consider edges in order of increasing cost.
* If the edge is inside a tree, discard it.
* Else connect two trees.
* Uses a datastructure called *disjoint-union*.