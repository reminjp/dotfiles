DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
EXCLUSIONS := .DS_Store .git .gitignore .gitkeep .gitmodules
DOTFILES   := $(sort $(filter-out $(EXCLUSIONS), $(wildcard .??*) bin))

.DEFAULT_GOAL := help

all:

list: ## Display dotfiles in this repository.
	@$(foreach dotfile, $(DOTFILES), ls -dF $(dotfile);)

update: ## Update this repository.
	@echo 'Updating...'
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
	@tput setaf 2 && echo 'Done' && tput sgr0

deploy: ## Create symbolic links at home.
	@echo 'Existing dotfiles will be removed.'
	@echo -n 'Do you want to continue? [y/N] ' && read response && case "$$response" in [yY]|[yY]es) true;; *) false;; esac
	@echo 'Deploying...'
	@$(foreach dotfile, $(DOTFILES), ln -sfnv $(abspath $(dotfile)) $(HOME)/$(dotfile);)
	@tput setaf 2 && echo 'Done' && tput sgr0

init: ## Setup deployed environment settings.
	@echo 'Initializing...'
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/res/init/init.sh
	@tput setaf 2 && echo 'Done' && tput sgr0

install: update deploy init ## Run make update, deploy, init.
	@exec $$SHELL

test: ## Test dotfiles and scripts.
	@echo 'Testing...'
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/res/test/test.sh
	@tput setaf 2 && echo 'Done' && tput sgr0

clean: ## Remove dotfiles and this repository.
	@echo 'All dotfiles in your home directory and this repository will be removed.'
	@echo -n 'Do you want to continue? [y/N] ' && read response && case "$$response" in [yY]|[yY]es) true;; *) false;; esac
	@echo 'Cleaning...'
	-@$(foreach dotfile, $(DOTFILES), rm -vrf $(HOME)/$(dotfile);)
	-rm -rf $(DOTPATH)
	@tput setaf 2 && echo 'Done' && tput sgr0

help: ## Display this information.
	@echo 'Usage: make [command]'
	@echo 'Commands:'
	@grep -E '^[A-Za-z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "%-10s%s\n", $$1, $$2}'
