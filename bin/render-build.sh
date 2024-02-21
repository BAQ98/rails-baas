#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle lock --add-platform x86_64-linux
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails tailwindcss:build
bundle exec rails tailwindcss:install
./node_modules/.bin/tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css
bundle exec rails db:migrate
