#!/bin/sh

# This is a simple script to configure the XRootD daemon prior to
# execution.  This takes care of things like making sure the ownership
# of the host certificate is correct.

XRD_CERT=${XROOTD_CERT:-/srv/xrd/xrdcert.pem}
if [ ! -e "${XRD_CERT}" ]; then
  cp /etc/grid-security/hostcert.pem ${XRD_CERT}
  chown xrootd: ${XRD_CERT}
  chmod 644 ${XRD_CERT}
fi

XRD_KEY=${XROOTD_KEY:-/srv/xrd/xrdkey.pem}
if [ ! -e ${XRD_KEY} ]; then
  cp /etc/grid-security/hostkey.pem ${XRD_KEY}
  chown xrootd: ${XRD_KEY}
  chmod 644 ${XRD_KEY}
fi

exec /usr/bin/xrootd -R xrootd "$@"
