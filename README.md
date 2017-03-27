# README

Application for controlling request flows in an organization.

### Ruby Version
Application requires `ruby` version `2.3.3p222`

### Rails Version
Built upon ruby framework namely, `Ruby On Rails` version `5.0.0`

### Gems
As a standard `rails` application `bundler` is used for management
of dependencies. To install dependencies:

```bash
$ bundle install
```
Above commands should be run from root directory of the application.

### Configure database
`MySQL` databases & connection to them is required for running the application.
Change the username and password as per your mysql user in the below given configuration:

```bash
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password:
  socket: /tmp/mysql.sock
```

#### Setup DB, apply migrations
```bash
$ rake db:setup # need to be done only once
$ rake db:migrate # to get any new schema changes
```

#### rake tasks to populate db tables
```bash
$ rake db:seed
```
