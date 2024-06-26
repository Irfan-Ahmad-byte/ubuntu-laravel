# Ubuntu Laravel

## Description
Ubuntu Laravel is a versatile application built using Ubuntu 20.04, PHP 8.1, and Composer. This application is designed to streamline your development process by providing a pre-configured environment with necessary dependencies for Laravel development.

## Features
- PHP 8.1: Latest PHP version with essential extensions for web development.
- Composer: Dependency management tool for PHP, allowing easy installation of Laravel.
- MySQL Client: For connecting to a MySQL database.
- Git Integration: Configured with user credentials for seamless repository management.

## Usage
`docker-compose up -d`

`docker exec -it ubuntu-laravel bash`

`mysql -h mysql_container -u myuser -p`

## Getting Started
Clone this repository from Docker Hub.
Build and run the Docker containers using Docker Compose.
Access the application and start developing with Laravel.

### Running
The image depends on MySQL instance running and connected to the same network.
The image can be run using a compose.yml file like so:
```

services:
  app:
    build: .
    container_name: ubuntu-laravel
    networks:
      - my_network
    depends_on:
      - db
    environment:
      - GIT_USERNAME=
      - GIT_EMAIL=
      - GITHUB_TOKEN=

  db:
    image: mysql:5.7
    container_name: mysql_container
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: mydatabase
      MYSQL_USER: myuser
      MYSQL_PASSWORD: mypassword
    networks:
      - my_network

networks:
  my_network:
    driver: bridge
```

On the other hand it can also be run through docker cli as follows:

First make sure that the MySQL instance is running

```
docker run -d \
    --name mysql_container \
    --network my_network \
    -e MYSQL_ROOT_PASSWORD=rootpassword \
    -e MYSQL_DATABASE=mydatabase \
    -e MYSQL_USER=myuser \
    -e MYSQL_PASSWORD=mypassword \
    mysql:8.0
```

Then the laravel instance can be run with this command

```
docker run -d \
    --name UL_container \
    --network my_network \
    -e GIT_USERNAME=your_git_username \
    -e GIT_EMAIL=your_git_email \
    -e GITHUB_TOKEN=your_github_token \
    ubuntu-laravel
```


License
This project is licensed under the MIT License. See the LICENSE file for more details.

## Contact
For any questions or issues, please contact irfan.ahmad.mlka@gmail.com.