FROM ubuntu:focal

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TIMEZONE=Asia/Shanghai

# Install packages to download ConTeXt minimals
RUN apt-get update \
  && apt-get install -y --no-install-recommends rsync fonts-noto-cjk wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install ConTeXt minimals
# http://wiki.contextgarden.net/ConTeXt_Standalone
RUN mkdir /opt/context \
  && cd /opt/context \
  && rsync -ptv rsync://contextgarden.net/minimals/setup/first-setup.sh . \
  && sh ./first-setup.sh --engine=luatex --modules=all --fonts=all \
  && rm -rf /opt/context/tex/texmf-context/doc

ENV TEXDIR=/opt/context/tex
ENV PATH="${TEXDIR}/texmf-linux-64/bin:${PATH}"
ENV OSFONTDIR="/usr/share/fonts/opentype/noto"

RUN set -eux \
  ; . $TEXDIR/setuptex $TEXDIR