# dReader

## Used versions

Ruby: 2.7.1

Rails: 6.0.3.2

## Installation

- Clone GIT repository
```bash
 git clone https://github.com/nikita-kikinovs/dreader.git
```
- Install PostgreSQL using HomeBrew
 ```bash
 brew install postgresql
```
- Switch to project directory
- Install the dependencies specified in Gemfile
 ```bash
 bundle install
```
- Run PostgreSQL server
 ```bash
 pg_ctl -D /usr/local/var/postgres start
```
- Create database
 ```bash
 rake db:create
```
- Run migrations
```bash
 rake db:migrate
```
- Seed data
```bash
 rake db:seed
```
- Update DELFI RSS Feed channel list
```bash
 rake channels:fetch
```
- Lauch app
```bash
 rails server -p <specify_port>
```
- Enjoy your feed reading :)
