
build: backend frontend
	mkdir -pv build/public
	tar -C build -zxvf h2o.tar.gz
	strip -s build/h2o
	cp -rv dashboard/build build/public/my
	cd build && tar jcvf ../h2o.tar.bz2 *

backend:
	bee pack -v -exs=Makefile:dashboard:node_modules:tmp:.go:.sh:.un~:.swp:.json

frontend:
	cd dashboard && npm run build

clean:
	-rm -rv h2o.tar.gz
	-rm -rv dashboard/build
	-rm -rv build h2o.tar.bz2
