# Docker images for XRootD with SciTokens Support

This repository contains a Docker image with XRootD configured to
serve HTTP with SciTokens support.

To run, the host needs to have the following:

* `/etc/grid-security` (or similar) with the traditional "grid layout" of a `certificates`
  subdirectory with CAs and `hostcert.pem` / `hostkey.pem` as a valid hostcert.
* A directory containing files to export.

These directories will need to be bind-mounted into the container.

To use, start a docker container with the following command:

```
docker run  -t -i \
    --volume /etc/grid-security/:/etc/grid-security \
    --volume /tmp/exportfiles:/export
    xrootd-scitokens:latest
```

This will export `/exportfiles` on the host.

By default, the `scitokens.cfg` allows a few known SciTokens issuers, mapping them to
a sub-directory of the exported directory (e.g., `/osg` and `/cms`).  This may work for
quick demos, but production cases will likely want to overwrite this file with the site's
preferred issuers.
