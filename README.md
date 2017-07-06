H2O - A complete open source e-commerce solution by Go language.
---


## Prepare server (Ubuntu)

* create deploy user(by root)
```bash
apt-get install zsh
useradd -s /bin/zsh -m deploy
passwd -l deploy
EDITOR=vim visudo # add line: deploy ALL=(ALL) NOPASSWD: ALL 
```

* setup ssh keys (by deploy) 
```
mkdir ~/.ssh
chmod 700 ~/.ssh
cat /tmp/id ~/.ssh/authorized_keys
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

* install packages
```bash
sudo apt-get install build-essential libssl-dev libreadline-dev zlib1g-dev
sudo apt-get install nginx redis-server postgresql postgresql-contrib libpq-dev imagemagick
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn
sudo apt-get install pwgen sdcv
```

* Install rbenv
```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
cd ~/.rbenv && src/configure && make -C src && cd -
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
```

* Install ruby
```bash
rbenv install 2.4.1
rbenv global 2.4.1
gem install bundler
```

* Install Minio
```bash
cd ~/bin
wget https://dl.minio.io/server/minio/release/linux-amd64/minio
wget https://dl.minio.io/client/mc/release/linux-amd64/mc
chmod +x minio mc
mkdir -p /var/www/s3
minio server /var/www/s3 
```

## Database

* Create database
```bash
psql -U postgres
CREATE DATABASE db-name WITH ENCODING = 'UTF8';
CREATE USER user-name WITH PASSWORD 'change-me';
GRANT ALL PRIVILEGES ON DATABASE db-name TO user-name;
```


## Deployment 
```bash
git clone https://github.com/kapmahc/h2o.git
cd h2o
vi config/deploy/production.rb
bundle exec cap production puma:config
bundle exec cap production puma:nginx_config
bundle exec cap production deploy
bundle exec cap production sitemap:refresh 
```

## Notes
```bash
rails g controller Home index --no-helper --no-assets --no-test-framework
rails g model User --no-test-framework
```

## Issues

- 'Peer authentication failed for user', open file "/etc/postgresql/9.5/main/pg_hba.conf" change line:

  ```
  local   all             all                                     peer  
  TO:
  local   all             all                                     md5
  ```

- Generate openssl certs

  ```bash
  openssl genrsa -out www.change-me.com.key 2048
  openssl req -new -x509 -key www.change-me.com.key -out www.change-me.com.crt -days 3650 # Common Name:*.change-me.com
  ```
  
- [For gmail smtp](http://stackoverflow.com/questions/20337040/gmail-smtp-debug-error-please-log-in-via-your-web-browser)