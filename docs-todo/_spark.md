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

Data partitioning is Spark’s mechanism for dividing data between multiple nodes in a cluster.

Physical movement of data between partitions is called shuffling.
It occurs when data from multiple partitions needs to be combined in order to build partitions for a new RDD.
When grouping elements by key, for example, Spark needs to examine all of the RDD's partitions, find elements with the same key, and then physically group them, thus forming new partitions.

The spark.shuffle.consolidateFiles parameter specifies whether to consolidate intermediate files created during a shuffle.
For performance reasons, we recommend that you change this to true (the default value is false ) if you’re using an ext4 or XFS filesystem.

Coalesce is used for either reducing or increasing the number of partitions and force shuffling
