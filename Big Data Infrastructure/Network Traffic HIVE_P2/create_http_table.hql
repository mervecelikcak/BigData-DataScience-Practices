ADD JAR hdfs:///user/uambd20/libs/hadoop-pcap-serde-1.2-SNAPSHOT-jar-with-dependencies.jar;
USE uambd20;
SET net.ripe.hadoop.pcap.io.reader.class=net.ripe.hadoop.pcap.HttpPcapReader;
CREATE DATABASE IF NOT EXISTS uambd20;
USE uambd20;
DROP TABLE http;
CREATE EXTERNAL TABLE http(ts bigint, protocol string, src string, src_port string, dst string, dst_port string, len int, http_headers string, `header_user-agent`string, `header_host`string, `header_content-type`string, `header_location`string, http_request string, http_response string)
ROW FORMAT SERDE 'net.ripe.hadoop.pcap.serde.PcapDeserializer'
STORED AS INPUTFORMAT 'net.ripe.hadoop.pcap.mr1.io.PcapInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 'hdfs:/user/uambd20/pcaps/';
