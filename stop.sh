docker stop $(docker ps -qa)
sleep 20
docker rm $(docker ps -qa) -f
sleep 5
yes Y | docker volume prune
yes Y | docker system prune
yes Y | docker network prune
