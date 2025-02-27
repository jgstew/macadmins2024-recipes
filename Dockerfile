
FROM ubuntu:latest

# MAINTAINER is deprecated, but I don't know how else to set the `AUTHOR` metadata
MAINTAINER james@jgstew.com

# Labels.
LABEL maintainer="james@jgstew.com"

# https://medium.com/@chamilad/lets-make-your-docker-image-better-than-90-of-existing-ones-8b1e5de950d
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="macadminsrecipes"
LABEL org.label-schema.description="Run macadmins2024-recipes using AutoPkg on ubuntu:latest"
LABEL org.label-schema.url="https://github.com/jgstew/macadmins2024-recipes"
LABEL org.label-schema.vcs-url="https://github.com/jgstew/macadmins2024-recipes"
LABEL org.label-schema.docker.cmd="docker run --rm macadmins2024recipes run -vv com.github.jgstew.test.DateTimeFromString"
# docker run -it --entrypoint bash macadmins2024recipes

# Update everything?
# RUN apt-get update && apt-get upgrade -y

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes libmagic-dev jq p7zip-full msitools curl git wget python3 python3-pip build-essential libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/macadmins2024-recipes

COPY . /root/macadmins2024-recipes

WORKDIR /root/macadmins2024-recipes

RUN bash setup_ubuntu.sh

ENTRYPOINT ["./../autopkg/.venv/bin/python3", "../autopkg/Code/autopkg"]
CMD ["help"]

# Interactive:
#   docker run --rm -it --entrypoint bash jgstewrecipes
# Run recipe from within Interactive shell
#   python3 ../autopkg/Code/autopkg run -vv com.github.jgstew.test.DateTimeFromString

# Run a specific recipe:
#   docker run --rm jgstewrecipes run -vv com.github.jgstew.test.DateTimeFromString

# run test recipes: docker run --rm jgstewrecipes run -vv --recipe-list Test-Recipes/Test-Recipes.recipelist.txt
