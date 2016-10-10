FROM jupyter/scipy-notebook:latest

USER root

RUN apt-get update && \
   apt-get -y install wget && \
   apt-get -y install python build-essential && \
   wget -q http://nodejs.org/dist/v4.2.6/node-v4.2.6-linux-x64.tar.gz && \
   tar xzf node-v4.2.6* && cd node-v4.2.6* && \
   mv bin/* /usr/local/bin/ && \
   mv lib/* /usr/local/lib/ && \
   mv include/* /usr/local/include/ && \
   cd .. && rm -rf node-v4.2.6* && \
   apt-get install -y nginx && \
   rm -rf /var/lib/apt/lists/* && \
   chown -R www-data:www-data /var/lib/nginx

RUN rm -v /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /app

# launchbot-specific labels
LABEL name.launchbot.io="Object Oriented Python"
LABEL workdir.launchbot.io="/app"
LABEL description.launchbot.io="Object-oriented Python."
LABEL 8888.port.launchbot.io="Jupyter Notebook"
LABEL 8000.port.launchbot.io="Oriole"

COPY . /app

# Expose the notebook port
EXPOSE 80
EXPOSE 88

# Install and run the startup script
ADD run.sh /app/run.sh
RUN chmod +x /app/run.sh
CMD ["/app/run.sh"]
