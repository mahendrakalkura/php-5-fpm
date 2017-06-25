FROM ubuntu:17.04

RUN /usr/bin/apt-get update

RUN /usr/bin/apt-get --yes upgrade

RUN /usr/bin/apt-get --yes install language-pack-en-base software-properties-common

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN /usr/bin/add-apt-repository --yes ppa:ondrej/php

RUN /usr/bin/apt-get update

RUN /usr/bin/apt-get --yes upgrade

RUN /usr/bin/apt-get --yes install \
    binutils \
    build-essential \
    ca-certificates \
    curl \
    gettext \
    htop \
    libmysqlclient-dev \
    ncdu \
    nload \
    php5.6 \
    php5.6-bcmath \
    php5.6-bz2 \
    php5.6-cgi \
    php5.6-cli \
    php5.6-common \
    php5.6-curl \
    php5.6-dba \
    php5.6-dev \
    php5.6-enchant \
    php5.6-fpm \
    php5.6-gd \
    php5.6-gmp \
    php5.6-imap \
    php5.6-interbase \
    php5.6-intl \
    php5.6-json \
    php5.6-ldap \
    php5.6-mbstring \
    php5.6-mcrypt \
    php5.6-mysql \
    php5.6-odbc \
    php5.6-opcache \
    php5.6-pgsql \
    php5.6-phpdbg \
    php5.6-pspell \
    php5.6-readline \
    php5.6-recode \
    php5.6-soap \
    php5.6-sqlite3 \
    php5.6-sybase \
    php5.6-tidy \
    php5.6-xml \
    php5.6-xmlrpc \
    php5.6-xsl \
    php5.6-zip \
    tree \
    unzip

RUN /usr/sbin/phpenmod \
    bz2 \
    curl \
    dba \
    enchant \
    gd \
    gmp \
    imap \
    interbase \
    intl \
    json \
    ldap \
    mbstring \
    mcrypt \
    odbc \
    opcache \
    pdo_sqlite \
    pgsql \
    pspell \
    readline \
    recode \
    soap \
    sqlite3 \
    tidy \
    xml \
    xmlrpc \
    xsl \
    zip

RUN sed \
    -i \
    -e "s/^; max_input_vars =.*/max_input_vars = 10000/g" \
    -e "s/^;date.timezone =.*/date.timezone = UTC/g" \
    -e "s/^display_errors =.*/display_errors = On/g" \
    -e "s/^display_startup_errors =.*/display_startup_errors = On/g" \
    -e "s/^expose_php =.*/expose_php = On/g" \
    -e "s/^max_execution_time =.*/max_execution_time = 300/g" \
    -e "s/^max_file_uploads =.*/max_file_uploads = 100/g" \
    -e "s/^max_input_time =.*/max_input_time = 600/g" \
    -e "s/^max_input_time =.*/max_input_time = 600/g" \
    -e "s/^memory_limit =.*/memory_limit = 1024M/g" \
    -e "s/^memory_limit =.*/memory_limit = 1024M/g" \
    -e "s/^post_max_size =.*/post_max_size = 100M/g" \
    -e "s/^track_errors =.*/track_errors = On/g" \
    -e "s/^upload_max_filesize =.*/upload_max_filesize = 100M/g" \
    /etc/php/5.6/cgi/php.ini \
    /etc/php/5.6/cli/php.ini \
    /etc/php/5.6/fpm/php.ini \
    /etc/php/5.6/phpdbg/php.ini

RUN sed \
    -i \
    -e "s/listen = \/run\/php\/php5.6-fpm.sock/listen = [::]:9000/g" \
    /etc/php/5.6/fpm/pool.d/www.conf

RUN sed \
    -i \
    -e "s/pid = \/run\/php\/php5.6-fpm.pid/;pid = \/run\/php\/php5.6-fpm.pid/g" \
    -e "s/;daemonize = yes/daemonize = no/g" \
    /etc/php/5.6/fpm/php-fpm.conf

ENTRYPOINT ["/usr/sbin/php-fpm5.6", "--allow-to-run-as-root", "--force-stderr", "--fpm-config", "/etc/php/5.6/fpm/php-fpm.conf", "--nodaemonize"]
