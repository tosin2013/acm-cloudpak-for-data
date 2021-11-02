# ACM Configs Cloud Pack for Data

## Requirements 
**Confirm target clusters are properly labeled**
> the local-cluster does not need to be checked
*  `clusterid=cluster1`
*  `clusterid=cluster2`
*  `clusterid=cluster3`
*  `clusterid=...`
> The instructions must be followed in order for proper deployment. 




## Manual Cluster deployment 
**Clone acm-cloudpak-for-data repo**
```
git clone https://github.com/tosin2013/acm-cloudpak-for-data.git
```

**Login to ACM HUB cluster**
```
oc login --token=sha256~XXXXX--server=https://api.ocp4.example.com:6443
```

**Create namespace for ibm-common-services**
```
oc create -f acm-configs/ibm_common_services_namespace.yaml
```

**Create namespace for cpd-instance**
```
oc create -f acm-configs/cpd_instance_namespace.yaml
```

**Create Channel for ibm-common-services  channel**
```
oc create -f acm-configs/ibm_common_services_channel.yaml 
```

**Create Application for ibm-common-services application**
```
oc create -f acm-configs/ibm_common_services_application.yaml
```

### Apply configuration for local-cluster (ACM Hub)
**Create Placement rule for  cpd-operator Operator**
```
oc create -f acm-configs/ibm_common_services_placement_local_cluster.yaml
```

**Deploy cpd-operator Subscription for local-cluster**
```
oc create -f acm-configs/ibm_common_services_subscription_local_cluster.yaml
```

**Check Deployment status**
```
oc get csv -n ibm-common-services cpd-platform-operator.v2.0.4 \
-o jsonpath='{ .status.phase } : { .status.message} {"\n"}'
```

**Run the following command to confirm that the operator is ready:**
```
oc get deployments -n ibm-common-services -l olm.owner="cpd-platform-operator.v2.0.4" \
-o jsonpath="{.items[0].status.availableReplicas} {'\n'}"
```

**Configure cpd-instance**
**Create Channel for cpd-instance channel**
```
oc create -f acm-configs/cpd_instance_channel.yaml
```

**Create Application for cpd-instance application**
```
oc create -f acm-configs/cpd_instance_application.yaml
```


### Apply cluster1 configuration
**Create Placement rule for  cpd-operator Operator**
```
oc create -f acm-configs/ibm_common_services_placement_cluster1.yaml
```

**Deploy cpd-operator Subscription for cluster**
```
oc create -f acm-configs/ibm_common_services_subscription_cluster1.yaml
```