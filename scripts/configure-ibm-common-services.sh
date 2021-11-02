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
    echo "Create ibm-operator-catalog-enforce cluster policy"
    oc  $ACTION -f acm-policies/00_namespace.yaml
    oc  $ACTION -f acm-policies/01_ibm_operator_catalog_must_exists.yaml
    echo "Deploy ibm-common-services"
    oc $ACTION  -f acm-configs/ibm_common_services_namespace.yaml
    oc $ACTION  -f acm-configs/cpd_instance_namespace.yaml
    oc $ACTION  -f acm-configs/ibm_common_services_application.yaml
    echo "Apply configuration for local-cluster (ACM Hub)"
    oc $ACTION -f acm-configs/ibm_common_services_placement_local_cluster.yaml
    oc $ACTION  -f acm-configs/ibm_common_services_subscription_local_cluster.yaml
elif [ $ACTION == "delete"  ];
then 
    echo "Clean ibm-common-services"
    oc $ACTION  -f acm-configs/ibm_common_services_subscription_local_cluster.yaml
    oc $ACTION -f acm-configs/ibm_common_services_placement_local_cluster.yaml
    oc $ACTION -f acm-configs/ibm_common_services_application.yaml
    oc $ACTION -f acm-configs/cpd_instance_namespace.yaml
    oc $ACTION CustomResourceDefinition $(oc get CustomResourceDefinition | grep ibm | awk '{print $1}') --wait=true --timeout=5s
    oc $ACTION -f acm-configs/ibm_common_services_namespace.yaml
    oc $ACTION -f acm-policies/01_ibm_operator_catalog_must_exists.yaml
    oc $ACTION -f acm-policies/00_namespace.yaml
else
  echo "required action not passed"
  exit 0
fi 


