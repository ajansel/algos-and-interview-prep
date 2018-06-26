# Binary Search Trees

* Extra Reading [link](https://github.com/appacademy/sf-job-search-curriculum/blob/master/algorithms/binary_search_trees/bst_reading.md):
* Project [link](https://github.com/appacademy/sf-job-search-curriculum/tree/master/algorithms/binary_search_trees/project/firstname_lastname):
* Ned's Project [link](https://github.com/ruggeri/bst_project):

---

## Operations

* `find`
* `insert`
* `delete`
* Each has time complexity proportional to depth of the tree.
* Ideally tree is `O(log n)` depth. That is average case, but worst is
  `O(n)`. Will discuss later.

---

## BST property

* All values on the left side of a vertex are less than the vertex's
  value.
* All values on the right side of the vertex are greater than the
  vertex's value.
* This rule applies to *all* descendants, not just children.

---

## `vertex`

* `@value`
* `@left`
* `@right`
* `@parent`
  * Sometimes convenient, but more often unnecessary.
  * Often don't need because of recursion.
  * Disallows "persistent" trees (more later).

---

## `find(vertex, value)`

* Defined recursively.
  * Pretty much all tree algorithms are recursive.
  * Typically should be able to handle `nil` as a vertex.
* If vertex is `nil`, return `nil` (not found).
* Else, compare `value` to `vertex.value`.
* If matches, return `vertex`.
* If `value` is less, move left. Else move right.

---

## `insert`: Persistence

* I would like to avoid mutating `@left` or `@right`. I would like my
  `Vertex` class to be *immutable*. This can be really nice.
* This is the default for languages like Haskell.
* Data structures which are never mutated in-place are called
  *persistent*.
* One advantage of persistent data structures is for concurrency.
* Regardless it's often harder to make mistakes with persistent
  structures.
* But they are often practically slower than in-place approaches.

---

## `insert(vertex, value)`

* `insert` will always return a new root tree node for a new tree with
  the value inserted.
* If `vertex` is `nil`, make a new tree node with the `@value` set and
  `@left = @right = nil`. Return the new node.
* Else, if `vertex.value > value`, then recurse on `vertex.left`.
* When the recursive call completes and returns a new left child
  vertex, create a new parent vertex with the `@value = vertex.value`,
  `@left = new_left_vertex`, and `@right = vertex.right`
* This is called *path-copying*.


---

## `delete(vertex, value)`

* Same idea. If `vertex.nil?` return `nil`.
* If the `vertex.value > value`, recurse left (else right).
* After, create a new vertex with the returned new left (right) child.
* If `vertex.value == value` AND has no children, return `nil`.
* Else, randomly choose left (or right). Find max (or min value) in
  that subtree. Call this `max_value` (`min_value`).
* Recursively call `delete(vertex.left, max_value)`.
* Make a new node here with `@value = max_value`, and `@left` set to
  new left subtree.

---

## Why is a tree ideally `O(log n)` depth?

* We know that each level `i` can individually store `2 ** (i - 1)`
  values.
* How many values can a tree with `k` levels store overall?
* That is, what is `\sum 2**i` for `i` from 1 to `k`?
* I immediately say `2**k - 1`.
* What is the largest three digit decimal number? 999. Right?
* The first four digit number `10**4` is the first that can not be
  stored in three digits.

---

## Versus Hash Table

* If you use self-balancing, is worst case `O(log n)`.
* No amortization from resizing. More responsive.
* Doesn't rely on hashing function.
* BTW, hashing function really is `O(log n)` if the hash looks at all
  the bits of the value.
* Persistent.
* Most of all: in-order traversal and range queries.

---

## `range(vertex, min, max)`

* If `vertex.nil?` return `[]`.
* If `min < vertex.value`, recurse on the left.
* If `vertex.value < max`, add in `vertex.value`.
* if `vertex.value < max`, recurse on the right.
* `O(n)`.

---

## Range Queries Uses

* Keep filesystem in a BST, list all subfiles.
* Keep a dictionary in a BST, return all the words that start with
  the letter "b".
* Keep Google Calendar events sorted by start-time.

---

## Sort-Merge Join

* Let's say Amazon wants to find the products you and I have *both*
  viewed in the past. We've both looked at many many items, though our
  intersection of items may be either large or small.
* Simplest way: my `m` items are in an unsorted array, your `n` items
  are in an unsorted array. We do an `O(m * n)` nested-loops join.
* Better: if our `m` items are sorted by `item_id`, we can do a single
  pass through each of the arrays. `O(m + n)` time.
* We want to interactively be able to insert/delete. Anywhere we want
  an interactive sorted array, think BST.

---

## Hash Join

* Sort-Merge is great if data is already sorted. Otherwise, sorting is
  `O(n log n)`.
* Faster to just build a hash table from one list and do lookup from
  the other.
* That hits a wall if the relations to merge don't fit in memory.

---

## Other Tree Types

* Self-Balancing Trees: AVL and Red-Black Trees
* B-Tree: a disk-friendly, self-balancing tree used for databases and
  file-systems.
* Trie (pronounced "try"): stores prefixes.

---

## Assignment

[Repository](https://github.com/appacademy/sf-job-search-curriculum/tree/master/algorithms/binary_search_trees/project/firstname_lastname/lib)