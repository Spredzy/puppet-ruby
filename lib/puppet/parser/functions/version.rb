# Functions: version
#
#   Returns the official version number on the inputed version
#
# Example:
#
#   1.8.7 => 1.8.7
#   1.9.3-p134 => 1.9.3
#
module Puppet::Parser::Functions
  newfunction(:version, :type => :rvalue) do |args|
    args[0][/[0-9]+.{1}[0-9]+.{1}[0-9]+/]
  end
end
