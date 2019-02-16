#cloud-config
bootcmd:
  - rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
  - yum -y install puppet-agent
  - /opt/puppetlabs/bin/puppet agent --enable

runcmd:
  - echo -e "[main]\nserver = ${puppet_server}\n[agent]\ncertname = ${hostname}\nenvironment = ${env}\n" >> /etc/puppetlabs/puppet/puppet.conf
  - echo "127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
  - echo "::1 localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
  - echo "${puppet_ip} ${puppet_server}" >> /etc/hosts
  - echo "$(/opt/puppetlabs/bin/facter networking.ip) $(/opt/puppetlabs/bin/facter hostname) $(/opt/puppetlabs/bin/facter fqdn)" >> /etc/hosts
  - /opt/puppetlabs/bin/puppet agent -t --server ${puppet_server} --environment ${env}
  - /bin/systemctl start puppet
