all:
		mkdir -p /home/tyron/data/mariadb
		mkdir -p /home/tyron/data/wordpress
		docker compose -f ./srcs/docker-compose.yml up --build -d

down:
		docker compose -f ./srcs/docker-compose.yml down

logs:
		docker logs wordpress
		docker logs mariadb
		docker logs nginx

check:
		docker ps
		docker volume ls
		docker images

clean:
		docker stop wordpress mariadb nginx
		docker rm wordpress mariadb nginx

fclean: clean
		docker rmi wordpress mariadb nginx
		@sudo rm -rf /home/tyron/data/mariadb /home/tyron/data/wordpress
		@docker system prune -af

re:		fclean all
