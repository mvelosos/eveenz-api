# Eveenz API

![eveenz logo](https://github.com/mvelosos/eveenz-api/blob/master/app/assets/images/home_logo.png?raw=true)

[eveenz.com](https://eveenz.com)

The Eveenz API provides all business rules and communication with the Eveenz Mobile APP. Follow the instructions to run the server

## Install

### Clone the repository

```shell
git clone https://github.com/mvelosos/eveenz-api.git
cd eveenz-api
```

### Check your Ruby version

```shell
ruby -v
```

The current ruby version used in this project is `ruby 2.7.2`

If do not have this version, install the right ruby version using [rvm](https://rvm.io/) (it could take a while):

```shell
rvm install 2.7.2
```

## Dependencies

### PostgreSQL
On MacOS, install (if you don't have it installed):
```shell
brew install postgresql
```
And start PostgreSQL service:
```shell
brew services start postgresql
```
### Redis
On MacOS, install (if you don't have it installed):
```shell
brew install redis
```
And start Redis service:
```shell
brew services start redis
```
### ElasticSearch
On MacOS, install (if you don't have it installed):
```shell
brew tap elastic/tap
brew install elastic/tap/elasticsearch-full
```

### ImageMagick
On MacOS, install(if you don't have it installed):
```shell
brew install imagemagick
```

### Gems
Lastly, using [Bundler](https://github.com/bundler/bundler), run the following command to install all gems used in this project

```shell
bundle
```
### Initialize the database

```shell
rails db:create db:migrate
```

### Populate Database
Some needed records should be created to follow the project business rules, run the following tasks to populate the database:
```shell
rails populate_database:populate_categories
```

## Serve
There is a shortcut command to execute all you need to run the server. In the project root run the following:
```shell
bash start.sh
```

## Test Suite
This project uses RSpec as main suite test framework. To run all the tests suites, go in the root folder and type:
```shell
rspec
```

glhf :)