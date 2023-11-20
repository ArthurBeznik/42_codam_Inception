SRCS_DIR		:=	srcs/
VAR_DIR			:=	var/
HTML_DIR		:=	$(VAR_DIR)html
DATA_DIR		:=	$(VAR_DIR)data
COMPOSE_FILE	:=	$(SRCS_DIR)docker-compose.yml
ENV_FILE		:=	$(SRCS_DIR).env

NGINX			:=	nginx
MARIADB			:=	mariadb
WORDPRESS		:=	wordpress

DB_VOLUME		:=	db
WP_VOLUME		:=	wp

start: $(HTML_DIR) $(DATA_DIR)
	docker-compose --env-file $(ENV_FILE) -f $(COMPOSE_FILE)  up --build

build: $(HTML_DIR) $(DATA_DIR)
	docker-compose -f $(COMPOSE_FILE) build 

stop:
	docker-compose -f $(COMPOSE_FILE) stop

remove:
	docker-compose -f $(COMPOSE_FILE) down

delete:
	@docker rm -f $(NGINX)
	@docker rm -f $(WORDPRESS)
	@docker rm -f $(MARIADB)

restart: stop start

host-file:
	@ echo "127.0.0.1 abeznik.42.fr" >> /etc/hosts

delete-volumes:
	docker volume rm $(DB_VOLUME)
	docker volume rm $(WP_VOLUME)

prune:
	docker system prune -a -f
	rm -rf $(DATA_DIR)
	rm -rf $(HTML_DIR)
	$(MAKE) delete-volumes

$(VAR_DIR):
	mkdir -p $(VAR_DIR)

$(HTML_DIR): $(VAR_DIR)
	mkdir -p $(HTML_DIR)

$(DATA_DIR): $(VAR_DIR)
	mkdir -p $(DATA_DIR)

re: stop prune start

tls:
	openssl s_client -connect localhost:443 -tls1_2
