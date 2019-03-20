FROM       ubuntu:18.04
MAINTAINER thebeeman "https://github.com/TheBeeMan"

RUN apt-get update
RUN apt-get install -y man apt-file git vim curl wget python python3 python-pip python3-pip tmux openssh-server
RUN apt-get install -y net-tools iproute2
RUN mkdir /var/run/sshd
RUN echo 'root:Hi@sunofbeach' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN git clone --depth=1 git://github.com/amix/vimrc.git ~/.vim_runtime
RUN sh ~/.vim_runtime/install_basic_vimrc.sh
#RUN apt-get install -y zsh
#RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
#RUN chsh -s /bin/zsh
#COPY zshrc /root/.zshrc
RUN mkdir /root/zsrc /root/ztest

WORKDIR /root/zsrc

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
