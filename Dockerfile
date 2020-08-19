FROM debian:buster

MAINTAINER Gregory Weaver "gregory.weaver@gmail.com"

# pip, debug tools.
RUN apt-get update -y && apt-get install -y \
  python-pip \
  python-dev \
  procps \
  net-tools \
  curl

# pip dependencies for Flask
COPY ./requirements.txt /var/peakApp/requirements.txt

WORKDIR /var/peakApp

RUN pip install -r requirements.txt

COPY app.py /var/peakApp

EXPOSE 5000/tcp

ENTRYPOINT [ "python" ]

CMD [ "app.py" ]
