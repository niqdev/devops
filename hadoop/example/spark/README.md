# spark

```
sbt test
sbt package


spark-submit \
  --class "com.github.niqdev.App" \
  --master local[4] \
  /vagrant/example/spark/target/scala-2.11/spark-github_2.11-0.1.0-SNAPSHOT.jar
```
