APP := website
RUN := docker-compose run --rm web
spec := spec

setup:
	docker-compose build
	make bundle
	make reset

bundle:
	$(RUN) bundle install

up:
	docker-compose up

build:
	docker-compose up --build

down:
	docker-compose down

serve_debug:
	docker-compose up -d
	docker attach $(APP)

bash:
	$(RUN) bash

console:
	$(RUN) bundle exec rails c

rspec:
	$(RUN) bundle exec rspec $(spec)

routes:
	$(RUN) bundle exec rails routes

rubocop:
	$(RUN) bundle exec rubocop

guard:
	$(RUN) bundle exec guard

create:
	$(RUN) bundle exec rails db:create

migrate:
	$(RUN) bundle exec rails db:migrate

seed:
	$(RUN) bundle exec rails db:seed

drop:
	$(RUN) bundle exec rails db:drop

reset:
	$(RUN) bundle exec rails db:reset db:migrate db:seed

credentials:
	$(RUN) EDITOR=vim rails credentials>edit

run:
	$(RUN) bundle exec $(c)

push:
	git add .
	git commit -m $(c)
	git push
