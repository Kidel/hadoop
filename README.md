# Hadoop Docker
Docker image for Hadoop 2.8.0

## Instructions
For the first time just run this command inside the folder
```
docker-compose up -d
```
This will build and run the container.

You can stop it with 
```
docker-compose stop
```

And you can run it later with
```
docker-compose start
```

To access the container use Kitematic or run
```
docker exec -ti hadoop bash
```
You can also access to Hadoop's web monitor from [localhost:50070](http://localhost:50070)

## Test
Once inside the container run this command to see if everything works
```
yarn jar /home/shared/hadoop-mapreduce-examples-2.2.0.jar pi 1 10
```
Additionally you can run this command to later see the logs on [localhost:19888](http://localhost:19888)
```
./run_history_service.sh
```
(if it was not already running)