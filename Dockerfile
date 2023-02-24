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

# Set Aliyun Mirror
RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple

# Apt Update
RUN apt update

# Install Utils
RUN apt -y install iputils-ping git tmux nano zip xdotool

# Install JDK
RUN apt -y install default-jdk

# Copy Install Scripts
COPY ./src/ubuntu/install $INST_SCRIPTS/

# Install DotNet
RUN bash $INST_SCRIPTS/dotnet/install_dotnet.sh

# Install Mini Conda
RUN bash $INST_SCRIPTS/miniconda/install_miniconda.sh

# Install JupyterLab Desktop
RUN bash $INST_SCRIPTS/jupyterlab_desktop.sh

# Install Visual Studio Code
RUN bash $INST_SCRIPTS/vs_code/install_vs_code.sh

# Install Google Chrome
RUN bash $INST_SCRIPTS/chrome/install_chrome.sh

# Install Only Office
RUN bash $INST_SCRIPTS/only_office/install_only_office.sh

# Install Filezilla
RUN bash $INST_SCRIPTS/filezilla/install_filezilla.sh

# Install DBeaver
RUN bash $INST_SCRIPTS/dbeaver/install_dbeaver.sh

# Install Meld
RUN bash $INST_SCRIPTS/meld/install_meld.sh

# Install Asbru CM
RUN bash $INST_SCRIPTS/asbru_cm/install_asbru_cm.sh

# Upgrade packages
RUN apt -y upgrade

ENTRYPOINT ["/dockerstartup/vnc_startup.sh", "--wait"]
