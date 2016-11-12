# ms

[![Linux Build][travis-image]][travis-url]


Library to easily convert various time formats to milliseconds and
milliseconds to human readable format.


## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  ms:
    github: SuperPaintman/ms
```


--------------------------------------------------------------------------------

## Usage

```crystal
require "ms"

# === Numbers to strings ===
two_ms = MS.ms(200)
# => 200ms

five_sec = MS.ms(5000)
# => 5s

six_hours = MS.ms(60 * 60 * 1000 * 6)
# => "6h"
```


--------------------------------------------------------------------------------

## Test

```sh
crystal spec
```


--------------------------------------------------------------------------------

## Contributing

1. Fork it ( https://github.com/SuperPaintman/ms/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request


--------------------------------------------------------------------------------

## Contributors

- [SuperPaintman](https://github.com/SuperPaintman) SuperPaintman - creator, maintainer


--------------------------------------------------------------------------------

## License

[MIT][license-url]


[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/SuperPaintman/ms/master.svg?label=linux
[travis-url]: https://travis-ci.org/SuperPaintman/ms

