[k3s_server]
%{ for vm in vms ~}
%{ if vm.role == "control" ~}
${vm.ip}
%{ endif ~}
%{ endfor ~}

[k3s_agent]
%{ for vm in vms ~}
%{ if vm.role == "worker" ~}
${vm.ip}
%{ endif ~}
%{ endfor ~}

[k3s_cluster:children]
k3s_server
k3s_agent

[all:vars]
ansible_user=${cloud_init_user}