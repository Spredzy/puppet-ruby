# Class: ruby::params
#
#   This class manages the Ruby installation parameters
#
# Parameters:
#
#   [*packages*] : Ruby dependencies packages, needed when doing an installation from source 
#   [*ruby_version_long*] : Ruby full version (default)
#
# Actions:
#
# Requires:
#
# Samples Usage:
#
class ruby::params() {

  $packages = ['make', 'gcc', 'gcc-c++', 'openssl-devel', 'libicu-devel', 'libyaml-devel', 'zlib-devel', 'readline-devel']

  $ruby_version_long = '1.9.3-p194'

}
