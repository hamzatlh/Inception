NAME = inception

prepare:
	@mkdir -p /home/hamza/data/wordpress
	@mkdir -p /home/hamza/data/mariadb

all: prepare
	@printf "Launch configuration ${NAME}...\n"
	@docker-compose -p $(NAME) -f srcs/docker-compose.yml up --build -d

clean: down
	@printf "Cleaning configuration ${NAME}...\n"
	@docker-compose -p $(NAME) -f srcs/docker-compose.yml down
	@docker system prune -a
	@sudo rm -rf /home/hamza/data

fclean:
	@printf "Total clean of all configurations docker\n"
	@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); fi
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@docker volume rm $$(docker volume ls) --force 
	@sudo rm -rf /home/hamza/data --force

re: fclean all

.PHONY: all clean down re fclean
