FROM       ubuntu:18.04
MAINTAINER thebeeman "https://github.com/TheBeeMan"

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak

## Change apt package source address to aliyun platform
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
RUN apt-get install -y man apt-file git vim curl wget python python3 python-pip python3-pip tmux openssh-server build-essential
RUN apt-get install -y net-tools iproute2
RUN mkdir /var/run/sshd
RUN echo 'root:passwd-must-modify' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN git clone --depth=1 git://github.com/amix/vimrc.git ~/.vim_runtime
RUN sh ~/.vim_runtime/install_basic_vimrc.sh

## Install zsh and change it for terminal in default
RUN apt-get install -y zsh
RUN chsh -s /bin/zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
RUN ~/.oh-my-zsh/tools/install.sh
RUN git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
RUN apt-get install autojump

## Install radare2
RUN git clone https://github.com/radare/radare2 /home/soh0ro0t/tools/radare2 \
    && cd /root/private/ctf/tools/radare2 \
    && ./sys/install.sh
    
## Install binwalk
RUN git clone https://github.com/devttys0/binwalk /home/soh0ro0t/tools/binwalk \
    && cd /root/private/ctf/tools/binwalk \
    && python setup.py install
 
## Install american-fuzzy-lop
RUN wget --quiet http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz -O /root/private/ctf/tools/afl-latest.tgz \
    && cd /home/soh0ro0t/tools/ \
    && tar -xzvf afl-latest.tgz \
    && rm afl-latest.tgz \
    && (cd afl-*;make;(cd llvm_mode;make);make install)

## Install angr
#RUN git clone https://github.com/angr/angr-dev /root/private/ctf/tools/angr-dev \
#    && cd /root/private/ctf/tools/angr-dev \
#    && ./setup.sh -i -e angr
RUN pip2 install angr

## Install ROPGadget
RUN git clone https://github.com/JonathanSalwan/ROPgadget /root/private/ctf/tools/ROPgadget \
    && cd /root/private/ctf/tools/ROPgadget \
    && python setup.py install

RUN mkdir /root/workspace /root/private

EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]

WORKDIR /root/private

