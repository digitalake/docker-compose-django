# <h1 align="center">Implementing Docker-compose</a>

### Intro

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application's services. Then, with a single command, you create and start all the services from your configuration.

Compose works in all environments; production, staging, development, testing, as well as CI workflows. It also has commands for managing the whole lifecycle of your application:

- Start, stop, and rebuild services
- View the status of running services
- Stream the log output of running services
- Run a one-off command on a service

Using Compose is essentially a three-step process:

- Define your app's environment with a `Dockerfile` so it can be reproduced anywhere.
- Define the services that make up your app in a `docker-compose.yml` file so they can be run together in an isolated environment.
- Run `docker compose up` and the Docker compose command starts and runs your entire app.

Key features of Docker Compose:

- Have multiple isolated environments on a single host
- Preserves volume data when containers are created
- Only recreate containers that have changed
- Supports variables and moving a composition between environments

### Task definition

Docker-compose is a common approach for local development. In my case I already have a dockerized demo-application so I needed to prepare a `docker-compose.yml` file and make it easy (let's say easy for an avarage developer) to use the Dokcer-compose feature locally by simply running `git clone` and `docker-compose up -d`. Additionally need to create some explanations and instructions about using this repository.

### Requirements with links

[Docker and Docker Compose installed](https://docs.docker.com/engine/install/)

[Git installed](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Quick start

Start with opening your terminal and clonning the repositry with `git clone`:

```
git clone https://github.com/digitalake/docker-compose-django.git
```

Change directory to the one was just cloned:

```
cd docker-compose-django
```

Look at the .env.example and make changes or leave unchanged

Launch the service stack defined in the `docker-compose.yml` in detached mode (with `-d` flag) specifying a `.env` file to use:

```
docker-compose --env-file .env.example up  -d
```

> [!NOTE]
> Docker may take some time to pull and build the images when running `docker-compose up -d` for the first time

You can also copy the `.env.example` content to another file (lets say new envfile is called `.env.new`), make some changes and run another service stack in parallel:

> [!NOTE]
> Make sure that values for `COMPOSE_PROJECT_NAME`, `APP_PORTS` and `PGADMIN_LOCAL_PORT` are unique for each `.env` is used

```
docker-compose --env-file .env.new up  -d
```

Navigate to your browser and check Application adress (port numbers used are the default values from `.env.example`, change if using another values):

```
http://127.0.0.1:80
```

Also check PGadmin adress, login and connect to the Postgres DB with the values from `.env.example`:

```
http://127.0.0.1:5050
```

Make changes to the application code in `app/` directory and apply those changes to the service stack:

```
docker-compose --env-file .env.example  up --build -d
```

Destroy all the containers if finished working:

```
docker-compose --env-file .env.example down
```

You also may want to remove docker volumes with mounted data, to do so use such command:

```
docker-compose --env-file .env.example  down -v
```

Other commands and tips are described [here](https://docs.docker.com/engine/reference/commandline/compose/)

### .env variables

| Variable Name          | Default Value       | Description                                      |
| ---------------------- | ------------------- | ------------------------------------------------ |
| COMPOSE_PROJECT_NAME   | example             | Common project name for Docker Compose which is also used as a prefix for the resource names          |
| APP_PORTS              | 80:8000             | Local port mapping for the application          |
| APP_SERVICE_IMAGE      | django-alpinebased:1.4 | Docker image for the Django application      |
| DJANGO_ALLOWED_HOSTS   | *                   | Allowed hosts for the Django application        |
| DEBUG                  | true                | Debug mode for the Django application            |
| DB_SERVICE_IMAGE       | postgres:12         | Docker image for the PostgreSQL database         |
| POSTGRES_DB            | exampledb           | PostgreSQL database name                         |
| POSTGRES_USER          | exampleuser         | PostgreSQL database user                         |
| POSTGRES_PASSWORD      | examplepassword     | PostgreSQL database password                     |
| PGADMIN_LOCAL_PORT     | 5050                | Local port mapping for PgAdmin                   |
| PGADMIN_SERVICE_IMAGE_VERSION | 7.7         | Docker image version for PgAdmin                 |
| PGADMIN_DEFAULT_EMAIL  | example@example.com | Default email for PgAdmin login                  |
| PGADMIN_DEFAULT_PASSWORD | exaplepassword    | Default password for PgAdmin login               |




