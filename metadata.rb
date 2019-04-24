name 'update_wrapper'
maintainer 'Steve Brown'
maintainer_email 'sbrown@chef.io'
license 'Apache-2.0'
description 'Installs/Configures update_wrapper'
long_description 'Installs/Configures update_wrapper'
version '0.1.0'
chef_version '>= 13.0'
depends 'chef_client_updater'
depends 'chef-client'
%w( centos windows ).each do |os|
  supports os
end
issues_url 'https://github.com/devoptimist/update_wrapper/issues'
source_url 'https://github.com/devoptimist/update_wrapper'
