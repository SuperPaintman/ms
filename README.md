# ms

[![Linux Build][travis-image]][travis-url]
[![Shards version][shards-image]][shards-url]


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

# == Strings to numbers ===
ms_in_5h = MS.ms("5h")
# => 18000000

ms_in_20sec = MS.ms("20 sec")
# => 20000

ms_in_an_hour_and_a_half = MS.ms("1.5 hours")
# => 5400000

ms_in_day = MS.ms("day")
# => 86400000

ms_in_2_years = MS.ms("2y")
# => 63115200000


# === Numbers to strings ===
two_ms = MS.ms(200)
# => "200ms"

five_sec = MS.ms(5000)
# => "5s"

six_hours = MS.ms(60 * 60 * 1000 * 6)
# => "6h"


# === Numbers to long strings ===
two_long_ms = MS.ms(200, long: true)
# => "200 ms"

five_long_sec = MS.ms(1000, long: true)
# => "1 second"

six_long_hours = MS.ms(60 * 60 * 1000 * 6, long: true)
# => "6 hours"
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

## Changelog
[Changelog][changelog-url]


--------------------------------------------------------------------------------

## License

[MIT][license-url]


[license-url]: LICENSE
[changelog-url]: CHANGELOG.md
[travis-image]: https://img.shields.io/travis/SuperPaintman/ms/master.svg?label=linux
[travis-url]: https://travis-ci.org/SuperPaintman/ms
[shards-image]: https://img.shields.io/github/tag/superpaintman/ms.svg?label=shards
[shards-url]: https://github.com/superpaintman/ms

