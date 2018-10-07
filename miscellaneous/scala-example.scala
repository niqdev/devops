object Example {
  def helloFor =
    for {
      i <- List(1, 2, 3, 4)
      j <- List(3, 4, 5, 6)
      if i == j
    } yield i
}
