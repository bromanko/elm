FROM codesimple/elm:0.17

WORKDIR /code

ADD . /code

RUN elm package install --yes

CMD ["reactor", "-a", "0.0.0.0"]

EXPOSE 8000
