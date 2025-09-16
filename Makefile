.PHONY: check

check: check_with_continue 

check_deps: check_ruby check_homebrew check_gem check_bundler check_rails check_postgres check_heroku install_message

install_message:
	@echo "Any missing dependencies (red ❌) can be installed with:";
	@echo "make install_development";

check_with_continue:
ifndef MAKE_K
	@$(MAKE) MAKE_K=1 check_deps
endif

check_ruby:
	@ruby_version=$$(ruby -v | awk '{print $$2}'); \
	major_version=$$(echo $$ruby_version | cut -d '.' -f1); \
	minor_version=$$(echo $$ruby_version | cut -d '.' -f2); \
	if [ "$$major_version" -lt 3 ] || ( [ "$$major_version" -eq 3 ] && [ "$$minor_version" -lt 0 ] ); then \
	  echo "❌ Ruby 3.0+"; \
	  exit 1; \
	fi
	@echo "✅ Ruby 3.0+"

check_gem:
	@if ! command -v gem &> /dev/null; then \
	  echo "❌ gem"; \
	  exit 1; \
	fi
	@echo "✅ gem"

check_bundler:
	@if ! command -v bundler &> /dev/null; then \
	  echo "❌ bundler"; \
	fi
	@echo "✅ bundler present"

check_rails:
	@rails_version=$$(rails -v | awk '{print $$2}'); \
	major_version=$$(echo $$rails_version | cut -d'.' -f1); \
	minor_version=$$(echo $$rails_version | cut -d'.' -f2); \
	if [ "$$major_version" -lt 7 ] || ( [ "$$major_version" -eq 7 ] && [ "$$minor_version" -lt 1 ] ); then \
	  echo "❌ Ruby 7.1+"; \
	fi
	@echo "✅ Rails 7.1+";

check_postgres:
	@if ! command postgres --version &> /dev/null; then \
		echo "❌ postgres"; \
	fi
	@echo "✅ postgres";

check_asdf:
	@if ! command -v asdf &> /dev/null; then \
	  echo "❌ asdf"; \
	fi
	@echo "✅ asdf";

check_homebrew:
	@if ! command -v brew &> /dev/null; then \
	  echo "❌ homebrew - Homebrew is required to continue. Please visit https://brew.sh to install homebrew"; \
		exit 1; \
	fi
	@echo "✅ homebrew";

check_heroku:
	@if ! command -v heroku &> /dev/null; then \
		echo "❌ heroku"; \
	fi
	@echo "✅ heroku";

install_asdf:
	@if ! command -v asdf &> /dev/null; then \
	 	echo "Installing asdf to manage Ruby versions"; \
		brew install asdf; \
	fi

install_ruby: check_asdf
	asdf plugin add ruby; \
	asdf install ruby 3.1.7;

install_bundle:
	@if ! command -v bundler &> /dev/null; then \
		echo "Installing bundler" \
		gem install bundler; \
	fi

install_rails:
	gem install rails -v 7.2.2.2

install_postgres:
	@if ! command postgres --version &> /dev/null; then \
		brew install postgres; \
	fi

install_heroku:
	@if ! command -v heroku &> /dev/null; then \
		brew install heroku/brew/heroku
	fi

# Installs are only performed if the command is missing, so they're safe to always call
install_development: check_homebrew install_asdf install_ruby install_bundle install_rails install_postgres