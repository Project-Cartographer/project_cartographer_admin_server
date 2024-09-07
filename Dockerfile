FROM centos:7

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum update clean all
RUN yum -y install java-1.8.0-openjdk-devel.x86_64

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk

WORKDIR /home/cartographer

COPY . .

RUN chmod +x mvnw
RUN ./mvnw package -Dmaven.test.skip=true

ENTRYPOINT ["java", "-jar", "-Dspring.config.location=/home/cartographer/latest.properties", "/home/cartographer/target/project_cartographer_admin.jar"]
