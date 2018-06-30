# Scala

> TODO question-answer style

## Fundamentals

* [Programming in Scala](https://www.artima.com/shop/programming_in_scala) (2016)(3rd) by Martin Odersky, Lex Spoon, and Bill Venners (Book)
* [Akka in Action](https://www.manning.com/books/akka-in-action) (2016) by Raymond Roestenburg, Rob Bakker, and Rob Williams (Book)
* [Tour of Scala](https://docs.scala-lang.org/tour/tour-of-scala.html)
* [Twitter Scala School](https://twitter.github.io/scala_school)
* [Scala Puzzlers](http://scalapuzzlers.com)
* [S-99: Ninety-Nine Scala Problems](http://aperiodic.net/phil/scala/s-99)
* [Scala Exercises](https://www.scala-exercises.org)

> TODO

## Collections

* [Documentation](https://docs.scala-lang.org/overviews/collections/introduction.html)

> TODO

## Functional Programming

* [Functional Programming in Scala](https://www.manning.com/books/functional-programming-in-scala) (2014) by Paul Chiusano and Runar Bjarnason (Book)
* [Scala High Performance Programming](https://www.packtpub.com/application-development/scala-high-performance-programming) (2016) by Vincent Theron, Michael Diamant (Book)
* [Scala with Cats](https://underscore.io/books/scala-with-cats) (Book)
* [Why Functional Programming Matters](https://www.cs.kent.ac.uk/people/staff/dat/miranda/whyfp90.pdf) (paper)
* [The Essence of the Iterator Pattern](https://www.cs.ox.ac.uk/jeremy.gibbons/publications/iterator.pdf) (paper)
* [Applicative programming with effects](http://www.staff.city.ac.uk/~ross/papers/Applicative.pdf) (paper)
* [Stack Safety for Free](http://functorial.com/stack-safety-for-free/index.pdf) (paper)
* [Stackless Scala With Free Monads](http://blog.higher-order.com/assets/trampolines.pdf) (paper)
* [Learn You a Haskell for Great Good!](http://learnyouahaskell.com/chapters)

> TODO

### Typeclass

* [Type Classes as Objects and Implicits](http://ropas.snu.ac.kr/~bruno/papers/TypeClasses.pdf) (paper)
* [Returning the "Current" Type in Scala](http://tpolecat.github.io/2015/04/29/f-bounds.html)
* [Typeclass 101: ad hoc polymorphism in scala](https://julien-truffaut.github.io/Typeclass)
* [All you don't need to know about Typeclasses](http://workday.github.io/assets/scala-exchange-type-classes)

> TODO

http://learnyouahaskell.com/types-and-typeclasses#typeclasses-101
https://markhneedham.com/blog/2012/05/22/scalahaskell-a-simple-example-of-type-classes/
http://www.casualmiracles.com/2012/05/03/a-small-example-of-the-typeclass-pattern-in-scala/

### Semigroup, Functor, Applicative and Monad

> TODO

https://medium.com/@sinisalouc/demystifying-the-monad-in-scala-cc716bb6f534
https://bartoszmilewski.com/2014/10/28/category-theory-for-programmers-the-preface/
http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html
http://www.marcoyuen.com/articles/2016/09/08/stackless-scala-1-the-problem.html

TODO
```
algebraic data type
a monad is a typeclass with a unit and flatMap method
Scala enables the typeclass pattern using traits and implicits - ad-hoc (by function) polymorphism ? alternative to inheritance ?

Type classes are a powerful tool used in functional programming to enable ad-hoc polymorphism, more commonly known as overloading. Where many object-oriented languages leverage subtyping for polymorphic code, functional programming tends towards a combination of parametric polymorphism (think type parameters, like Java generics) and ad-hoc polymorphism.
```

## Best practices and tips

> TODO

---

```
# best practices
https://stackoverflow.com/questions/5827510/how-to-override-apply-in-a-case-class-companion

# type projector
https://typelevel.org/blog/2015/07/13/type-members-parameters.html

# jvm stack
https://www.artima.com/insidejvm/ed2/jvm8.html
https://alvinalexander.com/scala/fp-book/recursion-jvm-stacks-stack-frames
```

---

![scala-hierarchy](img/scala-hierarchy.png)

An expression `e` is **referentially transparent** if, for all programs `p`,
all occurrences of `e` in `p` can be replaced by the result of evaluating `e` without affecting the meaning of `p`.
A function `f` is **pure** if the expression `f(x)` is referentially transparent for all referentially transparent `x`.
Hence a pure function is **modular** and **composable**

A **higher-order function** is a function that takes other functions as arguments or returns a function as result

A **recursive function** is a function which calls itself. With **head recursion**, the recursive call is not the last instruction in the function.
A **tail recursive function** is a special case of recursion in which the last instruction executed in the method is the recursive call.
As long as the recursive call is in tail position, Scala detects compiles it to the same sort of bytecode as would be emitted for a while loop
```scala
def factorial(n: Int): Int = {
  @tailrec
  def loop(index: Int, result: Int): Int = index match {
    case i if i == 0 => loop(1, 1 * result)
    case i if i < n => loop(i + 1, i * result)
    case i => i * result
  }
  loop(0, 1)
}
```

**Function literal** is a synonyms for **anonymous function**.
Because functions are just ordinary Scala objects, we say that they are **first-class values**.
A function literal is syntactic sugar for an object with a method called apply
```scala
val lessThan0 = (a: Int, b: Int) => a < b
val lessThan1 = (a, b) => a < b
val lessThan2 = new Function2[Int, Int, Boolean] {
  override def apply(a: Int, b: Int): Boolean = a < b
}
```

A **variadic** function accepts zero or more arguments. It provides a little syntactic sugar for creating and passing a Seq of elements explicitly. The special `_*` type annotation allows us to pass a Seq to a variadic method
```scala
sealed trait MyList[+A]
case object MyNil extends MyList[Nothing]
case class MyCons[+A](head: A, tail: MyList[A]) extends MyList[A]

object MyList {
  def apply[A](list: A*): MyList[A] =
    if (list.isEmpty) MyNil
    else MyCons(list.head, apply(list.tail: _*))
}

// usage
MyList(1, 2, 3, 4, 5)
```

An **algebraic data type** (ADT) is just a data type defined by one or more data constructors, each of which may contain zero or more arguments.
We say that the data type is the sum or union of its data constructors, and each data constructor is the product of its arguments, hence the name algebraic data type
```scala
sealed trait Tree[+A]
case class Leaf[A](value: A) extends Tree[A]
case class Branch[A](left: Tree[A], right: Tree[A]) extends Tree[A]
```

---

The [AnyVal](https://docs.scala-lang.org/overviews/core/value-classes.html) class can be used to define a **value class**, which is optimized at compile time to avoid the allocation of an instance
```scala
case class Price(value: BigDecimal) extends AnyVal {
  def lowerThan(p: Price): Boolean = this.value < p.value
}
```

**Specialization** with `@specialized` annotation, refers to the compile-time process of generating duplicate versions of a generic trait or class that refer directly to a primitive type instead of the associated object wrapper. At runtime, the compiler-generated version of the generic class (or, as it is commonly referred to, the specialized version of the class) is instantiated. This process eliminates the runtime cost of boxing primitives, which means that you can define generic abstractions while retaining the performance of a handwritten, specialized implementation although it has some [quirks](http://aleksandar-prokopec.com/2013/11/03/specialization-quirks.html)

The JVM defines primitive types (`boolean`, `byte`, `char`, `float`, `int`, `long`, `short` and `double`) that are *stack-allocated rather than heap-allocated*. When a generic type is introduced, for example, `scala.collection.immutable.List`, the JVM references an object equivalent, instead of a primitive type. For example, an instantiated list of integers would be heap-allocated objects rather than integer primitives. The process of converting a primitive to its object equivalent is called boxing, and the reverse process is called unboxing. Boxing is a relevant concern for performance-sensitive programming because boxing involves heap allocation. In performance-sensitive code that performs numerical computations, the cost of [boxing and unboxing](https://docs.oracle.com/javase/tutorial/java/data/autoboxing.html) can can create significant performance slowdowns

In scenarios involving simple pattern match statements that directly match a value, using `@switch` annotation provides a warning at compile time if the switch can't be compiled to a tableswitch or lookupswitch which procides better performance, because it results in a branch table rather than a decision tree

---

TODO

```scala
// to remember: foldLeft start from left (acc op xFirst) ==> (B, A)
// to remember: foldRight start from right (xLast op acc) ==> (A, B)
```

In Scala, all methods whose names end in : are right-associative. That is, the expression x :: xs is actually
the method call xs.::(x) , which in turn calls the data constructor ::(x,xs)

* curry function used to assist type inference when passing anonymous functions

* companion object
* a **variadic function** accepts zero or more arguments
* algebraic data type (ADT)
* volatile
* compare and swap
* javap
* diamond inheritance problem
* variance / covariance of type A

```scala

// + covariant
// List[Dog] is considered a subtype of List[Animal], assuming Dog is a subtype of Animal
sealed trait List[+A]
// Nothing is a subtype of all types
case object Nil extends List[Nothing]
case class Cons[+A](head: A, tail: List[A]) extends List[A]
```

<br>
