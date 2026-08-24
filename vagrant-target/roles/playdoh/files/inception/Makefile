CERTIF_DIR := ./srcs/certificate
MARIA_SSL_DIR := ./srcs/certificate/maria_ssl

all:	build up

up:
	sudo docker compose -f srcs/docker-compose.yml up -d

down:
	sudo docker compose -f srcs/docker-compose.yml down

build: certif
	mkdir -p $(HOME)/data/mariadb
	mkdir -p $(HOME)/data/wordpress
	sudo docker compose -f srcs/docker-compose.yml build

certif:
	$(CERTIF_DIR)/certif.sh

clean: 	down
	sudo docker system prune -af

fclean:	clean certclean
	sudo rm -rf $(HOME)/data/mariadb
	sudo rm -rf $(HOME)/data/wordpress

certclean:
	rm -f $(CERTIF_DIR)/cloud-ca-key.pem
	rm -f $(CERTIF_DIR)/cloud-ca.srl
	rm -f $(CERTIF_DIR)/maria.csr
	rm -rf $(MARIA_SSL_DIR)
	rm -rf ./srcs/requirements/mariadb/ssl/

reset:
	sudo rm -rf $(HOME)/data/mariadb
	sudo rm -rf $(HOME)/data/wordpress
	mkdir -p $(HOME)/data/mariadb
	mkdir -p $(HOME)/data/wordpress

re:	clean
	make all

.PHONY: all build  certclean certif up down run clean fclean re
