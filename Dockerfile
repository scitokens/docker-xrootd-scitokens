FROM centos:centos7

LABEL name="XRootD SciTokens Demo"
LABEL build-date="20180119"
LABEL maintainer="Brian Bockelman"

EXPOSE 443

COPY hcc-testing.repo /etc/yum.repos.d/

RUN yum -y install https://repo.grid.iu.edu/osg/3.4/osg-3.4-el7-release-latest.rpm && \
    yum -y install epel-release \
                   yum-plugin-priorities

RUN yum --enablerepo=hcc-testing -y install xrootd-scitokens xrootd xrootd-multiuser

RUN mkdir -p /export
RUN mkdir -p /srv/xrd

RUN yum clean all

COPY scitokens.cfg /etc/xrootd
COPY xrootd-scitokens.cfg /etc/xrootd
COPY robots.txt /etc/xrootd
COPY xrootd-startup.sh /srv/xrd

VOLUME /export /etc/grid-security

ENV XDG_CACHE_HOME=/var/tmp

#USER xrootd:xrootd
ENTRYPOINT ["/srv/xrd/xrootd-startup.sh"]
CMD ["-c", "/etc/xrootd/xrootd-scitokens.cfg"]
