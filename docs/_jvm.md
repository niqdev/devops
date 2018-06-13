# JVM

Documentation

* [HdrHistogram](http://hdrhistogram.org)

Definition

> **Latency** describes the amount of time that it takes for an observed process to be completed

> **Throughput** defines the observed rate at which a process is completed

> A **bottleneck** refers to the slowest part of the system

> A common mistake is to rely on *averages* to measure the performance of a system because it is a lossy summary statistic.
A **percentile** is a measurement indicating the value below which a given percentage of observations in a group of observations fall

> **Benchmarks** are a black-box kind of measurement. Benchmarks assess a whole system's performance by submitting various kinds of load as input and measuring latency and throughput as system outputs

> A **profiler** enables white-box testing to help you identify bottlenecks by capturing the execution time and resource consumption of each part of your
program. Most profilers instrument the code under observation, either at compile time or runtime, to inject counters and profiling components. This instrumentation imposes a runtime cost that degrades system throughput and latency

<br>
