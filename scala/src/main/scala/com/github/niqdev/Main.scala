package com.github.niqdev

import com.github.niqdev.internal.{ConsoleOut, IO}

object Main extends App {

  val hello = ConsoleOut[IO].println("Hello World")

  val program: IO[Unit] =
    for {
      _ <- hello
      _ <- hello
    } yield ()

  program.run

}
