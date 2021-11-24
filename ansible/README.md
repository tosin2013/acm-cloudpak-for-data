# Ansible Tower Deployment 

## Requirements
* ODF 
* ACM

### Deploy locally on laptop
**Deploy ACM configration without local-cluster placement**
```
ansible-playbook ansible/playbooks/main.yaml -t deploy  -vv
```

**Deploy cluster with local-cluster configuration**
```
 ansible-playbook ansible/playbooks/main.yaml -t deploy,local-cluster --skip-tags uninstall -vv
```

**uninstall entire deployment**
```
ansible-playbook ansible/playbooks/main.yaml -t uninstall -vv
```


### Deploy using Ansible Tower
[Configure Ansible tower on OpenShift](https://github.com/tosin2013/openshift-4-deployment-notes/blob/master/post-steps/configure-ansible-tower.md)


**download script**  
```
curl -OL https://raw.githubusercontent.com/tosin2013/openshift-4-deployment-notes/master/post-steps/configure-ansible-tower.sh
chmod +x configure-ansible-tower.sh
```

**run script**  
```
# ./configure-tower.sh 
./configure-tower.sh [OPTION]
 Options:
  -d      Openshift API URL
  -n      Openshift Username
  -p      Openshift Password
  -h      Display this help and exit
  -u      Uninstall tower 
  To deploy ansible tower to OpenShift
  ./configure-tower.sh  -d https://api.ocp4.example.com:6443 -n admin -p 123456789 
  To delete ansible tower from OpenShift
  ./configure-tower.sh  -d https://api.ocp4.example.com:6443 -n admin -p 123456789 -u true
```
