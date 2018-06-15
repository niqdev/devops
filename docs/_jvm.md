# JVM

Documentation

* [The Java Virtual Machine Specification](https://docs.oracle.com/javase/specs/jvms/se8/jvms8.pdf)
* [JVM Architecture 101](https://blog.takipi.com/jvm-architecture-101-get-to-know-your-virtual-machine)
* [JVM Internals](http://blog.jamesdbloom.com/JVMInternals.html)
* [Java Code to Byte Code](http://blog.jamesdbloom.com/JavaCodeToByteCode_PartOne.html)

![jvm-architecture](img/jvm-architecture.png)

## Java Memory Management

### Stack

The stack is a First In Last Out data structure managed by the JVM i.e. push to the top, pull or pop from the top. Every thread has its own stack and data can be seen only by that thread

Each time you call a function, Java pushes the local variables for that function onto the stack. A copy of the value is passed to the methods. When the method returns, all the data are popped or pulled from the stack

When you reach a closing curly bracket (not only after a return) any local variables declared inside the block you are leaving is popped from the stack and destroyed, this is how scope works

### Heap

The Heap allows to store data that has a longer lifetime than a single code block or function e.g. objects that need to be shared across multiple methods

All the memory in the JVM is mainly heap, is massive compared with the stack and there is only one heap shared across all the threads and a number of stacks (each thread has its own stack)

### Variables

How variable are store in Java

* objects are stored physically on the heap
* variables are a reference to the object
* local variables are stored on the stack
* primitive vaiables resides entirely in the stack

```
int age = 30
String name = "niqdev"

Stack          Heap
[  name* ] --> [ "niqdev" ]
[  age   ]
```

In Java variable can *only* be passed by values i.e. a new variable is added in the stack

Passing by reference is *not* possible, but don't confuse that when objects are passed into methods, *the **reference** of the object is passed **by value***

`final` keyword means that the value can only be assigned once (can be assigned later), but we can change the value referenced by the object. Lack of const correctness in Java: `const` unfortunately is a reserved keyword and cannot be used, but allows to freeze the whole state of the object internally: *mutable states are bad!*

Example
```java
final Customer c = new Customer("a")
// or
final Customer c
c = new Customer("a")

// this is NOT allowed - compiler error
c = new Customer("b")
// but this yes
c.setName("b")
```

### String

As a general rule of thumb, all objects are stored in the heap and only references are stored in the stack. In reality the jvm for optimization maybe store some objects also in the stack, but this is not visibile. Strings are immutable and if "short" are stored in a pool in the heap to be reused.

When you create a new string with quotes `"hello"`, the JVM creates and retrieve the string from a constant pool. To create a new object every time use the `new String("hello")`. To force a lookup in the pool use `intern()`. Use `==` to compare the reference (address in memory)

```java
String s1 = "hello";
String s2 = "hello";
String s3 = new String("hello");
String s4 = new String("hello").intern();

// true - 2 strings created using quotes refer to the same object
System.out.println(s1 == s2);
// false - if you create a string using new operator
// it's not a part of the constant pool, so objects are different
System.out.println(s1 == s3);
// true - if you call intern() method Java adds current string to the string pool
// and 2 string become the same object
System.out.println(s1 == s4);
```

### Garbage collection

**Garbage collection** removes object no more referenced in the heap from the stack. Most of the objects don't live for long, if an object survives it is likely to live forever. **Mark and sweep** is the algorithm used: instead of look for all the objects that must be removed, it looks for the object that need to be retained

* all the threads in the application are paused (stop the world event)
* follow all the references from the stack and mark it as alive
* full scan an all the heap and wipe unmarked reference
* reorder contiguos memory in order to avoid fragmentation
* more stuff there is to clean, more is faster cos it looks only for what to retain

**Generational garbage collection** is a way to organize the heap into 2 section to try to avoid freeze the application while garbage collecting the whole heap:

* **young generation** is small, so gc is quick, after gc reference are moved in old generation heap (few fraction of seconds to scan)
* **old generation** no gc scan usually, only if needed i.e. when is full (few seconds to scan)
* young generation is divided in Eden, Survivor0 and Survivor1
* new objects are created in the Eden
* when eden gets full, objects are moved in the Survivor space and moved amongs the two alternatively to be compacted
* memory is reserved in the heap for S0 and S1 even if not used
* after an object survived 8 generations (movement and compacting between Survivor collection) then is stored in the old generation
* VM can change the number of generations (default is 8) based on the amount of memory available
* old generation is also called Tenured
* class variables (static variables) are stored as part of the class object associated with that class and stored in the permanent generation (PermGen) prior Java 8 or in the MetaSpace

![jvm-gc](img/jvm-gc.png)

Run `jvisualvm` and add `Visual GC` plugin

**Memory leak** are objects that are not free in the heap and continue to consume memory also after the program finish. Memory leaks are difficult to find. Java avoid memory leaks by running on a virtual machine the garbage collector (invented in lisp around 1959).
Any object on the heap which cannot be reached through a reference from the stack is *eligible for garbage collection*

User can not clear memory, with `Runtime.getRuntime().gc()` or `System.gc()` you can suggest JVM to run garbage collection, but there is no guarentee.
You should never in generally invoke `gc()` directly. While it is running the application is temporarily supsended and it will pause all the threads.
`finalize()` is invoked when object is garbage collected, but there is absolutely no guarentee if and when it will happen.
Is useful to check for example memory leak, as warning, if some resouces were not closed properly

**Soft leak** happens when an object is referenced on the stack even thought it will never be used again

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

> The **coordinated omission problem** happen we you measure the time required to process a command without taking into account the time the command had to wait to be processed

> **Java Flight Recorder (JFR)** is a tool for collecting, diagnosing, and profiling data about a running Java application. It is integrated into the Java Virtual Machine and causes almost no performance overhead and is able to access data outside of **JVM safepoints**. Safepoints are necessary
to coordinate global JVM activities, including stop-the-world garbage collection

> **Java Mission Control (JMC)** allows to connect to a running Java application via JMX and capture runtime information from the Flight Recorder (JFR), executing commands via JMX or displaying reports from JFR sessions

> The **Just-In-Time (JIT)** compiler is a component of the Java Runtime Environment that improves the performance of Java applications at run time. Java programs consists of classes, which contain platform neutral bytecode that can be interpreted by a JVM on many different computer architectures.
At run time, the JVM loads the class files, determines the semantics of each individual bytecode, and performs the appropriate computation.
The additional processor and memory usage during interpretation means that a Java application performs more slowly than a native application.
The JIT compiler helps improve the performance of Java programs by compiling bytecode into native machine code at run time


<br>
