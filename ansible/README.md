# Ansible Tower Deployment 

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
