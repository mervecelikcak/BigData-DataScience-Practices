ADD JAR hdfs:///user/uambd20/libs/hadoop-pcap-serde-1.2-SNAPSHOT-jar-with-dependencies.jar;
USE uambd20;
SELECT ts,sum(len)*8 as bits FROM pcaps group by ts order by ts asc;
