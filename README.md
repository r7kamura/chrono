# Chrono [![Build Status](https://travis-ci.org/r7kamura/chrono.png)](https://travis-ci.org/r7kamura/chrono) [![Code Climate](https://codeclimate.com/github/r7kamura/chrono.png)](https://codeclimate.com/github/r7kamura/chrono) [![Code Climate](https://codeclimate.com/github/r7kamura/chrono/coverage.png)](https://codeclimate.com/github/r7kamura/chrono)

Provides a chain of logics about chronology.

## Trigger
Waits till scheduled time and then triggers a given job. `#run` is a periodic version of `#once`.

```ruby
trigger = Chrono::Trigger.new("30 * * * *") { Time.now }
trigger.once #=> 2000-01-01 00:30:00
trigger.run  #=> 2000-01-01 01:30:00
             #=> 2000-01-01 02:30:00
             #=> 2000-01-01 03:30:00
             #=> ...
```

## Iterator
Parses cron syntax and determines next scheduled run.

```ruby
iterator = Chrono::Iterator.new("30 * * * *")
iterator.next #=> 2000-01-01 00:30:00
iterator.next #=> 2000-01-01 01:30:00
iterator.next #=> 2000-01-01 02:30:00
```

## Syntax
The following syntax is supported.
See the [examples](https://github.com/r7kamura/chrono/blob/master/spec/chrono/iterator_spec.rb)
for more details.

* (*) Asterisk
* (,) Comma
* (-) Hyphen
* (/) Slash

```
* * * * *
T T T T T
| | | | `- wday --- 0 ..  6 (0 = Sunday)
| | | `--- month -- 1 .. 12
| | `----- day ---- 1 .. 31
| `------- hour --- 0 .. 23
`--------- minute - 0 .. 59
```
