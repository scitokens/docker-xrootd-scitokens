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
    -p 127.0.0.1:443:1094 \
    --volume /etc/grid-security/:/etc/grid-security \
    --volume /tmp/exportfiles:/export \
    scitokens/xrootd-scitokens
```

This will export `/exportfiles` on port 443, only binding to localhost.

By default, the `scitokens.cfg` allows a few known SciTokens issuers, mapping them to
a sub-directory of the exported directory (e.g., `/osg` and `/cms`).  This may work for
quick demos, but production cases will likely want to overwrite this file with the site's
preferred issuers.

# Example Client Usage

Once you acquire a SciToken, it can be used by simply setting it in an `Authorization`
header:

```
$ curl -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImMxY2UwYzYyOWUwYzc3YTMzOGQwNjc2NDU5NDQ4NTA3Y2VkYzA4N2JiNTNlOGVmY2FjMzVhNjUxZTZmMDQxMzYifQ.eyJzdWIiOiJiYm9ja2VsbSIsImV4cCI6MTUxNzAyNDQ2NCwiaXNzIjoiaHR0cHM6Ly9zY2l0b2tlbnMub3JnL29zZy1jb25uZWN0IiwiaWF0IjoxNTE3MDIwODY0LCJzY3AiOiJyZWFkOi8iLCJuYmYiOjE1MTcwMjA4NjR9.0U-fmIvkkPgW3ElAeOczi10jxrItPWtlFgf2wQuU1a7bd2JEVQ9jocDYU0X7NKecvM3b3Q62D6QZqI4t8Q6rkIzR9jZAU4yG01L6_eq338D-Y6Xth56u44o8FaIVqOJY7mmMCBQGPoGPYyaZ4kO4PnMTu_2vhtjeyhOFOYJxUsFq5jnczfdikXyuJHkDuKSfal1JGeymQfxvamRew8ZOzyAQ-ONRCdn1aKhPVg6k9AfoTmeA6ijlBPmHmXJbbHKcVRaTVvFQvYX51eg6HX_qLeSqSN2InZfWlYj54IEDTAozic_89UzrH17heh3kL_S6gA4Y2ZNv3sgE05ke17u_KA' -k https://127.0.0.1:1094/osg/hello_world.txt
Hello OSG!
```
