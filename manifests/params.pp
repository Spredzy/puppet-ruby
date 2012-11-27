# Class: ruby::params
#
#   This class manages the Ruby installation parameters
#
# Parameters:
#
#   [*packages*] : Ruby dependencies packages, needed when doing an installation from source
#
# Actions:
#
# Requires:
#
# Samples Usage:
#
class ruby::params() {

  case $::osfamily {
    'RedHat': {
      $packages = ['make', 'gcc', 'gcc-c++', 'openssl-devel', 'libicu-devel', 'libyaml-devel', 'zlib-devel', 'readline-devel']
    }
    'Debian': {
      $packages = ['make', 'gcc', 'g++', 'libssl-dev', 'curl', 'libicu-dev', 'libyaml-dev', 'zlib1g-dev', 'libreadline-dev']
    }
    default: {
      fail("Unsupported OS : $::osfamily - Get in touch with the Module maintainer to see how we can fix that")
    }
  }

}
