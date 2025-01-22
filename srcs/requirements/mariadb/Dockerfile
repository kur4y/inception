# start from a debian image base
FROM debian:bullseye

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD
ARG MYSQL_DATABASE

# update and install packages
RUN apt-get update -y && \
    apt-get upgrade -y && \
	apt-get install -y mariadb-server && \
    apt-get install -y mariadb-client && \
    apt-get install -y procps && \
	rm -rf /var/lib/apt/lists/*

# start the MariaDB service, set root password, create database, user and grant access
RUN service mariadb start && \
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e \
    "CREATE DATABASE $MYSQL_DATABASE; \
    CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; \
    GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%'; \
    FLUSH PRIVILEGES;"

# copy the config file & script to the container
COPY ./conf/mariadb.conf /etc/mariadb/mariadb.conf
COPY ./tools/mariadb_script.sh ./

# give rights to exec script
RUN chmod +x ./mariadb_script.sh

# expose port 3306 for mariadb
EXPOSE 3306

# start the MariaDB server and bind its address to all available network interfaces (0.0.0.0)
CMD ["mysqld", "--bind-address=0.0.0.0"]
