# Heaps

* Original [link](https://gist.githubusercontent.com/ruggeri/c5a45b6e66841a47c51ecc21642822a9/raw/57db7884123b2a0c33824727fb5431b8b0b4c539/heaps.md):

* Project [link](https://github.com/appacademy/sf-job-search-curriculum/tree/master/algorithms/heaps/project/firstname_lastname):
  * Solutions [link](https://github.com/appacademy/placements-staff/tree/4c7037fbba551e1ceefdc94f7b8c5e403dea9a25/project_solutions/heaps/lib):

## Priority Queue

Heaps are an implementation of the *priority queue* abstract data type:

* `insert(entry, priority)`.
  * `priority` is an integer priority. Entries with "higher priority"
    will be extracted before entries with "lower priority."
  * Lower number often is "higher priority." This makes sense
    because the priority is often a "cost."
  * For instance: the distance to a city.
* `extract`: Removes the element with with highest priority.
* `update_priority(entry, priority)`: change priority of an already
  added entry.

## Uses of Priority Queues

* Priority queue can be used for scheduling work or threads.
  * Want to run highest priority thread.
  * But new threads are being started concurrently, and existing
    threads' priorities may be changing.
* Dijkstra's algorithm.
  * Want to find shortest paths to cities.
  * Priority is "distance" to the city. But as you "explore" the graph,
    you discover shorter paths to the cities.
* Keep track of `k`-th minimum in a stream.
* Broadly: any problem where the "best" thing to be doing may change
  over time.

## Obvious Solution? BST?

* Self-balancing binary search tree allows logarithmic `insert`,
  `remove`, and access to smallest element.
* Keeps things entirely sorted, which is more than you need for a
  priority queue.
* We'll see a PQ implementation called a *binary heap* which has some
  advantages:
  * The binary heap will have worst-case logarithmic `insert` and
    `remove.`
  * The binary heap will have `O(1)` `peek` to look at the highest
    priority entry. A BST can be modified to do this though...
  * Binary heap will have average case `O(1)` `insert` though! This is
    a major advantage over BSTs.
  * The binary heap will not need to make nodes with pointers to heap
    memory. This is more cache efficient and a big advantage.

## BinaryHeap Implementation

* Binary heap implementation is a *complete* binary tree. All interior
  levels are totally filled in. Last level is filled in left-to-right.
* The heap property is that the entry of a parent node always is higher
  priority than the entries in its children.
* A left child may have higher priority than the right child, or vice
  versa. This is the difference from BST.
* Insert: do `heapify_up`.
  * Append node, swap with parent entry if the new entry has higher
    priority.
  * Repeat.
  * Worst case: `O(log n)` swaps.
  * Average case: `O(1)`.
    * Hand-wavy argument: to move up from bottom level, an entry must
      be higher priority than 50% of current entries.
* Extract: remove root entry, replace with last leaf node element.
  * Do a `heapify_down` to push down this element until it is higher
    priority than both its children.
  * Worst case: `O(log n)`.
  * Why do we need to first move the last node to the root?
  * Answer: This avoids "holes" in the complete tree.

## Heaps can be implemented with arrays.

* All `(entry, priority)` pairs live in an array.
* First element is root. Second element is left child, third is right
  child.
* Fourth is left child of left child. Sixth is left child of right
  child.
* Simple calculation to calculate child and parent positions from
  `idx`.
* This only works with a *complete* tree.
* `decrease_key`: just throw a hash map in front to map entries to
  index positions.

## Heap Sorting

* Just add all the items one-by-one, then extract one-by-one.
* Clearly worst case is `O(n log n)` time.
* You can do this *in place*. Just use the same array as the heap.
* When you extract one-by-one, just place at the end of the array each
  time.
    * You can either use a *max* heap, or just reverse at the end.
* Downside: not particularly cache friendly. Thus quicksort is often
  a better choice.
  * Especially hurts for external sorting.

## Recap: Advantages over BST

* No pointers. Better cache behavior. Less overhead.
* Faster expected insert or `update_priority` time.
  * Graph algorithms often make a lot of `update_priority` calls.
* Can be used for in-place sorting.

## Building a Binary Heap

* If you want to build a heap from `n` elements, you can just insert
  one-by-one.
* This is `O(n log n)` worst case. But on average it is `O(n)` by then
  reasoning described above.
* Floyd's algorithm ensures worst case `O(n)` building.
* You put all your items in an array. Say this has `k` levels: the last
  is level `k-1`.
* You can consider every element in level `k-2` as a 2-level heap.
* Swap to fix these 2-level heaps.
* Then you can move up to level `k-3`. You need to fix a 3-level heap.
* At level `k-1` there are `n/2` nodes. Level `k-2` has `n/4` nodes.
  Level `k-3` has `n/8` nodes.
* At level `k-i` you may have to push down up to `i - 1` levels.
* Consider infinite sum of all terms `k * (1/2**k)`. This is bounded by
  a constant.
* Thus `O(n)` overall.
* You start from bottom and "sift up".

## Other Flavors of Heaps

* Binomial Heap
  * Amortized `O(1)` `insert`. Not just `O(1)` average.
  * Logarithmic `peek` though.
* Fibonacci Heap
  * Worst case `O(1)` insert.
  * `extract` is amortized `O(log n)`; before was worst case
    logarithmic.
* Neither is very practical because adds a lot of overhead.