docker stop magic
docker rm magic
docker rmi magic
docker build -t magic .
docker run -d --name magic -p 80:80 -p 88:88 magic
