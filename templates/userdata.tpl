#cloud-config
bootcmd:
  - echo ${puppet_ip} ${puppet_server} >> /etc/hosts
  - rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
  - yum -y install puppet-agent
  - /opt/puppetlabs/bin/puppet agent --enable

runcmd:
  - echo -e "[main]\nserver = ${puppet_server}\n" >> /etc/puppetlabs/puppet/puppet.conf
  - echo -e "[agent]\ncertname = ${hostname}\nenvironment = tst\n" >> /etc/puppetlabs/puppet/puppet.conf
  - /opt/puppetlabs/bin/puppet agent -t --server ${puppet_server} --environment ${env}
  - /bin/systemctl start puppet
