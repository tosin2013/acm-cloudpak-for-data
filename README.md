# acm-cloudpak-for-data

## Requirements
* ODF 
* ACM
* IBM Entitlement key


## Getting started 

**Clone acm-cloudpak-for-data repo**
```
git clone https://github.com/tosin2013/acm-cloudpak-for-data.git
```

**Login to ACM HUB cluster**
```
oc login --token=sha256~XXXXX--server=https://api.ocp4.example.com:6443
```

**Configure pull secret for cloudpak for data**
[Configure pull secret for cloudpak for data](configure-pullsecret.md)

**Configure ACM polices for cloud pack for data**
```
oc  create -f acm-policies/00_namespace.yaml
```

**Deploy ibm-operator-catalog operator**
> This policy will apply to all clusters with the vendor=OpenShift label to change this update lines 68 and 71.
```
oc  create -f acm-policies/01_ibm_operator_catalog_must_exists.yaml
```