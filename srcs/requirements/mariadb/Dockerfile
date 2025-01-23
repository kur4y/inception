# start from a debian image base
FROM debian:bullseye

# update and install packages
RUN apt-get update -y && \
    apt-get upgrade -y && \
	apt-get install -y mariadb-server && \
    apt-get install -y mariadb-client && \
    apt-get install -y procps && \
	rm -rf /var/lib/apt/lists/*

# copy the config file & script to the container
COPY ./conf/mariadb.conf /etc/mariadb/mariadb.conf
COPY ./tools/mariadb_script.sh ./

# give rights to exec script
RUN chmod +x ./mariadb_script.sh

# copy the config file & script to the container
COPY ./conf/mariadb.conf /etc/mariadb/mariadb.conf
COPY ./tools/mariadb_script.sh ./

# give rights to exec script
RUN chmod +x ./mariadb_script.sh

# expose port 3306 for mariadb
EXPOSE 3306

# exec my mariadb script
ENTRYPOINT ["sh", "./mariadb_scriptscript.sh"]