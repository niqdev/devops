import sbt._

object Dependencies {

  lazy val N = new {
    val spark = "org.apache.spark"
  }

  lazy val V = new {
    val scala = "2.11.12"

    val spark = "2.2.1"

    val scalatest = "3.0.5"
  }

  lazy val libDependencies = Seq(
    N.spark %% "spark-core" % V.spark % Provided,
    N.spark %% "spark-sql" % V.spark % Provided
  )

  lazy val testDependencies = Seq(
    "org.scalatest" %% "scalatest" % V.scalatest % Test
  )

  lazy val allDependencies = libDependencies ++ testDependencies

}
