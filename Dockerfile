FROM netflixoss/java:7

ENV REV=0.0.4
RUN cd /tmp \
  && apt-get update \
  && apt-get install -y ca-certificates git unzip \
  && git clone https://github.com/Netflix/Prana.git ./prana \
  && cd prana \
  && git fetch --tags \
  && git checkout tags/${REV} \
  && ./gradlew distZip \
  && cd / \
  && unzip /tmp/prana/build/distributions/Prana-${REV}.zip \
  && mv Prana-${REV} prana
ADD config /prana/config

WORKDIR /prana
ENTRYPOINT ["/prana/bin/Prana"]
CMD ["-c", "/prana/config"]
