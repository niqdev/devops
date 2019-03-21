package com.github.niqdev
package internal

trait Show[T] {

  def show(t: T): String

}

object Show {

  implicit val stringShow: Show[String] =
    (t: String) => t

}
