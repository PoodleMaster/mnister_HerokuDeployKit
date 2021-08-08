# ■mnisterアプリ「Heroku Deploy Kit」
This is the mnister application used in the Qiita article.

See the next page for details.

URL：https://qiita.com/PoodleMaster/items/32ab70b14940ada5d8a9

# ■Requirements
- python3.8+ ([python](https://www.python.org/downloads/) or [annaconda](https://www.anaconda.com/products/individual))
- [git](https://git-scm.com/downloads)
- [Docker / Docker desktop (about version 20.10.7)](https://www.docker.com/get-started)
- [Heroku Account](https://jp.heroku.com/home)
- [Heroku CLI](https://devcenter.heroku.com/ja/articles/heroku-cli)

# ■How to
1. Git Clone
```bash
git clone https://github.com/PoodleMaster/mnister_HerokuDeployKit
cd mnister_HerokuDeployKit
```

2. Create Dockerfile
```dockerfile:Dockerfile
# base
FROM continuumio/miniconda3

# If you are running under a proxy, enable the following and specify the Proxy server.
## apt-get
# ENV http_proxy  "http://proxy.server.com:8080"
# ENV https_proxy "http://proxy.server.com:8080"

## pip
# ENV HTTP_PROXY  "http://proxy.server.com:8080"
# ENV HTTPS_PROXY "http://proxy.server.com:8080"

# init
RUN apt-get update
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
```

3. Heroku Command
Heroku application name must be unique. Give yourself a Heroku application name.

※Heroku application name → `YourHerokuAppName`

```
sudo heroku container:login
sudo heroku create YourHerokuAppName
sudo heroku container:push web -a YourHerokuAppName
sudo heroku container:release web -a YourHerokuAppName
```

4. Access URL

URL：https://YourHerokuAppName.herokuapp.com/

# ■Sample
![mnister](https://user-images.githubusercontent.com/69660581/128281550-589a4ddb-20e1-47e5-b803-c202db9c3640.png)

Please access the following URL.

URL：https://mnister-web.herokuapp.com/

# ■Contributing
Contributions, issues and feature requests are welcome.

# ■Author
Github: PoodleMaster

# ■License
Check the LICENSE file.
