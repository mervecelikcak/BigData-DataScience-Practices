ADD JAR hdfs:///user/uambd20/libs/hadoop-pcap-serde-1.2-SNAPSHOT-jar-with-dependencies.jar;
USE uambd20;
SET net.ripe.hadoop.pcap.io.reader.class=net.ripe.hadoop.pcap.HttpPcapReader;
SELECT http_request,`header_user-agent` FROM http where http_request is not NULL;
