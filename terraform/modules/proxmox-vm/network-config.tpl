version: 2

ethernets:
  lan:
    match:
      driver: virtio_net

    dhcp4: false
    dhcp6: false
    accept-ra: false
    link-local: []

    addresses:
      - ${ipv4_address}

    routes:
      - to: default
        via: ${ipv4_gateway}

    nameservers:
      addresses:
%{ for dns in dns_servers ~}
        - ${dns}
%{ endfor ~}
      search:
        - homelab.local