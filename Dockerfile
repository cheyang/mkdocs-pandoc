FROM ubuntu:14.04

# Set the env variables to non-interactive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_PRIORITY critical
ENV DEBCONF_NOWARNINGS yes

RUN apt-get -qq update && \
    apt-get -qq -y install wget texlive-latex-base texlive-fonts-recommended && \
    apt-get -qq -y install texlive-fonts-extra texlive-latex-extra && \
    apt-get clean

RUN wget https://github.com/jgm/pandoc/releases/download/1.13.2/pandoc-1.13.2-1-amd64.deb && \
    dpkg -i pandoc* && \
    rm pandoc* && \
    apt-get clean

ADD run_doc.sh /usr/local/bin

RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  apt-get clean

RUN chmod u+x /usr/local/bin/run_doc.sh && \
    pip install mkdocs-pandoc

CMD ["run_doc.sh"]