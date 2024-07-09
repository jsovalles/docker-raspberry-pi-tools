# docker-raspberry-pi-tools

Collection of Docker Compose configurations and scripts tailored for efficient deployment and management of applications on Raspberry Pi.

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

## InfluxDB and prometheus
INFLUXDB_DB=prometheus # Change influxdb db on prometheus.yml if you change this
INFLUXDB_ADMIN_USER=your_user
INFLUXDB_ADMIN_PASSWORD=your_pass

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
# Optional:
PORT=your_port
WG_PORT=your_port
# WG_DEFAULT_ADDRESS=10.8.0.x
# WG_MTU=1420
# WG_PERSISTENT_KEEPALIVE=25
# WG_PRE_UP=echo "Pre Up" > /etc/wireguard/pre-up.txt
# WG_POST_UP=echo "Post Up" > /etc/wireguard/post-up.txt
# WG_PRE_DOWN=echo "Pre Down" > /etc/wireguard/pre-down.txt
# WG_POST_DOWN=echo "Post Down" > /etc/wireguard/post-down.txt
# UI_TRAFFIC_STATS=true
# UI_CHART_TYPE=0 # (0 Charts disabled, 1 # Line chart, 2 # Area chart, 3 # Bar chart)
```

## Tools Used

This project uses several tools to provide a comprehensive monitoring and management solution for applications running on a Raspberry Pi. Below is a list of the services included in the Docker Compose configuration.

### [Grafana](https://grafana.com/docs/)

Grafana is an open-source platform for monitoring and observability. It provides dashboards and visualizations for time-series data, making it easy to analyze and visualize metrics from different data sources.

### [Prometheus](https://prometheus.io/docs/introduction/overview/)

Prometheus is an open-source systems monitoring and alerting toolkit. It is designed for reliability and scalability, collecting and storing its metrics as time series data, recording real-time metrics in a time series database built using a HTTP pull model.

### [InfluxDB](https://docs.influxdata.com/influxdb/v1.8/introduction/)

InfluxDB is an open-source time-series database designed to handle high write and query loads. It is optimized for storing time series data, including metrics and events, and provides a powerful query language for analysis.

### [Node Exporter](https://prometheus.io/docs/guides/node-exporter/)

Node Exporter is a Prometheus exporter for hardware and OS metrics exposed by *NIX kernels. It allows for the collection of various system metrics, such as CPU, memory, disk usage, and network statistics.

### [cAdvisor](https://github.com/google/cadvisor)

cAdvisor (Container Advisor) provides container users an understanding of the resource usage and performance characteristics of their running containers. It is a running daemon that collects, aggregates, processes, and exports information about running containers.

### [wg-easy](https://github.com/wg-easy/wg-easy)

wg-easy is a user-friendly WireGuard VPN server dashboard, making it easy to set up and manage a WireGuard VPN server with a simple web interface. It provides configuration options and statistics for WireGuard tunnels.

