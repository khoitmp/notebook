### General
```sh
docker --help
docker info
docker login
```

### Action
```sh
docker -t <registry>/<image_name>:<tag> -f <docker_file> -f <development_file> build # Build and produce an image
docker tag <old_image_name>:<tag> <new_image_name>:<tag> # Tag an image
docker push <registry>/<image_name>:<tag> # Push an image
docker pull <registry>/<image_name>:<tag> # Pull an image
docker run -d -p <host_port>:<container_port> -v <destination_volume>:<source_volume> --network=<network_name> --name=<container_name> <image_name> # Run image as a container (-d: detach, -v: $(pwd) working directory)

docker ps -a # List all containers (-a: including stopped containers)
docker image ls
docker container ls
docker network ls
docker volume ls

docker inspect <image_name>
docker logs <container_id> # Display the logs of a container
docker rmi $(docker images -q) # Remove all images
docker container rm -f $(docker container ps -aq) # Remove all containers
docker rm $(docker ps -a -q) # Delete all stopped containers
docker kill $(docker ps -q) # Kill all running containers

docker stats # View comsumption
```

## Shell
```sh
# Connect to the standard input, output, and error streams of the main process inside the container. It is similar to connecting to a terminal session that is already running
docker attach <container_id>

# Create a new process inside the container and attache to it. The -it flag is used to allocate a pseudo-TTY and keep STDIN open, making it interactive (it: interactive tty, shell_type: sh|bash)
docker exec -it <container_id> <shell_type>

docker exec <container_id> <linux_command>
docker exec -i -t -u root /bin/bash <container_id> # Bash shell with root if container is running in a different user context
```

### Network
```sh
# - bridge: The container will have its own IP and isolated by the network
# - host: The container will have same IP with the host (use ports to communicate with docker services)
# - macvlan: The container will have its own MAC, and IP from the router (need to enable promiscuous mode)
# - ipvlan: The container will have its MAC same with the host, and IP from the router
# - overlay: A network that spanning across multiple docker nodes on different hosts (allows all containers in these nodes talk to each other)
docker network create --driver default|bridge|host|macvlan|ipvlan|overlay|none <network_name>
docker network rm <network_name>
docker network inspect <network_name>
docker network prune
docker network connect <network_name> <container_name>
```

### Compose
```sh
docker-compose --help
docker-compose build
docker-compose up
docker-compose ps
docker-compose stop <service_name>
docker-compose start <service_name>
docker-compose down
docker-compose push
docker-compose logs
docker-compose exec <service_name> <shell_type>
docker-compose up -d --scale <service_name>=<number_of_instances>
```

### Sample Dockerfile
```dockerfile
FROM        <sdk_image_name>
WORKDIR     <container_folder_path>
COPY        <source_path> <container_path>
RUN         <run_command>
EXPOSE      <container_port>
ENTRYPOINT  [ "dotnet run", "dll" ]
```

### Sample docker-compose.yml
```yml
version: <version>

services:
  <service_name>: # Means network addressable name
    container_name: <container_name> # No container_name defined when you want to scale the service
    image: <image>
    restart: <policy>
    build:
      context: . # Means current directory
      dockerfile: <docker_file>
    ports:
      - "<host_port>:<container_port>"
      # - "3000" # No external_port defined when you want to scale the service
    volumns: 
      - <destination_path>:<source_path>
    limits:
      cpus: '0.50'  # This container will be limited to 50% of a single CPU
      memory: 512M  # This container will be limited to 512MB of RAM
    networks:
      <network_name>
        ipv4_address: <ip>
    depends_on:
      - <service_name>

  <service_name>:
    container_name: <container_name>
    image: <image>
    networks:
      <network_name>
        ipv4_address: <ip>

networks:
  <network_name>:
    driver: <network_type>
      config:
        - subnet: "<ip>"
```