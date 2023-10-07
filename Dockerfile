# Use an appropriate base image, such as CentOS, for your Docker container.
# Choose an image that matches the OS requirements specified in the documentation.
FROM centos:7

# Install necessary dependencies and set up Docker
RUN yum update -y && yum install -y \
    wget \
    curl \
    && yum clean all

# Check if port 25 is already in use by postfix
RUN netstat -lnp | grep 25 && \
    systemctl stop postfix && \
    systemctl disable postfix || true

# Download CyberPanel installation script
RUN wget -O installer.sh https://mirror.cyberpanel.net/install-cn.sh

# Make the installer script executable
RUN chmod +x installer.sh

# Install CyberPanel
RUN ./installer.sh

# Expose the necessary ports
EXPOSE 8090 80 443 21 25 587 465 110 143 993 53 53/udp 7080 40110-40210

# Start the CyberPanel service
CMD ["sh", "-c", "/usr/local/CyberPanel/bin/start.py"]

# Optionally, add post-installation configuration if needed.
