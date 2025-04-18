FROM mysql

COPY init.sql /docker-entrypoint-initdb.d/

ENV MYSQL_ROOT_PASSWORD=password
ENV MYSQL_DATABASE=test_db

EXPOSE 3306
