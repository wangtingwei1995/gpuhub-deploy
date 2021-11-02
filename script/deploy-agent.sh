workspace=/root/gpushare-deploy
ansible-playbook -i $workspace/environments/$1/hosts $workspace/agent.yml
