#!/bin/bash
workspace=/root/gpuhub-deploy
ansible-playbook -i $workspace/environments/$1/hosts $workspace/replace-configmap.yml
ansible-playbook -i $workspace/environments/$1/hosts $workspace/replace-makefile.yml
