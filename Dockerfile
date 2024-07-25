# Sử dụng image chính thức của Ubuntu 22.04
# Giai đoạn build
FROM ubuntu:22.04 AS builder

# Thiết lập biến môi trường để tránh các thông báo trong quá trình cài đặt
ENV DEBIAN_FRONTEND=noninteractive

# Cập nhật danh sách các gói và cài đặt các gói cần thiết
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    apt-get install -y git

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Sao chép file yêu cầu vào container
COPY ./requirements.txt /app/requirements.txt

# Cài đặt các gói yêu cầu
RUN pip3 install --no-cache-dir --upgrade -r /app/requirements.txt

# Sao chép toàn bộ mã nguồn vào container
COPY . /app

############################

# Giai đoạn sản xuất
FROM ubuntu:22.04

# Thiết lập biến môi trường để tránh các thông báo trong quá trình cài đặt
ENV DEBIAN_FRONTEND=noninteractive

# Cập nhật danh sách các gói và cài đặt các gói cần thiết cho runtime
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    apt-get install -y git
    
# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Sao chép các gói cài đặt từ giai đoạn build
COPY --from=builder /usr/local/lib/python3.10/dist-packages /usr/local/lib/python3.10/dist-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Sao chép mã nguồn vào container
COPY . /app

# Lệnh để chạy ứng dụng
CMD ["python3", "run.py"]
