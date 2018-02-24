package com.github.niqdev

import org.apache.spark.sql.SparkSession

object App {

  def main(args: Array[String]): Unit = {
    val spark = SparkSession.builder
      .appName("spark-github")
      .master("local[*]")
      .getOrCreate()

    val sc = spark.sparkContext
  }

}
