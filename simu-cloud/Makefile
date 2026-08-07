NAME = scaleway-simu
PORT = 2222

all: prepare build run

# Génère une clé SSH dédiée si tu n'en as pas dans le dossier
prepare:
	@if [ ! -f ed25519 ]; then \
		ssh-keygen -t ed25519 -b 4096 -f ed25519 -N ""; \
	fi

build:
	docker build -t $(NAME) .

run:
	docker run -d \
		--name $(NAME) \
		-p $(PORT):22 \
		--privileged \
		$(NAME)
	@echo "--- Container prêt ! ---"
	@echo "Test la connexion avec : ssh -i ed25519 -p $(PORT) deploy@localhost"

stop:
	docker stop $(NAME) || true
	docker rm $(NAME) || true

clean: stop
	docker rmi $(NAME) || true
	rm -f ed25519 ed25519.pub

re: clean all

.PHONY: all prepare build run stop clean re