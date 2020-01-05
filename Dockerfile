FROM ubuntu:bionic

### Environment Variables

ENV TOR_HOME /var/lib/tor
ENV TOR_PORT 80
ENV SERVICE_URI 127.0.0.1:80

### Tor

RUN apt update && \
    apt install -y apt-transport-https curl gnupg && \
    echo deb https://deb.torproject.org/torproject.org bionic main >> /etc/apt/sources.list.d/tor.list && \
    echo deb-src https://deb.torproject.org/torproject.org bionic main >> /etc/apt/sources.list.d/tor.list && \
    curl https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --import && \
    gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - && \
    apt update && \
    apt install -y tor deb.torproject.org-keyring gettext-base && \
    rm -rf /var/lib/apt/lists/*


### Entry point And Config

COPY torrc.template /torrc.template
COPY entrypoint /entrypoint
RUN chmod +x /entrypoint && chmod u+r /torrc.template && \
    chown debian-tor:debian-tor /entrypoint /torrc.template

USER debian-tor

ENTRYPOINT ["/entrypoint"]
