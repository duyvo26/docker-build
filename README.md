# docker-build



# Docker
### Bluid Docker
`docker build -t api_duyvo26 .`

### Chạy Docker Container
`docker run -d --restart always --name api_duyvo26 -p 8000:8000 api_duyvo26`

### Lưu Docker Image thành tệp tar
`docker save -o api_duyvo26_backup.tar api_duyvo26`

### Truy cập vào docker
`docker exec -it api_duyvo26 bash`

---

# Cập nhật danh sách các gói và cài đặt các gói cần thiết
RUN apt-get update && \
    apt-get install -y python3 python3-pip git nano htop curl wget unzip && \
    apt-get clean
