FROM docker.io/locustio/locust:1.4.3
#ENV PATH="/home/locust/.local/bin:${PATH}"
USER root
RUN cd ~
COPY ./requirements.txt .
RUN python3 -m pip install --upgrade pip
RUN pip3 install -r requirements.txt
RUN mkdir /target
RUN mkdir /target/app
RUN mkdir /reports
RUN chmod 777 /reports
RUN chmod 777 /target/app
USER locust
RUN whoami
WORKDIR /target/app
COPY ./app .
RUN ls -l /target/app
# RUN python -c "import sys; print(sys.path)"



