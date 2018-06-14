# Java Virtual Machine

## Perfomance

Documentation

* [HdrHistogram](http://hdrhistogram.org)
* [Understanding JIT compiler](https://aboullaite.me/understanding-jit-compiler-just-in-time-compiler)
* [Understanding Java JIT Compilation with JITWatch](http://www.oracle.com/technetwork/articles/java/architect-evans-pt1-2266278.html)
* [Coordinated Omission](https://groups.google.com/forum/#!msg/mechanical-sympathy/icNZJejUHfE/BfDekfBEs_sJ)
* [Java Flight Recorder](https://docs.oracle.com/javacomponents/jmc-5-5/jfr-runtime-guide/about.htm#JFRRT107)
* [Safepoints in HotSpot JVM](http://blog.ragozin.info/2012/10/safepoints-in-hotspot-jvm.html)
* [Java Mission Control (JMC) and Flight Recorder (JFR)](https://www.hascode.com/2017/10/java-mission-control-jmc-and-flight-recorder-jfr)

Definition

> **Latency** describes the amount of time that it takes for an observed process to be completed

> **Throughput** defines the observed rate at which a process is completed

> A **bottleneck** refers to the slowest part of the system

> A common mistake is to rely on *averages* to measure the performance of a system because it is a lossy summary statistic.
A **percentile** is a measurement indicating the value below which a given percentage of observations in a group of observations fall

> **Benchmarks** are a black-box kind of measurement. Benchmarks assess a whole system's performance by submitting various kinds of load as input and measuring latency and throughput as system outputs

> A **profiler** enables white-box testing to help you identify bottlenecks by capturing the execution time and resource consumption of each part of your
program. Most profilers instrument the code under observation, either at compile time or runtime, to inject counters and profiling components. This instrumentation imposes a runtime cost that degrades system throughput and latency

> The **Just-In-Time (JIT)** compiler is a component of the Java Runtime Environment that improves the performance of Java applications at run time. Java programs consists of classes, which contain platform neutral bytecode that can be interpreted by a JVM on many different computer architectures.
At run time, the JVM loads the class files, determines the semantics of each individual bytecode, and performs the appropriate computation.
The additional processor and memory usage during interpretation means that a Java application performs more slowly than a native application.
The JIT compiler helps improve the performance of Java programs by compiling bytecode into native machine code at run time

> The **coordinated omission problem** happen we you measure the time required to process a command without taking into account the time the command had to wait to be processed

> **Java Flight Recorder (JFR)** is a tool for collecting, diagnosing, and profiling data about a running Java application. It is integrated into the Java Virtual Machine and causes almost no performance overhead and is able to access data outside of **JVM safepoints**. Safepoints are necessary
to coordinate global JVM activities, including stop-the-world garbage collection

> **Java Mission Control (JMC)** allows to connect to a running Java application via JMX and capture runtime information from the Flight Recorder (JFR), executing commands via JMX or displaying reports from JFR sessions

<br>
