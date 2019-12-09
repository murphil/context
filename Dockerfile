FROM debian:buster-slim

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TIMEZONE=Asia/Shanghai

# Install packages to download ConTeXt minimals
RUN sed -i 's/\(.*\)\(security\|deb\).debian.org\(.*\)main/\1ftp.cn.debian.org\3main contrib non-free/g' /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends rsync \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install ConTeXt minimals
# http://wiki.contextgarden.net/ConTeXt_Standalone
RUN mkdir /opt/context \
  && cd /opt/context \
  && rsync -ptv rsync://contextgarden.net/minimals/setup/first-setup.sh . \
  && sh ./first-setup.sh --engine=luatex --modules=all --fonts=all \
  && rm -rf /opt/context/tex/texmf-context/doc

ENV PATH="/opt/context/tex/texmf-linux-64/bin:${PATH}"