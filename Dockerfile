FROM python:3.10-alpine

RUN apk add --no-cache bash git py-pip
RUN pip install gitchangelog pystache
RUN install -d -o nobody -g nobody -m 0755 /data

USER nobody
WORKDIR /data

CMD ["gitchangelog"]
