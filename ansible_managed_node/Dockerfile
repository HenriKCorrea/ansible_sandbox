# Use Alpine Linux as the base image
FROM alpine:3.19.1

# Update the package repository
RUN apk update

# Install OpenSSH and Python (the python version is 3.11, tied to the alpine version)
RUN apk add --no-cache openssh python3

# Copy the ssh key
COPY ansible_ssh_key.pub /root/.ssh/authorized_keys

# Ensure the authorized_keys permissions are correct
RUN chmod 600 /root/.ssh/authorized_keys && chown root:root /root/.ssh/authorized_keys

# Generate host keys
RUN ssh-keygen -A

# Run sshd in the foreground
CMD ["/usr/sbin/sshd","-D"]