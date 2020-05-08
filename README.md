# Overview
I wanted to experiment with the builder pattern to see how it worked. This repository contains two examples

> Disclaimer: When I wrote this example I had limited experience with Docker and zero experience with the builder pattern and that is why I wanted to test it out and see how it worked in practice. This is not production ready code. Just a personal experiment.

There are a couple of reason why you may want to use a builder pattern

1. You have people on your team that help you in development, but not necessarily developers themselves. I have had experience with System Engineers and Configuration Managers needing to be able to build and test components, but are not developers and don't exactly understand all the nuances of setting up a build environment.
1. Your builder configuration is versioned controlled along with your code. It makes checking out and building a release branch easy. There have been instances where I've had to compile older baselines for patches but the main development environment has migrated for the new work with different versions of the development software and libraries.
1. You can provide your continuous integration services the builder environment instead of specifying all the requirements inside of the CI server (e.g. Jenkins)

## Setup
At the time of this writing I was running Ubuntu 16.4 and openjdk 14 and gradle 6.3.

# Example 1 - Builder using a multi-stage Docker file
In the example, we use a multi-stage Dockerfile to build the artifacts and then output a single small container based on the previous stages artifacts. 


* Build | `docker build --tag server ./server`
* Run | `docker run --rm server:latest -p 8080:8080`
* Access | `curl -i -w '\n' http://localhost:8080/server/v1/acknowledge` 


## Pros
* All encapsulated and results in a single image ready to run.

## Cons
* Slow as it redownloads all of the dependencies each iteration whenver the source changes (which is usually every time you need to build).
* You could tag an intermediate builder as the base image, but then it becomes less useful to other projects as it may include libraries that are not required for that build and bloats the image.


# Example 2 - Builder using a Docker Volume
In the example, we use the an external Docker volume to hold all of the downloaded binaries and compiled artifacts. The example is more verbose than the first one so it gets its own page.

[Builder Example Instructions](./builder/README.md)

## Pros
* Fast as all the dependencies are downloaded to the folder and not downloaded again.

## Cons
* The binary is in the volume and you have to extract it to use it or mount it into another container.
* Requires the ability to manage docker volumes and understanding how the pieces fit together.

