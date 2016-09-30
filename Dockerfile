FROM hypriot/rpi-alpine-scratch

RUN apk update && \
apk upgrade && \
apk add bash python py-pip sudo make g++ libpng libpng-dev && \
pip install --upgrade pip && \
pip install paho-mqtt && \
pip install httplib2 &&\
pip install pyqrcode &&\
pip install pypng &&\
mkdir -p /home/root/py &&\
rm -rf /var/cache/apk/*

WORKDIR /home/root/
ADD ql570/ ql570code
RUN cd ql570code &&\
    make && \
    cp ql570 /home/root/ && \
    cd /home/root &&\
    apk del make g++ libpng-dev

ADD registration_server.py /home/root/
ENTRYPOINT python registration_server.py
