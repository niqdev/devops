package com.github.niqdev
package internal

// https://github.com/jdegoes/lambdaconf-2014-introgame#effectful-monads
// https://github.com/alvinj/IOMonad/blob/master/src/main/scala/io_monad/IO.scala
// https://devth.com/2015/monad-laws-in-scala
// https://github.com/barambani/laws
class IO[A] private(run0: => A) {

  def run: A = run0

  // execute and suspend again
  def flatMap[B](f: A => IO[B]): IO[B] =
    IO(f(run).run)

  def map[B](f: A => B): IO[B] =
    flatMap(a => IO(f(a)))

}

object IO {

  def apply[A](a: => A): IO[A] = new IO(a)
}
