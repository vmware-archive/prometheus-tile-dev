## Prometheus Tile (Dev)

A [Prometheus](https://prometheus.io/) tile for use with Pivotal Ops Manager.
This tile is based on the open-source [prometheus bosh release](https://github.com/bosh-prometheus/prometheus-boshrelease).

Note: This tile is not intended for production environments as it contains intentional limitations like disabled alerts and no high availability.
Our intended use case is to run a single-VM prometheus to monitor our CI environments to better debug CI failures.

## What does this tile deploy?

A single VM containing Prometheus to aggregate metrics and Grafana to graph them.
A large number of dashboards for BOSH, Cloud Foundry, and Prometheus itself come pre-installed.

## Dependencies

Requires ERT 1.11 or later in order to leverage the `healthwatch_firehose` UAA client.
This is required as OpsMgr does not allow tiles to add their own CF UAA clients.

## How do I use it?

View graphs:
- Visit https://grafana.sys.YOUR_CF_DOMAIN
- Click Dashboard menu in top-left to view different metrics graphs.

View raw metrics:
- Visit https://prometheus.sys.YOUR_CF_DOMAIN
- Enter `admin` as the username and the password from OpsMgr > Prometheus Tile > Credentials > prometheus_admin_credentials
