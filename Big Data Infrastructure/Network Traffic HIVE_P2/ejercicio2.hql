ADD JAR hdfs:///user/uambd20/libs/hadoop-pcap-serde-1.2-SNAPSHOT-jar-with-dependencies.jar;
USE uambd20;
SELECT min(ts) as first_packet, max(ts) as last_packet, src, src_port, dst, dst_port, protocol, sum(len) as bytes, count(*) as packets
FROM pcaps
WHERE src is not NULL and dst is NOT NULL
GROUP BY src, src_port, dst, dst_port, protocol
ORDER BY bytes DESC;
