H2O - A complete open source e-commerce solution by Go language.
---

## Install rbenv

```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/rbenv/rbenv-vars.git $(rbenv root)/plugins/rbenv-vars
cd ~/.rbenv && src/configure && make -C src && cd -
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
```

## Install ruby

```bash
rbenv install 2.4.1
gem install bundler
```

## Deployment instructions

```bash
git clone https://github.com/kapmahc/h2o.git
cd h2o
cap production deploy
```

## Notes
```bash
rails g controller Home index --no-helper --no-assets --no-test-framework
rails g model User --no-test-framework
```