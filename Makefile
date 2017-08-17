

backend:
	bee pack -v -exs=dashboard:node_modules:tmp:.go:.sh:.un~:.swp:Makefile

frontend:
	cd dashboard && npm run build
