# Simple Rails Runner
Basic Rails runner can (and should) run in the background I created at home for personal project. Enjoy!

## Table of Contents
* [Requirements](#requirements)
* [Install](#install)
* [How To Run](#how-to-run)
* [Arguments](#arguments)

## Requirements
* Rails (2.1 or above)
* Ruby (1.9 or above)

## Install
Just clone the git or download the file :)
```bash
$ git clone git@github.com:baradm100/simple-rails-runner.git
```

## How To Run
Just run using Rails runner
```bash
# as a daemon (only in bash)
$ bundle exec rails runner runner.rb &
# With args:
$ bundle exec rails runner runner.rb --eval "puts 'hi'" --timeout 0.1
```

## Arguments
| Key               | Explanation                                               |
| ----------------- | --------------------------------------------------------- |
| --timeout <VALUE> | Set custom timeout for the loop, defualt is 2 second      |
| --eval <VALUE>    | Running the value as code (using eval, please be careful) |
| --log <VALUE>     | Log file path (overwrite `puts`, `print` and `p`)         |
| -D                | Run the runner as a daemon (not compatible in windows)    |