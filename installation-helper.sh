
export CLUSTER_NAME = "cubes"

# Base URL

export BASE_URL = r2svz.dynamic.opentlc.com
# IP for OpenShift API : api.<clustername>.example.com

export API_IP = 192.168.81.1
export API_URL = api.$(CLUSTER_NAME).$(BASE_URL)


# IP for OpenShift Application ROUTER : apps.<clustername>.example.com

export ROUTER_URL = apps.$(CLUSTER_NAME).$(BASE_URL)
export ROUTER_IP = 192.168.81.2

#IPs for Master VMs

export MASTER1_IP = 192.168.81.11
export MASTER2_IP = 192.168.81.12
export MASTER3_IP = 192.168.81.13

#IPs for WORKER VMs

export WORKER1_IP = 192.168.81.21
export WORKER2_IP = 192.168.81.22
export WORKER3_IP = 192.168.81.23