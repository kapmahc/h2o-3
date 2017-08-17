
build: backend frontend
	tar -C build jxvf h2o.tar.gz
	strip -s build/h2o
	mkdir -pv build/public
	cp -rv dashboard/build build/public/my
	tar jcvf h2o.tar.bz2 build

backend:
	bee pack -v -exs=Makefile:dashboard:node_modules:tmp:.go:.sh:.un~:.swp:.json

frontend:
	cd dashboard && npm run build

clean:
	rm -rv build h2o.tar.bz2
	rm -rv h2o.tar.gz
	rm -rv dashboard/build
