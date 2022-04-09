# Deploy

Deploy using `Docker Swarm` on the single host machine.

More about docker swarm: https://www.sumologic.com/glossary/docker-swarm/#:~:text=Docker%20swarm%20is%20a%20container,of%20availability%20offered%20for%20applications.

1. First, install docker on the server

```
https://github.com/docker/docker-install
```

2. Init the swarm leader node

```
docker swarm init
```

3. Check node list

```
docker node ls
```

4. Deploy the stack

```
docker stack deploy --compose-file docker-compose.prod.yml api
```

5. Check stack list

```
docker stack ls
```

6. Check service list of the stack

```
docker stack services api
```

7. Check task list of the service

docker service ps api_app
