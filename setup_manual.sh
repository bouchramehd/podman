
podman network create db_network
podman network create site_network

podman volume create db_volume


podman build -t mysql ./myt commencer par FROM alpine)
podman build -t app ./app

podman run -d \
  --name mysql_container \
  --network db_network \
  --network-alias mysql \
  -v db_volume:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=test_db \
  -e MYSQL_USER=test_user \
  -e MYSQL_PASSWORD=test_pass \
  -p 5655:5655 \
  mysql

podman run -d \
  --name app_container \
  --network db_network \
  --network-alias app \
  --network site_network \
  -e DB_HOST=mysql \
  -e DB_NAME=test_db \
  -e DB_USER=test_user \
  -e DB_PASSWORD=test_pass \
  -p 4743:4743 \
  app

podman run -d \
  --name nginx_container \
  --network site_network \
  -v ./nginx/conf/nginx.conf:/etc/nginx/conf.d/default.conf:ro \
  -p 5423:824 \
  nginx
