import Dependencies.{V, allDependencies}

lazy val root = (project in file(".")).
  settings(
    inThisBuild(List(
      organization := "com.github.niqdev",
      scalaVersion := V.scala,
      version := "0.1.0-SNAPSHOT"
    )),
    name := "spark",
    libraryDependencies ++= allDependencies
  )
