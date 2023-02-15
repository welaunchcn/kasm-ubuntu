FROM kasmweb/core-cuda-focal:1.12.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
ENV VNC_OPTIONS -PreferBandwidth -DynamicQualityMin=4 -DynamicQualityMax=7 -DLP_ClipDelay=0 -publicIP=127.0.0.1

WORKDIR $HOME

######### Customize Container Here ###########

ENV DOCKER_CHANNEL=stable \
	DOCKER_VERSION=20.10.9 \
	DOCKER_COMPOSE_VERSION=1.29.2 \
	DEBUG=false

# Apt Update
RUN apt update

# Install Utils
RUN apt -y install iputils-ping git tmux nano zip xdotool

# Install JDK
RUN apt -y install default-jdk

# Install DotNet
COPY ./src/ubuntu/install/dotnet $INST_SCRIPTS/dotnet/
RUN bash $INST_SCRIPTS/dotnet/install_dotnet.sh  && rm -rf $INST_SCRIPTS/dotnet/

# Install Zsh
COPY ./src/ubuntu/install/zsh $INST_SCRIPTS/zsh/
RUN bash $INST_SCRIPTS/zsh/install_zsh.sh  && rm -rf $INST_SCRIPTS/zsh/

# Install Mini Conda
COPY ./src/ubuntu/install/miniconda $INST_SCRIPTS/miniconda/
RUN bash $INST_SCRIPTS/miniconda/install_miniconda.sh  && rm -rf $INST_SCRIPTS/miniconda/

# Install Visual Studio Code
COPY ./src/ubuntu/install/vs_code $INST_SCRIPTS/vs_code/
RUN bash $INST_SCRIPTS/vs_code/install_vs_code.sh  && rm -rf $INST_SCRIPTS/vs_code/

# Install Google Chrome
COPY ./src/ubuntu/install/chrome $INST_SCRIPTS/chrome/
RUN bash $INST_SCRIPTS/chrome/install_chrome.sh  && rm -rf $INST_SCRIPTS/chrome/

# Install Only Office
COPY ./src/ubuntu/install/only_office $INST_SCRIPTS/only_office/
RUN bash $INST_SCRIPTS/only_office/install_only_office.sh  && rm -rf $INST_SCRIPTS/only_office/

# Install Filezilla
COPY ./src/ubuntu/install/filezilla $INST_SCRIPTS/filezilla/
RUN bash $INST_SCRIPTS/filezilla/install_filezilla.sh  && rm -rf $INST_SCRIPTS/filezilla/

# Install DBeaver
COPY ./src/ubuntu/install/dbeaver $INST_SCRIPTS/dbeaver/
RUN bash $INST_SCRIPTS/dbeaver/install_dbeaver.sh  && rm -rf $INST_SCRIPTS/dbeaver/

# Install Meld
COPY ./src/ubuntu/install/meld $INST_SCRIPTS/meld/
RUN bash $INST_SCRIPTS/meld/install_meld.sh  && rm -rf $INST_SCRIPTS/meld/

# Install Asbru CM
COPY ./src/ubuntu/install/asbru_cm $INST_SCRIPTS/asbru_cm/
RUN bash $INST_SCRIPTS/asbru_cm/install_asbru_cm.sh  && rm -rf $INST_SCRIPTS/asbru_cm/

# Upgrade packages
RUN apt -y upgrade

COPY ./src/common/startup_scripts/vnc_startup.sh $STARTUPDIR/

######### End Customizations ###########

RUN chown 1000:0 $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
