FROM php:7.3-fpm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt update
RUN apt autoremove -y
RUN apt install zip unzip git -y

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN npm update -g npm
RUN npm install -g npm-check-updates

RUN apt install hub -y

RUN git config --global user.email "umihico@users.noreply.github.com"
RUN git config --global user.name "umihico"
WORKDIR /root
COPY *.sh /root/
CMD ["sh", "updater.sh"]
