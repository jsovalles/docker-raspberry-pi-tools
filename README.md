# docker-raspberry-pi-tools

Collection of Docker Compose configurations and scripts tailored for efficient deployment and management of applications on Raspberry Pi.

## Pre-requisites

### Docker Installation for Raspberry Pi

To install Docker on a Raspberry Pi with a 64-bit operating system, follow the instructions provided in the official Docker documentation:

[Docker Engine Installation for Debian](https://docs.docker.com/engine/install/debian/)

## Environment Variables

To run this project, you need to define the following environment variables in an `.env` file located in the root directory of your project.

```dotenv
## Grafana

GF_SECURITY_ADMIN_USER=your_user
GF_SECURITY_ADMIN_PASSWORD=your_pass
GF_USERS_ALLOW_SIGN_UP=false

GF_PATHS_CONFIG=/etc/grafana/grafana.ini
GF_PATHS_DATA=/var/lib/grafana
GF_PATHS_HOME=/usr/share/grafana
GF_PATHS_LOGS=/var/log/grafana
GF_PATHS_PLUGINS=/var/lib/grafana/plugins
GF_PATHS_PROVISIONING=/etc/grafana/provisioning
GF_DASHBOARDS_DEFAULT_HOME_DASHBOARD_PATH=/etc/grafana/provisioning/dashboards/rpi-monitoring.json

## InfluxDB
#INFLUXDB_DB=prometheus # Change influxdb db on prometheus.yml if you change this
#INFLUXDB_ADMIN_USER=your_user
#INFLUXDB_ADMIN_PASSWORD=your_pass

## wg-easy
# ⚠️ Change the server's hostname (clients will connect to):
WG_HOST=your.domain.com
# ⚠️ Change the Web UI Password:
PASSWORD=your_ui_pass
# 💡 This is the Pi-Hole Container's IP Address
WG_DEFAULT_DNS=default.dns
## For split tunnel use
# WG_ALLOWED_IPS=192.168.0.0/24,10.8.0.0/24
WG_PERSISTENT_KEEPALIVE=25
PORT=your_port
WG_PORT=your_port
# Optional:
# WG_DEFAULT_ADDRESS=10.8.0.x
# WG_MTU=1420
# WG_PERSISTENT_KEEPALIVE=25
# WG_PRE_UP=echo "Pre Up" > /etc/wireguard/pre-up.txt
# WG_POST_UP=echo "Post Up" > /etc/wireguard/post-up.txt
# WG_PRE_DOWN=echo "Pre Down" > /etc/wireguard/pre-down.txt
# WG_POST_DOWN=echo "Post Down" > /etc/wireguard/post-down.txt
# UI_TRAFFIC_STATS=true
# UI_CHART_TYPE=0 # (0 Charts disabled, 1 # Line chart, 2 # Area chart, 3 # Bar chart)

# Pi-hole Environment Variables
TZ=your_timezone
WEBPASSWORD=your_web_password
FTLCONF_LOCAL_IPV4=your_raspberri_pi_ipv4
```

## Tools Used

- **[Grafana](https://grafana.com/docs/)**: Platform for monitoring and observability with customizable dashboards.

- **[Prometheus](https://prometheus.io/docs/introduction/overview/)**: Systems monitoring and alerting toolkit, optimized for time-series data.

- **[InfluxDB](https://docs.influxdata.com/influxdb/v1.8/introduction/)**: Time-series database for handling metrics and events with high write and query loads.

- **[Node Exporter](https://prometheus.io/docs/guides/node-exporter/)**: Prometheus exporter for hardware and OS metrics from \*NIX systems.

- **[cAdvisor](https://github.com/google/cadvisor)**: Daemon for monitoring and analyzing resource usage of running containers.

- **[wg-easy](https://github.com/wg-easy/wg-easy)**: Web interface for easy management of a WireGuard VPN server.

- **[Pi-hole](https://github.com/pi-hole/docker-pi-hole)**: Network-wide ad blocker that acts as a DNS sinkhole to block unwanted content.

- **[Unbound](https://github.com/MatthewVance/unbound-docker-rpi)**: Validating, recursive, caching DNS resolver focused on privacy and security.

## Common Problems

### Docker stats doesn't report memory usage

If you notice that cAdvisor is not reporting memory usage, you can resolve this by enabling memory cgroup in your Raspberry Pi configuration:

1. Open the `/boot/firmware/cmdline.txt` file in a text editor.
2. Add the following parameters to the end of the line:

```bash
cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1
```

3. Save the file and reboot your Raspberry Pi.

For more details, you can refer to this [GitHub issue comment](https://github.com/docker/for-linux/issues/1112#issuecomment-699512425).

### Bandwidth issues between a WireGuard Peer and a WireGuard server

If you experience bandwidth issues between a WireGuard peer and the WireGuard server, adjusting the MTU (Maximum Transmission Unit) can help improve the connection.

1. Change the client's MTU setting to 1200. This can often resolve the issue.
2. If the problem persists, you may need to find the optimal MTU for your specific network conditions. Refer to the following [gist](https://gist.github.com/nitred/f16850ca48c48c79bf422e90ee5b9d95) for detailed instructions on determining the best MTU setting.
