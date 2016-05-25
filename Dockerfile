FROM codesimple/elm:0.17

WORKDIR /code

ADD . /code

CMD ["reactor", "-a", "0.0.0.0"]

EXPOSE 8000
