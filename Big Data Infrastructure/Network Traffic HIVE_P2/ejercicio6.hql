ADD JAR hdfs:///user/uambd20/libs/hadoop-pcap-serde-1.2-SNAPSHOT-jar-with-dependencies.jar;
USE uambd20;
SET net.ripe.hadoop.pcap.io.reader.class=net.ripe.hadoop.pcap.DnsPcapReader;
SELECT dns_qname, count(*) as requests
FROM dns
WHERE dns_qr=false
GROUP BY dns_qname
ORDER BY requests DESC;
