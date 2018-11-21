# Objetivo
Este módulo tem por objetivo o reaproveitamento do código e a padronização no provisionamento de instâncias no Openstack.

## Requisitos
Foram considerados os seguintes itens para a construção de instâncias:
<pre>
1. Count.
2. Hostname.
3. DNS.
4. Network.
5. Key_pair.
6. Flavor.
7. Fixed_ip_v4.
8. Secgroup_id.
9. Template.
10. Availability_zone.
</pre>
  
### Observações: 
<pre> 1. Fixed_ip_v4: esse parâmetro caso não mencionado será considerado endereço por DHCP 
na interface da instância.
2. Template: esse parâmetro é reservado para utilização do Puppet.
  2.1. Env: Ambiente que será associada instância ao Foreman, por exemplo: TST, TIT, HOM e PRD.
  2.2. Puppet_server: Hostname do servidor puppet master.
  2.3. Puppet_ip: Endereço IP do servidor puppet master.
</pre>

## Exemplos:
### Definição de uma instância

<pre>
<b>module "frontend-instance"</b> {
  source            = "terraform-openstack-modules/instance/openstack"
  version           = "0.0.4"
  count             = "1"
  availability_zone = ["zone-236-decimo"]
  hostname          = "frontend-srv"
  dns               = "localdomain"
  network           = "privatenetwork"
  key_pair          = "host-key"
  flavor            = "small-1"
  fixed_ip_v4       = ["192.168.0.10"]
  secgroup_id       = <b>["${module.frontend-sg.id}"]</b>
  env               = "hom"
  puppet_server     = "puppet-master.localdomain"
  puppet_ip         = "172.16.15.30"
}
</pre>

### Definição de uma váriavel para organização das regras de security group.
<pre>
<b>variable "frontend-rules-sg"</b> {
    default = [
      {
        port_range_min   = 22
        port_range_max   = 22
        protocol         = "tcp"
        ethertype        = "IPv4"
        direction        = "ingress"
        remote_ip_prefix = "0.0.0.0/0"
      },
      {
        port_range_min   = 0
        port_range_max   = 0
        protocol         = "icmp"
        ethertype        = "IPv4"
        direction        = "ingress"
        remote_ip_prefix = "0.0.0.0/0"
      }
   ]
}
</pre>

### Definição de um security group
<pre>
<b>module "frontend-sg"</b> {
  source      = "terraform-openstack-modules/securitygroup/openstack"
  version     = "0.0.2"
  name        = "Instance - secgroup"
  description = "Instance security group project"
  rules       = <b>"${var.frontend-rules-sg}"</b>
}
</pre>
