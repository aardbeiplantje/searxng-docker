# AGENTS.md

## Deployment

```bash
./deploy.sh          # starts SearXNG via docker compose (requires env vars)
```

**Required env vars**: `SEARXNG_BASE_URL`, `IPV6_ADDRESS`, `IPV6_SUBNET`, `IPV6_GATEWAY`

The script sets `APP_NAME=searxng` (default), uses `${LOGNAME}` for container/network naming. Override image with `DOCKER_IMAGE`. Expose port via `SEARXNG_PORT` (default 8888).

## Structure

- **docker-compose.yml** — single service `searxng`; no build context, pulls from Docker Hub (`pull_policy: always`)
- **config/** — mounted read-only into `/etc/searxng` inside container:
  - `settings.yml` — main SearXNG config (engines, timeouts, server settings)
  - `limiter.toml` — rate limiting (currently empty)
- **cache volume** — named volume at `/var/cache/searxng` (128m tmpfs mount in container)

## Container constraints

- Read-only filesystem; temp dirs mounted as tmpfs with size limits
- All capabilities dropped except SETUID, SETGID, NET_BIND_SERVICE
- Memory limit: 512m (hard), cpus: 0.8, pids_limit: 100, shm_size: 4m
- Dual-stack networking: IPv4 masqueraded + IPv6 routed via custom bridge
