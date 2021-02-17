FROM docker.io/bioconductor/bioconductor_docker:RELEASE_3_12
WORKDIR /workspace
RUN apt-get update \
	&& apt-get install -y openssh-server libhiredis-dev
COPY install-deps.R /workspace
RUN Rscript install-deps.R
COPY . /workspace
CMD bash /workspace/worker_commands