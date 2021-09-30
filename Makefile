DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
EXCLUSIONS := .DS_Store .git .gitignore .gitkeep .gitmodules
DOTFILES   := $(sort $(filter-out $(EXCLUSIONS), $(wildcard .??*) bin))

.DEFAULT_GOAL := help

all:

list: ## List dotfiles in this repository.
	@$(foreach dotfile, $(DOTFILES), ls -dF $(dotfile);)

update: ## Update this repository.
	@echo 'Updating...'
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
	@tput setaf 2 && echo 'Done' && tput sgr0

deploy: ## Deploy dotfiles by creating symbolic links at home.
	@tput setaf 3 && echo 'Existing dotfiles will be removed.' && tput sgr0
	@printf 'Do you want to continue? [y/N] ' && read response && case "$$response" in [yY]|[yY]es) true;; *) false;; esac
	@echo 'Deploying...'
	@$(foreach dotfile, $(DOTFILES), ln -sfnv $(abspath $(dotfile)) $(HOME)/$(dotfile);)
	@tput setaf 2 && echo 'Done' && tput sgr0

install-deps: ## Install dependencies.
	@echo 'Installing dependencies...'
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/res/install/install.sh
	@tput setaf 2 && echo 'Done' && tput sgr0

install: update deploy install-deps ## Install. (Run "update", "deploy", and "install-deps".)
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
		| awk 'BEGIN {FS = ":.*?## "}; {printf "%-14s%s\n", $$1, $$2}'
