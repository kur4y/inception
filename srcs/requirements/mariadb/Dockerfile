# start from a debian image base
FROM debian:bullseye

# update and install packages
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y mariadb-server && \
	apt-get install -y mariadb-client && \
	apt-get install -y procps

# copy the config file & script to the container
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/mariadb_script.sh ./

# create mariadb dir. & give it permissions
RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld/
RUN chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/

# give rights to exec script
RUN chmod +x ./mariadb_script.sh

# exec my mariadb script
ENTRYPOINT ["bash", "./mariadb_script.sh"]

# expose port 3306 for mariadb
EXPOSE 3306
