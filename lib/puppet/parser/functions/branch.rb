# Functions: branch
#
#   Returns the stable branch on the inputed version
#
# Example:
#
#   1.8.7 => 1.8
#   1.9.3-p134 => 1.9
#
module Puppet::Parser::Functions
  newfunction(:branch, :type => :rvalue) do |args|
    args[0][/[0-9]+.{1}[0-9]+/]
  end
end
