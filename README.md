# SearXNG Deployment

Docker Compose-based deployment of [SearXNG](https://github.com/searxng/searxng), a free internet metasearch engine which aggregates results from various search services while never storing information about its users.

## Features

- **Containerized**: Uses official `searxng/searxng` Docker image
- **Dual-stack networking**: Supports both IPv4 and IPv6 with configurable subnets
- **Persistent storage**: Cache and configuration preserved across restarts
- **Configurable**: Settings managed through files in `config/` directory

## Quick Start

```bash
./deploy.sh
```

This starts the SearXNG container with Docker Compose, mounting your local configuration and starting dual-stack networking.

## Configuration

Files in `config/`:

- **settings.yml** - Main SearXNG configuration (server settings, enabled engines, timeouts, etc.)
- **limiter.toml** - Rate limiting configuration (currently empty)

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `DOCKER_IMAGE` | `searxng/searxng:latest` | SearXNG Docker image |
| `SEARXNG_PORT` | `8888` | External port to expose |
| `SEARXNG_BASE_URL` | (required) | Base URL for the instance |
| `SEARXNG_SECRET_KEY` | (from settings.yml) | Server secret key |
| `IPV6_SUBNET` | `2001:db8:c::1:0/120` | IPv6 subnet for Docker network |
| `IPV6_GATEWAY` | `2001:db8:c::1:1` | IPv6 gateway address |
| `IPV6_ADDRESS` | (required) | IPv6 address for the container |

## Network

The deployment creates two Docker networks:

- **searxng-ipv4**: NAT-enabled IPv4 network with masquerading for outbound traffic
- **searxng-ipv6**: Pure IPv6 routed network (IPv4 disabled)

## Container Details

- **Volume mounts**: Configuration read-only, cache data persisted in named volume
- **Security**: Drops all capabilities except those required by SearXNG
- **Restart policy**: Always restart on failure or host reboot
- **Resource limits**: Managed by Docker Compose defaults
