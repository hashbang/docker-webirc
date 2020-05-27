# docker-webirc

build kiwiirc static files and serve them from nginx

    docker build -t hashbang/webirc:local-latest .

test locally:

    docker run -p 8080:80 hashbang/webirc:local-latest

