FROM centos:6.8
MAINTAINER Sebi Nievas <sebi.nievas@gmail.com>

RUN yum update -y && yum install -y \
	wget \
	gcc \
	pcre*x86_64

RUN mkdir /apache2
WORKDIR /apache2

RUN wget http://download.nextag.com/apache//httpd/httpd-2.4.23.tar.gz && tar -zxf httpd-2.4.23.tar.gz
RUN wget http://supergsego.com/apache//apr/apr-1.5.2.tar.gz && tar -zxf apr-1.5.2.tar.gz
RUN wget http://supergsego.com/apache//apr/apr-util-1.5.4.tar.gz && tar -zxf apr-util-1.5.4.tar.gz
RUN chown -R root:root /apache2
RUN mv apr-1.5.2 httpd-2.4.23/srclib/apr
RUN mv apr-util-1.5.4 httpd-2.4.23/srclib/apr-util
RUN cd /apache2/httpd-2.4.23 && ./configure --with-included-apr && make && make install

# cleanup
WORKDIR /
RUN rm -rf /apache2

COPY entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
