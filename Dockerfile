# ubuntu server 16.04
FROM ubuntu:xenial
# signature
MAINTAINER blackist "liangl.Dong@gmail.com"

# update apt
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y software-properties-common

# Install ssh
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Install OpenJDK8
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment

# Install tools
RUN apt-get install -y vim wget

# Install tomcat 
RUN mkdir -p /opt/tomcat
RUN wget -P /opt/tomcat http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.23/bin/apache-tomcat-8.0.23.tar.gz
RUN cd /opt/tomcat && tar -xvzf apache-tomcat-8.0.23.tar.gz

# Install mysql
RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'"]
RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'"]
RUN apt-get -y install mysql-server
RUN /etc/init.d/mysql start 
# Define working directory.
VOLUME /data
ADD . /data
RUN service mysql start
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
    && echo 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
    && mv /tmp/my.cnf /etc/mysql/my.cnf

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV CATALINA_HOME /opt/tomcat/apache-tomcat-8.0.23
RUN export JAVA_HOME=$JAVA_HOME

# Config tomcat
# Deploy war web app


# open port 8080 for tomcat, 22 for ssh
EXPOSE 22
EXPOSE 3306
EXPOSE 8080

WORKDIR /data

# tomcat start, ssh
ENTRYPOINT /data/init.sh && $CATALINA_HOME/bin/startup.sh && /usr/sbin/sshd && /usr/bin/mysqld_safe
