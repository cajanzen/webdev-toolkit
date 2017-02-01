FROM continuumio/miniconda
MAINTAINER Carl Janzen <carl.janzen@gmail.com>
RUN curl -o /usr/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
	&& rm /usr/bin/gosu.asc \
	&& chmod +x /usr/bin/gosu
RUN conda install -y \
    jupyter \
    psycopg2 \
    scikit-learn \
    seaborn \
    sqlalchemy
RUN apt-get update \
    && apt-get install -y \
        graphviz \
        parallel \
        postgresql-client
WORKDIR /code
COPY entrypoint.sh /
COPY login /usr/bin
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
