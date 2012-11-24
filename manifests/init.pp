# Class: ruby
#
# Ensure Ruby is installed either by native packages or from source
#
# Parameters:
#
#   [*provider*]  : packages or source
#   [*version*]   : The ruby number version you want
#
# Requires:
#
#   [*epel*] : stahnma/epel
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
      $version  = 'latest'
) {

  Class['epel'] -> Class['ruby']

  include epel, ruby::params

  case $provider {
    'package' : {
      package {'ruby' :
        ensure => $version,
      }
    }
    'source' : {

      package {[$ruby::params::packages] :
        ensure  => latest,
      }

      $ruby_branch  = branch($version)
      $ruby_version = version($version)

      exec {"curl -L http://ftp.ruby-lang.org/pub/ruby/${ruby_branch}/ruby-${version}.tar.gz | tar -xzf - && cd ruby-${version} && ./configure && make && make install && rm -rf /root/ruby-${version}.tar.gz" :
        cwd       =>  '/root',
        user      =>  'root',
        path      =>  ['/usr/local/bin', '/bin', '/usr/bin'],
        timeout   =>  0,
        logoutput =>  on_failure,
        #
        # If what matters is the version number, use this unless condition
        #
        # ie. 1.9.3-p125 AND 1.9.3-p194 will both be true here
        #
        unless    =>  "[[ `ruby -v | cut -d\' \' -f2` = \'${ruby_version}\'* ]]",
        #
        # If what matter is the ruby release number, us this unless condition
        #
        # ie. 1.9.3-p125 AND 1.9.3-p194 will end up in false here
        #
        #unless   =>  "\"[[ `ruby -v | cut -d\' \' -f2` = \'${version}\' ]]\"",
        provider  =>  'shell',
        require   =>  Package[$ruby::params::packages],
      }
    }
    default : { fail("[ruby] The provider you selected ${provider} is not valid") }
  }
}
