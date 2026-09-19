FROM tomcat:11-jdk17-temurin-jammy

RUN rm -rf /usr/local/tomcat/webapps/*

COPY dist/EjemploCrudJSP.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
