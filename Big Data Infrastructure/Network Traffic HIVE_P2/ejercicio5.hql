ADD JAR hdfs:///user/uambd20/libs/hadoop-pcap-serde-1.2-SNAPSHOT-jar-with-dependencies.jar;
USE uambd20;
SET net.ripe.hadoop.pcap.io.reader.class=net.ripe.hadoop.pcap.HttpPcapReader;
SELECT http_response, count(*) as nresp FROM http where http_response is not NULL group by http_response sort by nresp asc;
