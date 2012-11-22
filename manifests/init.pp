# Class: ruby
#
# Ensure Ruby is installed either by native packages or from source
#
# Parameters:
#
#   [*provider*] : packages or source
#   [*version*] : The ruby number version you want
#
# Requires:
#
# Examples
#
#   class {'ruby' :
#   }
#
#   class {'ruby' :
#     provider => 'source',
#     version  => '1.9.3-p134',
#   }
#
#   class {'ruby' :
#     provider => 'package',
#     version  => '1.8.7',
#   }
#
class ruby (
      $provider = 'package',
      $version = 'latest') inherits ruby::params {

  case $provider {
    'package' : {
      package {'ruby' :
        ensure => $version,
      }
    }
    'source' : {

      class {'epel' :
      }

      package {[$ruby::params::packages] :
        ensure  => latest,
        require => Class['epel'],
      }

      $ruby_branch = branch($version)
      $ruby_version = version($version)

      exec {"curl -L http://ftp.ruby-lang.org/pub/ruby/${ruby_branch}/ruby-${version}.tar.gz | tar -xzf - && cd ruby-${version} && ./configure && make && make install" :
        cwd       => '/root',
        user      => 'root',
        path      => ['/usr/bin', '/usr/local/bin', '/bin'],
        timeout   => 0,
        logoutput => on_failure,
        #
        # A single version of ruby can have variants ie. 1.9.3-p194 1.9.3-rc-1
        # If all you want is the same version regarding the variant just add a start after ${ruby_version}\' which would become ${ruby_version}\'*
        # If what you want is to have the exact variant specified then don't change anything
        #
        unless    => 'test `ruby -v | cut -d\' \' -f2` == "1.9.3p194"',
        #unless   => "[[ `ruby -v | cut -d\' \' -f2` = \'${ruby_version}\'* ]]",
        #unless   => "\"[[ `ruby -v | cut -d\' \' -f2` = \'${version}\' ]]\"",
        #provider => 'shell',
        require   => Package[$ruby::params::packages],
      }
    }
    default : { fail("[ruby] The provider you selected ${provider} is not valid") }
  }
}
