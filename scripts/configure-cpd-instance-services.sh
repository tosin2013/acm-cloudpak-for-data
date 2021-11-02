#!/bin/bash 
set -x 


if [ -z $1 ];
then
  echo "Please pass action"
  echo "Usage: $0 create|delete"
  exit 1
fi

ACTION=$1

if [ $ACTION == "create" ];
then 
    echo "Deploy cpd-instance"
    oc $ACTION  -f acm-configs/cpd_instance_namespace.yaml
    oc $ACTION -f acm-configs/cpd_instance_channel.yaml
    oc $ACTION  -f acm-configs/cpd_instance_application.yaml
    echo "Apply configuration for local-cluster (ACM Hub)"
    oc $ACTION -f acm-configs/cpd_instance_placement_local_cluster.yaml
    oc $ACTION  -f acm-configs/cpd_instance_subscription_local_cluster.yaml
elif [ $ACTION == "delete"  ];
then 
    echo "Clean cpd-instance"
    oc $ACTION  -f acm-configs/cpd_instance_subscription_local_cluster.yaml
    oc $ACTION -f acm-configs/cpd_instance_placement_local_cluster.yaml
    oc $ACTION -f acm-configs/cpd_instance_application.yaml
    oc $ACTION -f acm-configs/cpd_instance_channel.yaml
    oc $ACTION -f acm-configs/cpd_instance_namespace.yaml
else
  echo "required action not passed"
  exit 0
fi 


