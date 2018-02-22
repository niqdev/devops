# Spark

Spark wasn't made with Online Transaction Processing (OLTP) applications in mind (fast, numerous, atomic transactions).
It's better suited for Online Analytical Processing (OLAP): batch jobs and data mining.

MapReduce job results need to be stored in HDFS before they can be used by another job.
For this reason, MapReduce is inherently bad with iterative algorithms.
Furthermore, many kinds of problems don’t easily fit MapReduce’s two-step paradigm.

There are two types of RDD operations: transformations and actions.
Transformations (for example, filter or map) are operations that produce a new RDD by performing some useful data manipulation on another RDD.
Actions (for example, count or foreach) trigger a computation in order to return the result to the calling program or to perform some actions on an RDD's elements.

It's important to understand that transformations are evaluated lazily, meaning computation doesn't take place until you invoke an action.