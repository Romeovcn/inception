all: 
	mkdir -p /home/rvincent/data/mariadb
	mkdir -p /home/rvincent/data/wordpress
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up -d

logs:
	docker logs wordpress
	docker logs mariadb
#	docker logs nginx

clean:
#	docker container stop nginx
	docker container stop mariadb
	docker container stop wordpress
	docker network rm inception

fclean: clean
	@sudo rm -rf /home/rvincent/data/mariadb/*
	@sudo rm -rf /home/rvincent/data/wordpress/*
	@docker system prune -af

re: fclean all

.Phony: all logs clean fclean
