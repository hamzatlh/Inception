name = Inception

all:
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/script.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/script.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: down
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a
	@sudo rm -rf ./srcs/volumes/wordpress/*
	@sudo rm -rf ./srcs/volumes/mariadb/*

fclean:
	@printf "Total clean of all configurations docker\n"
	@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ./srcs/volumes/wordpress/*
	@sudo rm -rf ./srcs/volumes/mariadb/*

.PHONY: all build down re clean fclean
