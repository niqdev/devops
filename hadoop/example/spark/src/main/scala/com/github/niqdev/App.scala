package com.github.niqdev

import org.apache.spark.sql.SparkSession

object App {

  def main(args: Array[String]): Unit = {
    val spark = SparkSession.builder
      .appName("spark-github")
      .master("local[*]")
      .getOrCreate()

    val sc = spark.sparkContext

    val homeDir = System.getenv("HOME")
    val inputPath = s"file:$homeDir/github-archive/*.json"
    val outputDir = s"file:$homeDir/github-archive/output"
    val githubLog = spark.read.json(inputPath)
    val pushes = githubLog.filter("type = 'PushEvent'")

    pushes.printSchema
    println(s"all events: ${githubLog.count}")
    println(s"only pushes: ${pushes.count}")
    pushes.show(5)

    val grouped = pushes.groupBy("actor.login").count
    grouped.show(5)
    val ordered = grouped.orderBy(grouped("count").desc)
    ordered.show(5)

    ordered.write.format("json").save(outputDir)
  }

}
