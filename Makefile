all		:
			mkdir -p /home/tyron/data/mariadb
			mkdir -p /home/tyron/data/wordpress
			docker compose -f ./srcs/docker-compose.yml build
			docker compose -f ./srcs/docker-compose.yml up -d

down	:
			docker compose -f ./srcs/docker-compose.yml down

logs	:
			docker logs wordpress
			docker logs mariadb -u root -p
			docker logs nginx

check	:
			docker ps
			docker volume ls
			docker images

clean	:
			docker container stop wordpress mariadb nginx
			docker network rm inception

fclean	:	clean
			@sudo rm -rf /home/tyron/data/mariadb/*
			@sudo rm -rf /home/tyron/data/wordpress/*
			@docker system prune -af

re		:	fclean all

.PHONY	:	all logs clean fclean
