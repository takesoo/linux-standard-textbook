FROM almalinux:latest

RUN dnf -y update && \
  dnf -y install sudo passwd vim wget net-tools iputils iproute bash-completion openssh-server man man-pages bind-utils procps httpd && \
  dnf clean all

RUN mkdir /var/run/sshd && \
  sudo ssh-keygen -A && \
  echo 'root:root' | chpasswd && \
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
  sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN useradd linuc && \
  echo 'linuc:linuc' | chpasswd && \
  usermod -aG wheel linuc

RUN echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers