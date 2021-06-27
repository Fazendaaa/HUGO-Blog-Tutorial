all: setup theme

setup:
	@docker run --rm -it --volume $(shell pwd):/website --workdir /website fazenda/hugo new site blog

theme:
	@sudo chown -R ${USER} blog
	@mv blog/* .
	@rm -r blog
	@touch .gitmodules
	@git submodule add https://github.com/your-identity/hugo-theme-dimension.git themes/dimension
	@echo "theme = \"dimension\"" | tee -a config.toml

new:
	@mkdir -p content/posts
	@docker run --rm -it --volume $(shell pwd):/website --workdir /website fazenda/hugo new posts/hell-world.md

server:
	@docker run --rm -it --volume $(shell pwd):/website --workdir /website --publish 80:80 fazenda/hugo server --bind 0.0.0.0 --port 80 -D
