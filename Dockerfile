FROM centos:7
LABEL maintainer="Jagerzhang"

WORKDIR /opt

ENV TEST_NGINX_BINARY=/usr/local/openresty/bin/openresty

RUN yum -y install yum-utils && \
    yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo

RUN yum install -y openresty curl git gcc openresty-openssl111-devel unzip pcre pcre-devel sudo make wget which

RUN wget -O etcd-v3.4.13-linux-amd64.tar.gz https://github.com/etcd-io/etcd/releases/download/v3.4.13/etcd-v3.4.13-linux-amd64.tar.gz && \
    tar -xvf etcd-v3.4.13-linux-amd64.tar.gz && \
    cd etcd-v3.4.13-linux-amd64 && \
    cp -a etcd etcdctl /usr/bin/ && \
    rm -rf /opt/etcd-*

RUN curl https://raw.githubusercontent.com/apache/apisix/master/utils/linux-install-luarocks.sh -sL | bash -

RUN yum install -y cpanminus cpanm && \
    cpanm --notest Test::Nginx IPC::Run && \
    rm -rf v3.4.0.tar.gz

RUN git clone https://github.com/iresty/test-nginx.git

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/bin/bash"]
