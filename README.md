
# Init project
$ docker run --rm -it -v $(pwd):/app hugomcm/php-apache-lumen-api composer create-project --prefer-dist laravel/lumen api


# Launch server
$ docker run --rm -it -p 8080:80 -v $(pwd):/app hugomcm/php-apache-lumen-api
