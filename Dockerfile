###############################################################################
# Dockerfile to build Ubuntu image with Kafka and Zookeeper
###############################################################################

# Set base to Ubuntu
FROM ubuntu

# Declare version placeholders
ENV KAFKA_VERSION 0.10.2.0
ENV SCALA_VERSION 2.11
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

MAINTAINER Raghu Ravi

# Update repository and install open-jdk java8, zookeeper and download kafka
RUN apt-get update && \
    apt-get install -y openjdk-8-jre && \
    apt-get install -y zookeeper wget supervisor dnsutils && \
    apt-get install -y nano && \
    rm -rf /var/lib/apt/lists/* &&\
    wget -q http://download.nextag.com/apache/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz && \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt && \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

# Add the scripts to start zookeper amd kafka
ADD scripts/start-kafka.sh /usr/bin/start-kafka.sh

# Add the supervisor configuration files for zookeper and kafka
ADD supervisor/kafka.conf supervisor/zookeeper.conf /etc/supervisor/conf.d/

# Expose zookeper and kafka port
EXPOSE 2181 9092

# Start supervisor in background
CMD /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
