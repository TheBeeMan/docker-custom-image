FROM       ubuntu:18.04
MAINTAINER thebeeman "https://github.com/TheBeeMan"

ENV DEBIAN_FRONTEND noninteractive

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak

## Change apt package source address to aliyun platform
RUN echo "deb http://mirrors.ustc.edu.cn/ubuntu bionic main restricted universe multiverse" | tee /etc/apt/sources.list
RUN echo "deb http://mirrors.ustc.edu.cn/ubuntu bionic-security main restricted universe multiverse" | tee -a /etc/apt/sources.list
RUN echo "deb http://mirrors.ustc.edu.cn/ubuntu bionic-updates main restricted universe multiverse" | tee -a /etc/apt/sources.list
RUN echo "deb http://mirrors.ustc.edu.cn/ubuntu bionic-proposed main restricted universe multiverse" | tee -a /etc/apt/sources.list
RUN echo "deb http://mirrors.ustc.edu.cn/ubuntu bionic-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://mirrors.ustc.edu.cn/ubuntu bionic main restricted universe multiverse" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://mirrors.ustc.edu.cn/ubuntu bionic-security main restricted universe multiverse" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://mirrors.ustc.edu.cn/ubuntu bionic-updates main restricted universe multiverse" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://mirrors.ustc.edu.cn/ubuntu bionic-proposed main restricted universe multiverse" | tee -a /etc/apt/sources.list
RUN echo "deb-src http://mirrors.ustc.edu.cn/ubuntu bionic-backports main restricted universe multiverse" | tee -a /etc/apt/sources.list

## Install essential components
RUN apt-get update -y \ 
	&& apt-get install -y apt-utils man apt-file git vim curl wget python python3 python-pip python3-pip \
	&& apt-get install -y tmux openssh-server build-essential \
	&& apt-get install -y net-tools iproute2 \
	&& apt-get install -y clang llvm-dev

RUN mkdir /var/run/sshd
RUN echo 'root:passwd-must-modify' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN mkdir /root/.ssh
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN git clone --depth=1 git://github.com/amix/vimrc.git ~/.vim_runtime
RUN sh ~/.vim_runtime/install_basic_vimrc.sh

# Create fequently use directory
RUN mkdir /root/workspace /root/private

## Install zsh and change it for terminal in default
RUN apt-get update -y && apt-get install -y zsh \
	&& apt-get install -y autojump 
RUN chsh -s /bin/zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Install binwalk
RUN git clone https://github.com/devttys0/binwalk /root/private/tools/binwalk \
    && cd /root/private/tools/binwalk \
    && python setup.py install
 
## Install angr
#RUN git clone https://github.com/angr/angr-dev /root/private/ctf/tools/angr-dev \
#    && cd /root/private/ctf/tools/angr-dev \
#    && ./setup.sh -i -e angr
RUN pip2 install -i https://pypi.tuna.tsinghua.edu.cn/simple angr

## Install ROPGadget
RUN git clone https://github.com/JonathanSalwan/ROPgadget /root/private/ctf/tools/ROPgadget \
    && cd /root/private/ctf/tools/ROPgadget \
    && python setup.py install

EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]

WORKDIR /root/private

