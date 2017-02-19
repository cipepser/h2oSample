FROM centos:latest

RUN yum install -y git

RUN yum groupinstall -y "Development Tools"
RUN yum install -y cmake libyaml-devel zlib zlib-devel openssl-devel libssl-#devel libuv wslay gcc bison

# RUN cd /etc
RUN git clone https://github.com/h2o/h2o.git
RUN cd /h2o													&& \
	 git submodule update --init --recursive		&& \
	 cmake .													&& \
	 cmake -DWITH_BUNDLED_SSL=on .					&& \
	 make														&& \
	 make install


RUN yum install -y openssl

RUN mkdir ssl
RUN cd ssl														&& \
	 openssl genrsa 2048 > server.key
RUN cd ssl														&& \
	 openssl req -new -key server.key > server.crt		\
	 -subj "/C=JP"  \
#	 -keyout /ssl/a.key \
#	 -out /ssl/server.crt
#	 mv -f ./server.crt ../examples/h2o