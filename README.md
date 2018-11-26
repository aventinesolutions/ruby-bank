# Ruby Bank Coding Challenge
version 1.0.0

## Requires
PostgreSQL

## Ruby Setup
```shell
$ rvm install 2.5.3
$ rvm use 2.5.3@ruby-bank --create
$ gem install bundler foreman
$ bundle install
```


## PostgreSQL Setup
As `postgres` super user:
```shell
$ createdb ruby-bank_development
$ createdb ruby-bank_test
```

## Database Schema
```shell
$ rake db:migrate db:test:prepare
```

## Run Tests
```shell
$ rspec
```

## Run Servers
```shell
$ foreman start
```

## Try Me!

[http://localhost:5000](http://localhost:5000)
