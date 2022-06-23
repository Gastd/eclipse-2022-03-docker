# eclipse-2022-03-docker

## Dependencies

1. Before use download the latest jdk

	wget https://download.oracle.com/java/18/archive/jdk-18.0.1.1_linux-x64_bin.deb

2. Download the submodules

	git submodule update --init --recursive

## How to run

1. Build the docker conteiner

	docker build . --tag eclipse-2022-03:latest

2. Run the script to run the docker and open eclipse

	sh run_docker.sh


## Usage
