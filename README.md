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
* [Configure pull secret for cloudpak for data](configure-pullsecret.md)


## Quick Deploy 

**Deploy IBM Services**
```
scripts/configure-ibm-common-services.sh
```

**Deploy cpd isntance**
``` 
scripts/configure-cpd-instance-services.sh
```

## Deploy with Ansible 
[Ansible Tower Deployment](ansible/README.md)