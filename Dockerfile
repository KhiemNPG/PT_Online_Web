# GIAI ĐOẠN 1: Dùng Maven để tự động đóng gói code sang file .war
FROM maven:3.8.1-openjdk-17-slim AS builder
WORKDIR /deployServletProject
COPY . .
RUN mvn clean package -DskipTests

# GIAI ĐOẠN 2: Cài Tomcat 10.1 và khởi chạy ứng dụng web
FROM tomcat:10.1-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*

# Đẩy file PT_Online.war vừa build ở trên vào làm trang chủ của server Tomcat
COPY --from=builder /deployServletProject/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
