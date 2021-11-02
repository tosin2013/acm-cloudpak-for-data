# Configure pull secret for cloudpak for data

## Steps for adding IBM Entitled Registry
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