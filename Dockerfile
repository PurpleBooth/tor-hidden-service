FROM ubuntu:xenial

### Environment Variables

ENV TOR_HOME /var/lib/tor
ENV TOR_PORT 80
ENV SERVICE_URI 127.0.0.1:80

### Tor

RUN echo deb http://deb.torproject.org/torproject.org xenial main >> /etc/apt/sources.list.d/tor.list && \
    echo deb-src http://deb.torproject.org/torproject.org xenial main >> /etc/apt/sources.list.d/tor.list && \
    gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 && \
    gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - && \
    apt-get update && \
    apt-get install -y tor deb.torproject.org-keyring gettext-base && \
    rm -rf /var/lib/apt/lists/*


### Entry point And Config

COPY torrc.template /torrc.template
COPY entrypoint /entrypoint
RUN chmod +x /entrypoint && chmod u+r /torrc.template && \
    chown debian-tor:debian-tor /entrypoint /torrc.template

USER debian-tor

ENTRYPOINT ["/entrypoint"]
