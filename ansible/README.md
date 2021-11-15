# Ansible Tower Deployment 

## Deploy locally on laptop
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


## Deploy using Ansible Tower
* [OpenShift Deployment and Configuration](https://docs.ansible.com/ansible-tower/3.7.1/html/administration/openshift_configuration.html)

**Download Ansible tower Binaries for OpenShift Deployment**
```
curl -OL ansible-tower-openshift-setup-latest.tar.gz
```

