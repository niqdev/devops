package com.github.niqdev
package internal

trait ConsoleOut[F[_]] {
  def println[A: Show](a: A): F[Unit]
}

object ConsoleOut {

  def apply[F[_]](implicit F: ConsoleOut[F]): ConsoleOut[F] = F

  implicit def consoleOut: ConsoleOut[IO] =
    new ConsoleOut[IO] {
      override def println[A: Show](a: A): IO[Unit] =
        IO(scala.Console.println(a))
    }
}
