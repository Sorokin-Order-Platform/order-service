# путь к файлу с переменными
ENV_FILE := ./app-template.env
# подгружаем файл как Make-переменные
include $(ENV_FILE)
# экспортируем все подключенные переменные
export

IMAGE_NAME=order-platform/$(APPLICATION_NAME):dev
CONTAINER_NAME=platform-container-$(APPLICATION_NAME)

app-build:
	cd .. && ./mvnw clean package -DskipTests
	docker build -t $(IMAGE_NAME) ../.

app-(re)run: app-stop
	envsubst < $(ENV_FILE) > ./app-resolved.env
	docker run -d --name $(CONTAINER_NAME) \
    -p $(SERVER_PORT):$(SERVER_PORT) \
    --env-file ./app-resolved.env \
    $(IMAGE_NAME)

app-stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

app-logs:
	docker logs $(CONTAINER_NAME) --tail 100

requirements_run:
	docker-compose -f ./docker-compose.requirements.yml up -d

requirements_stop:
	docker-compose -f ./docker-compose.requirements.yml stop

app-build-run: app-build app-(re)run

app-with-requirements-start: requirements_run app-build-run

stop-all: app-stop requirements_stop