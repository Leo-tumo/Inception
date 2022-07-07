include srcs/.env 

NAME		=	inception

COMPOSE		=	cd srcs && docker-compose -p $(NAME)

RM			=	rm -rf

SUDO		=	sudo

MKDIR	=	$(SUDO) mkdir -m 777 -p

CHMOD		=	$(SUDO) chmod -R 777

CHOWN		=	$(SUDO) chown -R leo

all: fclean	up

up:
	$(MKDIR) $(WP_HOST_VOLUME_PATH)
	$(MKDIR) $(MARIADB_HOST_VOLUME_PATH)
	$(CHOWN) $(DATA_VOLUME_PATH)
	$(CHMOD) $(DATA_VOLUME_PATH)
	$(SUDO) docker network create inception_network
	$(COMPOSE) up -d --build

clean:
	@if docker network rm inception_network; then echo "No network to remove"; fi
	$(COMPOSE) stop

fclean:	clean
	$(COMPOSE) down -v

re:		prune all

prune:	fclean
	docker system prune --volumes --force --all
	@if $(SUDO) $(RM) $(DATA_VOLUME_PATH); then echo "No data folder to remove"; fi

.PHONY: all build up clean fclean re prune
