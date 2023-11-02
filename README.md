
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High Nginx Worker Load Incident
---

High Nginx Worker Load incident refers to the situation where the worker processes and connections on an Nginx server experience high load, which can cause a negative impact on the server's performance and response times. This can occur due to a wide range of factors, including high traffic volumes, poorly optimized configurations, or other factors that increase the demand on the server. As a result, it becomes necessary to resolve this issue by optimizing worker processes and connections to balance server load effectively and ensure the server can handle the load without any negative impacts on performance or response times.

### Parameters
```shell
export NGINX_PROCESS_ID="PLACEHOLDER"

export NUMBER_OF_WORKER_CONNECTIONS="PLACEHOLDER"

export PATH_TO_NGINX_CONF="PLACEHOLDER"

export URL="PLACEHOLDER"

export STATUS_PATH="PLACEHOLDER"
```

## Debug

### Check the current worker processes running
```shell
ps -ef | grep nginx | grep worker
```

### Check the current CPU and memory usage of the Nginx process
```shell
top -p ${NGINX_PROCESS_ID}
```

### Check the current Nginx configuration for thread support
```shell
nginx -V 2>&1 | grep --color -- --with-threads
```

### Check the current Nginx configuration for status module
```shell
nginx -V 2>&1 | grep --color -- --with-http_stub_status_module
```

### Check the Nginx status metrics
```shell
curl ${URL}/${STATUS_PATH}
```

## Repair

### Optimize worker connections to balance server load effectively.
```shell


#!/bin/bash



# Set the number of worker connections to optimize

worker_connections=${NUMBER_OF_WORKER_CONNECTIONS}



# Set the path to the Nginx configuration file

nginx_conf=${PATH_TO_NGINX_CONF}



# Backup the existing Nginx configuration file

cp $nginx_conf $nginx_conf.bak



# Update the Nginx configuration file with the new worker_connections value

sed -i "s/\(worker_connections\s*\)[0-9]\+;/\1$worker_connections;/" $nginx_conf



# Restart the Nginx service to apply the changes

service nginx restart



echo "Worker connections optimized successfully."


```