FROM python:alpine

RUN apk add --no-cache dcron && \
    pip3 install speedtest-cli

COPY run_test.sh /etc/periodic/15min/run_speedtest
COPY ./docker-entry.sh /usr/local/bin

ENTRYPOINT ["docker-entry.sh"]
CMD ["/usr/sbin/crond", "-f"]
