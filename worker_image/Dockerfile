FROM docker.io/bioconductor/bioconductor_docker:RELEASE_3_12
RUN apt-get update \
	&& apt-get install -y openssh-server
COPY . /
WORKDIR /workspace
CMD bash /worker_commands