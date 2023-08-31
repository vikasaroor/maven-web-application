FROM debian
COPY test.sh .
ARG branchname=default
RUN echo $branchname
CMD "echo $branchname"
