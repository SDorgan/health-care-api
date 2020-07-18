[![build status](https://gitlab.com/fiuba-memo2/tp2/altojardin-api/badges/master/pipeline.svg)](https://gitlab.com/fiuba-memo2/tp2/altojardin-api/commits/master)

## Heroku

- [Staging](https://altojardin-health-api-staging.herokuapp.com/)
- [Production](https://altojardin-health-api-prod.herokuapp.com/)

# Bots

- [Staging](https://web.telegram.org/#/im?p=@altojardin_staging_bot)
- [Production](https://web.telegram.org/#/im?p=@altojardin_bot)

## Workflow

1. We create _feature-branch_ and _merge-request_ from _issue_ (this one has its _target_ branch pointing to **develop** _branch_)
2. Complete and validate the _issue_, merging the _feature-branch_ into **staging** _branch_ (this triggers the deploy to _Heroku_ staging environment)
3. Close the _issue_ by merging it into _branch_ **develop**.
4. Merge _branch_ **develop** into **master** when iteration its complete (this triggers the deploy to _Heroku_ production environment)

## PostgreSQL setup

Follow these steps to initialize the PostgreSQL databases:

1. Install PostgreSQL if needed. On Ubuntu you can do this by running:
`sudo apt-get install -y postgresql-9.5 postgresql-contrib postgresql-server-dev-9.5`
1. Create development and test databases by running:
`sudo -u postgres psql --dbname=postgres -f ./create_dev_and_test_dbs.sql`

## Padrino application setup

1. Run **_bundle install --without staging production_**, to install all application dependencies
1. Run **_bundle exec rake_**, to run all tests and ensure everything is properly setup
1. Run **_RACK_ENV=development bundle exec rake db:migrate db:seed_**, to setup the development database
1. Run **_bundle exec padrino start -h 0.0.0.0_**, to start the application

## Some conventions to work on it:

* Follow existing coding conventions
* Use feature branch
* Add descriptive commits messages in English to every commit
* Write code and comments in English
* Use REST routes
=======
Health API - Alto Jardin
========================

[![build status](https://gitlab.com/fiuba-memo2/tp2/altojardin-api/badges/master/pipeline.svg)](https://gitlab.com/fiuba-memo2/tp2/altojardin-api/commits/master)

## Workflow

1. We create _feature-branch_ and _merge-request_ from _issue_ (this one has its _target_ branch pointing to **develop** _branch_)
2. Complete and validate the _issue_, merging the _feature-branch_ into **staging** _branch_ (this triggers the deploy to _Heroku_ staging environment)
3. Close the _issue_ by merging it into _branch_ **develop**.
4. Merge _branch_ **develop** into **master** when iteration its complete (this triggers the deploy to _Heroku_ production environment)

## PostgreSQL setup

Follow these steps to initialize the PostgreSQL databases:

1. Install PostgreSQL if needed. On Ubuntu you can do this by running:
`sudo apt-get install -y postgresql-9.5 postgresql-contrib postgresql-server-dev-9.5`
1. Create development and test databases by running:
`sudo -u postgres psql --dbname=postgres -f ./create_dev_and_test_dbs.sql`

## Padrino application setup

1. Run **_bundle install --without staging production_**, to install all application dependencies
1. Run **_bundle exec rake_**, to run all tests and ensure everything is properly setup
1. Run **_RACK_ENV=development bundle exec rake db:migrate db:seed_**, to setup the development database
1. Run **_bundle exec padrino start -h 0.0.0.0_**, to start the application

## Some conventions to work on it:

* Follow existing coding conventions
* Use feature branch
* Add descriptive commits messages in English to every commit
* Write code and comments in English
* Use REST routes
