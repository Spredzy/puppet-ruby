puppet-ruby
===========

A Puppet module that ensure ruby is present, else it does install it

Ruby can be installed via your local packaging system or directly from the source code.

## Examples

### Via Package

```
class {'ruby':
  provider  =>  'package',
  version   =>  '1.8.7',
}
```

### Via Source
```
class {'ruby':
  provider  =>  'source',
  version   =>  '1.9.3-p134',
}
```

## License

GPLv3
