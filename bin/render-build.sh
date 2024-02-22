#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
yarn add tailwindcss-animate@1.0.6
bundle exec rails yarn:install
bundle exec rails tailwindcss:build
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:setup
bundle exec rails db:create
bundle exec rails db:migrate
