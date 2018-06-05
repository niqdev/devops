# Scala

Documentations

* [Why Functional Programming Matters](https://www.cs.kent.ac.uk/people/staff/dat/miranda/whyfp90.pdf) (paper)

Definition

> An expression `e` is **referentially transparent** if, for all programs `p`,
all occurrences of `e` in `p` can be replaced by the result of evaluating `e` without affecting the meaning of `p`.
A function `f` is **pure** if the expression `f(x)` is referentially transparent for all referentially transparent `x`.
Hence a pure function is **modular** and **composable**

> A **higher-order function** is a function that takes other functions as arguments or returns a function as result

> A **recursive function** is a function which calls itself.
A **tail recursive function** is a special case of recursion in which the last instruction executed in the method is the recursive call.
As long as the recursive call is in tail position, Scala detects compiles it to the same sort of bytecode as would be emitted for a while loop

