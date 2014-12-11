update:
	npm prune && npm install && bower update

solve-npm-issues:
	rm -Rf node_modules && \
	npm cache clear --verbose && \
	npm install --verbose && \
	npm dedupe --verbose

local-testing:
	gnome-terminal \
		--tab -t "Webistor APP builder" -e "brunch watch"
