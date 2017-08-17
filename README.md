# h2o

A complete open source e-commerce solution by Go language.

## Install nvm

```
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | zsh
nvm install node
nvm alias default node
```

## Install gvm

```
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
gvm install go1.9rc2 -B
gvm use go1.9rc2 --default
```

## Development
```
go get -u github.com/beego/bee
go get -u github.com:kapmahc/h2o
cd $GOPATH/src/github.com/kapmahc/h2o
bee run # start backend at http://localhost:8080
cd dashboard
npm install # install packages
npm start # start frontent at http://localhost:3000
```

## Deployment
```
make clean
make
ls h2o.tar.bz2
```
