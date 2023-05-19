FROM nvcr.io/nvidia/cuda:11.7.1-cudnn8-devel-ubuntu22.04

# TODO: User should be refactored instead of hard coded cpx
ARG USERNAME=cpx

USER root

ENV DEBIAN_FRONTEND noninteractive

# TODO: UID be refactored instead of hard coded 1000 to your host UID
ENV USERNAME $USERNAME
ENV GROUPNAME fastchat_users
ENV UID 1000
ENV GID 1000
ENV HOME /home/$USERNAME
ENV PATH ${HOME}/.local/bin:${PATH}

# Use bash instead of sh
# ENV SHELL /bin/bash
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        software-properties-common && \
    add-apt-repository ppa:kelleyk/emacs -y && \
    apt-get update && \
	apt-get install -yq --no-install-recommends \
		apt-transport-https \
		build-essential \
		bzip2 \
		ca-certificates \
		curl \
		g++ \
		git \
		gnupg \
		graphviz \
		locales \
		lsb-release \
		openssh-client \
		sudo \
		unzip \
		vim \
		wget \
		zip \
		python3.10 \
		python3-pip \
		python3-dev \
		python3-setuptools \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# change the locale from POSIX to UTF-8
RUN locale-gen en_US en_US.UTF-8 && \
	update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV PYTHONIOENCODING=utf-8

# Create USERNAME user with UID=1000 and in the 'users' group
# but allow for non-initial launches of the notebook to have
# ${HOME} provided by the contents of a PV
RUN useradd -M -s /bin/bash -N -u $UID $USERNAME && \
    groupadd -g ${GID} ${GROUPNAME} && \
    usermod -g ${GROUPNAME} ${USERNAME} && \
    chown -R ${USERNAME}:${GROUPNAME} /usr/local/bin && \
    mkdir -p ${HOME}/workspace && \
    chown -R ${USERNAME}:${GROUPNAME} ${HOME}

# NOTE: Beyond this point be careful of breaking out
# or otherwise adding new layers with RUN, chown, etc.
# The image size can grow significantly.

# python to 3.10
RUN apt-get update && apt-get install -yq --no-install-recommends \
        python-is-python3 \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# # Install Rust for Mac Machines
# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# GitLFS
RUN apt-get update && apt-get install -yq --no-install-recommends \
        git-lfs \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Time Zone
ENV TIMEZONE Asia/Toyko
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    echo $TIMEZONE > /etc/timezone

# # Install FastChat
# # https://github.com/cpx0/FastChat#method-2-from-source
# RUN git clone https://github.com/cpx0/FastChat.git .
# RUN pip install --upgrade pip
# RUN pip install -e .

# Install bitsandbytes, torch==2.0.1+cu117
RUN pip install bitsandbytes && \
    pip install torch --index-url https://download.pytorch.org/whl/cu117

# EXPOSE $PORT

# ENTRYPOINT ["python -m fastchat.serve.cli --model-path /path/to/model/weights"]


# Configure container startup
RUN chown -R ${USERNAME}:${GROUPNAME} /usr/local/bin && \
    chown -R ${USERNAME}:${GROUPNAME} ${HOME} && \
    chmod -R 755 ${HOME}
EXPOSE 5005 10000
USER ${USERNAME}
WORKDIR ${HOME}/workspace
CMD ["bash"]
