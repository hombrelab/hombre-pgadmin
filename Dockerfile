# Dockerfile: hombre-pgadmin4

FROM hombrelab/hombre-python

ARG version

LABEL version="${version}"
LABEL description="Customized PGAdmin4 Docker image"
LABEL maintainer="Hombrelab <me@hombrelab.com>"
LABEL inspiration="getting things done my way"

# create a non-privileged user to use at runtime
RUN addgroup -g 50 -S pgadmin \
    && adduser -D -S -h /pgadmin -s /sbin/nologin -u 1000 -G pgadmin pgadmin \
    && mkdir -p /pgadmin/config /pgadmin/storage \
    && chown -R 1000:50 /pgadmin

# Install postgresql tools for backup/restore
RUN apk add --no-cache \
    libedit \
    postgresql \
    && cp /usr/bin/psql /usr/bin/pg_dump /usr/bin/pg_dumpall /usr/bin/pg_restore /usr/local/bin/ \
    && apk del \
    postgresql

RUN apk add --no-cache \
    postgresql-dev \
    libffi-dev

ENV PGADMIN_VERSION=4.20
ENV PYTHONDONTWRITEBYTECODE=1

RUN apk add --no-cache \
    alpine-sdk \
    linux-headers \
    && echo "https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v${PGADMIN_VERSION}/pip/pgadmin4-${PGADMIN_VERSION}-py2.py3-none-any.whl" | pip install --no-cache-dir -r /dev/stdin \
    && apk del \
    alpine-sdk \
    linux-headers

EXPOSE 5050

COPY /app/LICENSE /app/config_distro.py /usr/local/lib/python3.7/site-packages/pgadmin4/

USER pgadmin:pgadmin

CMD ["python", "./usr/local/lib/python2.7/site-packages/pgadmin4/pgAdmin4.py"]

VOLUME /pgadmin/