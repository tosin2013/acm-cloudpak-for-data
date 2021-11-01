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

**Create entitlement key**
```
ENTITLEMENT_KEY=$(echo -n "cp:entitlement-key" | base64 -w0)
```

**Add usernamne and password for cp.icr.io**

```
USERINFO=$(echo -n "username:password" | base64 -w0)
```

Create json file
> If you are pulling images from the IBM Entitled Registry, the value is cp.icr.io.
If you are pulling images from a private container registry, specify the location of the private container registry. For example, private-registry.example.com.

```
cat >cloudpack-registry.json<<EOF
{
   "auths":{
        "registry-location":{
         "auth":"${ENTITLEMENT_KEY}",
         "email":"not-used"
      },
        "cp.icr.io":{
         "auth":"${USERINFO}",
         "email":"not-used"
      }
   }
}
EOF
```

**Pull the pull-secret.json from cluster**
```
oc get secrets pull-secret -n openshift-config -o template='{{index .data ".dockerconfigjson"}}' | base64 -d > pull-secret.json
```

**Merge pull-secret.json with cloudpack-registry.json**
```
jq -c --argjson var "$(jq .auths cloudpack-registry.json)" '.auths += $var' pull-secret.json > merged_pullsecret.json
```

**Update cluster pull secret**
```
oc set data secret/pull-secret -n openshift-config --from-file=.dockerconfigjson=merged_pullsecret.json
```

**Validate Changes**
```
oc get secrets pull-secret -n openshift-config -o template='{{index .data ".dockerconfigjson"}}' | base64 -d
```

