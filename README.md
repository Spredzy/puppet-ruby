puppet-ruby
===========

A Puppet module that ensure ruby is present, else it does install it

Ruby can be installed via your local packaging system or directly from the source code.

## Examples

### Via Package

```
include ruby
```
This example will install the latest version from your package manager

```
class {'ruby':
  version   =>  'ruby1.9.3',
}
```
This example will install the specified version from your package manager (osfamilly: Debian)

### Via Source
```
class {'ruby':
  provider  =>  'source',
  version   =>  '1.9.3-p134',
}
```
This example will install the specified release from source

## License

GPLv3
