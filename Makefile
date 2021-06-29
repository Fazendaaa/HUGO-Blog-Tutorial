all: setup theme

setup:
	@docker run --rm -it --volume $(shell pwd):/website --workdir /website fazenda/hugo new site blog

theme:
	@sudo chown -R ${USER} blog
	@mv blog/* .
	@rm -r blog
	@touch .gitmodules
	@git submodule add https://github.com/victoriadrake/hugo-theme-introduction.git themes/introduction
	@echo "theme = \"introduction\"" | tee -a config.toml

new:
	@mkdir -p home/
	@docker run --rm -it --volume $(shell pwd):/website --workdir /website fazenda/hugo new home/index.md
	@docker run --rm -it --volume $(shell pwd):/website --workdir /website fazenda/hugo new home/contact.md
	@docker run --rm -it --volume $(shell pwd):/website --workdir /website fazenda/hugo new projects/_index.md
	@docker run --rm -it --volume $(shell pwd):/website --workdir /website fazenda/hugo new blog/_index.md
	@sudo chown -R ${USER} home/ projects/ blog/

server:
	@docker run --rm -it --volume $(shell pwd):/website --workdir /website --publish 80:80 fazenda/hugo server --bind 0.0.0.0 --port 80 -D
