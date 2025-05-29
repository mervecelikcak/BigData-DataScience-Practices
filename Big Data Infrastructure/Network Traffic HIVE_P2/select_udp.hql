ADD JAR hdfs:///user/uambd20/libs/hadoop-pcap-serde-1.2-SNAPSHOT-jar-with-dependencies.jar;
USE uambd20;
SELECT src,sum(len) as bytes FROM pcaps where protocol='UDP' group by src order by bytes;
