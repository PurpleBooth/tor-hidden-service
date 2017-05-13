# Tor Hidden Service Docker Container

Simple container to make a service available over tor. This is not a minimal
container, rather being built onto of Ubuntu xenial so we can use the official
packages and repository for tor.

## Running

```
export PRIVATE_KEY=$(cat private_key)
export HOSTNAME=$(cat hostname)
docker-compose up
```

Then connect to your service through tor. You'll see a hello world message if it
has worked.

Using docker-compose in production probably isn't advisable. You probably want 
to use Deis, Kubernetes, Docker Swarm or similar to deploy it for real.

## Environment Variables

* `TOR_PORT=80` Port to expose the service on inside tor
* `SERVICE_URI=your-service:80` URI for tor to connect to the service on
* `HOSTNAME=eesh4eeChiepitee5rai.onion` Your services hostname
* `PRIVATE_KEY=-----BEGIN RSA PRIVATE KEY-----...` The private key. Can be
  multiline.

## Parameters

None required.

If you provide any it'll run them, so:

```
$ docker run tor-container echo 1234
1234
```

## Ports

All the magic happens in the tor service, so no ports are exposed.

## License

See [LICENSE.md](LICENSE.md)
