# eclipse-2022-03-docker

## Dependencies

Before use download the latest jdk

	wget https://download.oracle.com/java/18/archive/jdk-18.0.1.1_linux-x64_bin.deb -O jdk-18_linux-x64_bin.deb

Download the submodules

	git submodule update --init --recursive

## How to run

Build the docker conteiner

	docker build . --tag eclipse-2022-03:latest

Run the script to run the docker and open eclipse

	sh run_docker.sh

## Usage

## Preparing ThEodorE's environment

1. add dependency plugins to lu.svv.theodore project classpath (including antlr as external .jar)
2. Hls.xtext >> run >> Generate
3. generated models >> Hls.genmodel >> Generate All
4. fix dependencies in lu.svv.theodore.ui by adding the lu.svv.theodore project
5. fix dependencies in lu.svv.theodore.test by adding junit to the dependencies