FROM continuumio/miniconda3 AS build
WORKDIR /app

# Create the environment:
COPY environment.yml .
RUN conda env create -f environment.yml

# Install conda-pack:
RUN conda install -c conda-forge conda-pack

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n myenv -o /tmp/env.tar && \
  mkdir /venv && cd /venv && tar xf /tmp/env.tar && \
  rm /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack


# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster AS runtime

# Copy /venv from the previous stage:
COPY --from=build /venv /venv

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "venv", "/bin/bash", "-c"]

# Activate the environment, and make sure it's activated:
#RUN echo "conda activate myenv" > ~/.bashrc
#RUN echo "Make sure flask is installed:"
#RUN python -c "import flask"

# The code to run when container is started:
COPY hello.py .
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "venv", "python", "hello.py"]
