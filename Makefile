build:
	mkdir -p localstorage
	-sudo mount -o bind /localstorage localstorage/
	for container in beam scaler; do \
		-ln -s /localstorage $$container; \
		mkdir -p $$container/assets ; \
		sed "s=XAUTHKEY=$$(xauth list | head -n 1)=" $$container/templates/entrypoint.sh > $$container/assets/entrypoint.sh ; \
	done
	sudo docker compose build --no-cache
run: build
	sudo docker compose up