FROM kasmweb/core-cuda-focal:1.12.0
USER root

ENV DEBUG false
ENV TZ Asia/Shanghai
ENV HOME /home/kasm-user
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
ENV VNC_OPTIONS -PublicIP=127.0.0.1

# Make User Home Dir
RUN mkdir -p $HOME $HOME/Desktop $HOME/Downloads $HOME/Documents

WORKDIR $HOME

# Apt Update
RUN apt update

# Install Utils
RUN apt -y install iputils-ping git tmux nano zip xdotool
RUN git config --global user.name user && git config --global user.email user@mail.com

# Install JDK
RUN apt -y install default-jdk

# Copy Scripts
COPY ./src/ubuntu/install $INST_SCRIPTS/
COPY ./src/common/startup_scripts/vnc_startup.sh $STARTUPDIR/

# Install DotNet
RUN bash $INST_SCRIPTS/dotnet.sh

# Install Mini Conda
RUN bash $INST_SCRIPTS/miniconda.sh

# Install JupyterLab Desktop
RUN bash $INST_SCRIPTS/jupyterlab_desktop.sh

# Install Visual Studio Code
RUN bash $INST_SCRIPTS/vs_code.sh

# Install Google Chrome
RUN bash $INST_SCRIPTS/chrome.sh

# Install Only Office
RUN bash $INST_SCRIPTS/only_office.sh

# Install Filezilla
RUN bash $INST_SCRIPTS/filezilla.sh

# Install DBeaver
RUN bash $INST_SCRIPTS/dbeaver.sh

# Install Meld
RUN bash $INST_SCRIPTS/meld.sh

# Install Asbru CM
RUN bash $INST_SCRIPTS/asbru_cm.sh

# Upgrade packages
RUN apt -y upgrade

ENTRYPOINT ["/dockerstartup/vnc_startup.sh", "--wait"]
