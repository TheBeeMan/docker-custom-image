FROM       ubuntu:18.04
MAINTAINER thebeeman "https://github.com/TheBeeMan"

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak

echo -e "deb https://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse \n"\
    "deb https://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse \n"\
    "deb https://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse \n"\
    "deb https://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse \n"\
    "deb https://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse \n"\
    "\n"\
    "# deb-src https://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse \n"\
    "# deb-src https://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse \n"\
    "# deb-src https://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse \n"\
    "# deb-src https://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse \n"\
    "# deb-src https://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse \n" > /etc/apt/sources.list

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

## Install zsh and change it for terminal in default
RUN apt-get install -y zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
RUN chsh -s /bin/zsh

## Install radare2
RUN git clone https://github.com/radare/radare2 /home/soh0ro0t/tools/radare2 \
    && cd /home/ctf/tools/radare2 \
    && ./sys/install.sh
    
## Install binwalk
RUN git clone https://github.com/devttys0/binwalk /home/soh0ro0t/tools/binwalk \
    && cd /home/ctf/tools/binwalk \
    && python setup.py install
 
## Install american-fuzzy-lop
RUN wget --quiet http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz -O /home/ctf/tools/afl-latest.tgz \
    && cd /home/soh0ro0t/tools/ \
    && tar -xzvf afl-latest.tgz \
    && rm afl-latest.tgz \
    && (cd afl-*;make;(cd llvm_mode;make);make install)

## Install angr
#RUN git clone https://github.com/angr/angr-dev /home/ctf/tools/angr-dev \
#    && cd /home/ctf/tools/angr-dev \
#    && ./setup.sh -i -e angr
RUN pip2 install angr

## Install ROPGadget
RUN git clone https://github.com/JonathanSalwan/ROPgadget /home/ctf/tools/ROPgadget \
    && cd /home/ctf/tools/ROPgadget \
    && python setup.py install

RUN mkdir /root/zsrc /root/ztest

WORKDIR /root/zsrc

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
