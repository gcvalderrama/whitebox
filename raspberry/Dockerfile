FROM docker.io/locustio/locust:1.1
#ENV PATH="/home/locust/.local/bin:${PATH}"
USER root
RUN apt-get update -y
RUN apt-get install telnet -y
RUN apt-get install vim -y
RUN cd ~
COPY ./requirements.txt .
RUN python3 -m pip install --upgrade pip
RUN pip3 install -r requirements.txt
RUN mkdir /app
RUN chmod 777 /app
USER locust
RUN ls -l
# RUN python -c "import sys; print(sys.path)"


