# base
FROM continuumio/miniconda3:4.9.2

# If you are running under a proxy, enable the following and specify the Proxy server.
## For apt-get
# ENV http_proxy  "http://proxy.server.com:8080"
# ENV https_proxy "http://proxy.server.com:8080"

## For pip
# ENV HTTP_PROXY  "http://proxy.server.com:8080"
# ENV HTTPS_PROXY "http://proxy.server.com:8080"

# init
RUN apt-get update --allow-releaseinfo-change
RUN apt-get install -y build-essential
RUN apt-get install -y libjpeg-dev
RUN pip install --upgrade pip

# install conda package
# You can also use the conda command.
# RUN conda install gcc_linux-64 gxx_linux-64

# install pip package
RUN pip install Pillow==7.2.0
RUN pip install tensorflow-cpu==2.5.0
RUN pip install Flask==2.0.1
RUN pip install gunicorn==20.1.0

# app
WORKDIR /bg
COPY server.py .
COPY colab_mnist.hdf5 .
COPY static static/
COPY templates templates/

# Localhost deploy
# EXPOSE 5000
# CMD ["gunicorn", "--bind=0.0.0.0:5000", "server:app"]

# Heroku deploy
CMD gunicorn --bind 0.0.0.0:$PORT server:app
