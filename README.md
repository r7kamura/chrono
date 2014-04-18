# Chrono [![Build Status](https://travis-ci.org/r7kamura/chrono.png)](https://travis-ci.org/r7kamura/chrono) [![Code Climate](https://codeclimate.com/github/r7kamura/chrono.png)](https://codeclimate.com/github/r7kamura/chrono) [![Coverage Status](https://coveralls.io/repos/r7kamura/chrono/badge.png?branch=master)](https://coveralls.io/r/r7kamura/chrono)

Provides a chain of logics about chronology.

## Chrono::Iterator
Parse cron syntax and determine next scheduled run.

```ruby
require "chrono"

iterator = Chrono::Iterator.new("30 * * * *")
iterator.next #=> 2000-01-01 00:30:00
iterator.next #=> 2000-01-02 00:30:00
iterator.next #=> 2000-01-03 00:30:00
```

The following syntax is supported.
See [examples](https://github.com/r7kamura/chrono/blob/master/spec/chrono/iterator_spec.rb)
for more details.

* (*) Asterisk
* (,) Comma
* (-) Hyphen
* (/) Slash

```
* * * * *
T T T T T
| | | | `- wday --- 0 ..  6
| | | `--- month -- 1 .. 12
| | `----- day ---- 1 .. 31
| `------- hour --- 0 .. 23
`--------- minute - 0 .. 59
```
