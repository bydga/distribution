FROM golang:1.5.3

RUN apt-get update && \
    apt-get install -y librados-dev apache2-utils && \
    rm -rf /var/lib/apt/lists/*

ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution
ENV GOPATH $DISTRIBUTION_DIR/Godeps/_workspace:$GOPATH
ENV DOCKER_BUILDTAGS include_rados include_oss include_gcs

WORKDIR $DISTRIBUTION_DIR
COPY . $DISTRIBUTION_DIR
COPY cmd/registry/config-dev.yml /etc/docker/registry/config.yml
RUN make PREFIX=/go clean binaries

RUN mkdir /registry && /bin/echo -e "-----BEGIN CERTIFICATE-----\nMIIFSTCCAzGgAwIBAgIIC0CI0K4TvpMwDQYJKoZIhvcNAQEFBQAwMjEUMBIGA1UE\nAwwLU0JLU0FkbWluQ0ExDTALBgNVBAoMBFNCS1MxCzAJBgNVBAYTAkNaMB4XDTEz\nMTExMzE1MjczOVoXDTIzMTExMTE1MjczOVowMjEUMBIGA1UEAwwLU0JLU0FkbWlu\nQ0ExDTALBgNVBAoMBFNCS1MxCzAJBgNVBAYTAkNaMIICIjANBgkqhkiG9w0BAQEF\nAAOCAg8AMIICCgKCAgEAq32CZfc7fqoMFM1dekE1SZOzlEgDkIHahYYlz66BrhXq\nVvx9xlIUAwqVyvdDmiBl988vzTs5j9NfEdGrBkhEJHtmaPlHOh+DU6xyhymGS96m\nhtfWxmVRasFy0SYPexBmqnjU0QOtoDgED0JbkZNJ6+38mYTr0F0A0kxItuZOyetx\nUFHRd1p5hmF6zruf6S79lz95BHcXkZqIQS+w2eEZDU82HOTzhm3W/GMg6zStEaoS\nRzVhFz0XGeGbLXcGQQWYHS/m2j+bzjd/ep8uZPo6EOfU6tkYzRG9FkAbsADCAnwN\npRX4+2oeXByerSKNcr/eUXyxzrnS7WhUP9PMSvSsBiD7qQFV4h6PTtCrk9NXSLgv\neqrZDfAhf6kRNGLKwFKKKy3y1o2PGVbpK9ZlLpwkv1HCv8K4OMBJmOuPo0ooNyB/\nZoCU83SBio5NzQ0+w0u6NAgJJConTD5KQsDI1lg+8Ij584DsjVuHhrDgZBmXK6Nb\nOsO2HwN9AbCnWd1J+cMvoi9aATytYLMCjKu166xuSJZNGkgU5iamJXcbnPuGtex8\nv2iNwYr4v7/4Z9ThGtnylN7Nd086L0NVMLif5OkW9xtdyRaeh6e58ICCmNPITNd5\najLHWR5ZjmrTlm8CrYRdtqwrXPNBG5f1bInaHhlbX24ulAC2xHLZv0aWkKR7s8cC\nAwEAAaNjMGEwHQYDVR0OBBYEFKhkZ43c15JJY6elMZ1+ldKZjx7sMA8GA1UdEwEB\n/wQFMAMBAf8wHwYDVR0jBBgwFoAUqGRnjdzXkkljp6UxnX6V0pmPHuwwDgYDVR0P\nAQH/BAQDAgGGMA0GCSqGSIb3DQEBBQUAA4ICAQCoNaF18guCrOeXBO+Tkdyzg2md\nnTPluEST7iZbDA+ntHrY0djBVOL3DRgSLIb+Y7w3VdWljx57B+tr5amjZ5zosAzI\nOC6T00hQnuhW6tvD3vMUxL0tyaRa22y+3Bq8IGQ9IJ0WrRQUtzpHe4dqVFT6jxbL\nBRJ0LmZ9zE/U9PweV2T9xqZPcn6m/oUFWZYDzBT/sOwnKZuZUI03Cqyb5Pyez83a\nkJ/1ZZYpV9UdiZAo7SitwqRaEXnCk0nLgy4esGcflV5pfAb8hfD88skFR/i+xUBk\nJx0XgzVfNJ29PIaxgyz66ot3gJg7xK/qvVpYr15cwDHnRIqQDKc7Vs6iCSIJ7gdg\n2n8Sq+GxCIyjlJN2AOELZ86zeZTw2uxkrEALZgOReS9uB8fdjg9rjx8kVaRrF2gG\no+qppn7QKh8+FWJZeB8cjoqAl8vAoCN6qnDMW6fq39XxPK3uzRpWvCPrsQFBTCtU\nI9QV28g4VOwviGenC/nBKwFXryUcTAT1h3pitLiAumdUqP23+u3BJIDXx2p1Robg\nGjlev4HJybJE2tlx1+dke5teZWDg+vXAZ56XVZjJQDC6j+SbB2gTgRaBhJzHYdfM\nVLbFuihJxzSzAc3NbSImIWu/vUGnu0PweMtzmuZtDrwf5kX9joKaEJsIHQq7PwXC\nM1xAkvoMCDw5llOb1A==\n-----END CERTIFICATE-----\n-----BEGIN CERTIFICATE-----\nMIIFSzCCAzOgAwIBAgIIcpywx7jRr1cwDQYJKoZIhvcNAQEFBQAwMjEUMBIGA1UE\nAwwLU0JLU0FkbWluQ0ExDTALBgNVBAoMBFNCS1MxCzAJBgNVBAYTAkNaMB4XDTEz\nMTExMzE2NDg0M1oXDTIzMTExMTE1MjczOVowNDEWMBQGA1UEAwwNU0JLU1NlcnZp\nY2VDQTENMAsGA1UECgwEU0JLUzELMAkGA1UEBhMCQ1owggIiMA0GCSqGSIb3DQEB\nAQUAA4ICDwAwggIKAoICAQCwVu7TncyP+u+o82bZMWX2j4aFqiFCgprsUD8uC43W\nonFRg0pKTJ1yd4vk/VODLzUr/pJj50obPJYQgV6UgQC6Gttjml+YXHc+QDdh+Rvv\nPVtfXTZ/2ZU4dhlpjT5vv0hdwlNj9wvMVpUP0rd4xBIFLQla6PoSRSDY7Ge5JBFc\nIBevBk296m5vTApQP/wjU228YwpKO4JuckKZI0S1DrYK/BGgQidmPSEunCzalqtd\n5ZsCOejVW+Sn/zpyj9gRB14VQS+GrwJLSyuIiMK30k1ygMuDsWfswHpCflEnPhCC\nFOwfwBXILPiyd6SA2TdRU+IN1vcDbdmfPORuXwXMy+QCMxc9ARWxFrwTGsWinqcH\ntr214wb4IzcOQ0+dO254Wtvx6TVKOnIXq0RnGKQh8fCjyfbTe2s/7OUW3DJoy5kw\nB5Rc9FEwuwxBkwo6GMvIDBUjmnmtI+LtwNpYWUFsdJwr45bvpeWMQ4f51Dt2l2Yi\nf3vOHJRnPXRrK5vu/uflR+wGcQobhpY+uu95eP+3LpYIuSkbFYo/RJPOfulzzmcq\nQ6PbGwuBNREokDhkOMDout+PYV24E0Zvz0Cyt4RqgtrnWhbA+BmFLKFCqirIL0M6\n9pE0JxdHsrAKkFN13TOXfC/KL1Sd+5YFn8Di6j0hqz9Tb83xSZqCaDLnvoEJCzXQ\nvwIDAQABo2MwYTAdBgNVHQ4EFgQUqbnAMka3pYwROQ+TzjdFi1JQb2IwDwYDVR0T\nAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBSoZGeN3NeSSWOnpTGdfpXSmY8e7DAOBgNV\nHQ8BAf8EBAMCAYYwDQYJKoZIhvcNAQEFBQADggIBAEKVHflht1PSx35AlICU8Y5e\n5E1ApLIyRPzoAQsK2YbIQsh0/0P4+UWXGRzUTHxYem0UlEfAietoI87YVJnjZGuQ\nKkTVbqLM/gkpHk6oHSKnnwemhwXncdR7X+8C2FpUPTTCfWZ31nXyExuM/Jg1MXAe\nYlIk4+CFg71xIQbfb77K4ECphfBiwzFe5SdwJo7kZBrgOZcxSC+4h8X5qb34t9c9\n3DHMRHp+CZTptYFCil0lZee/zulRfz7ZnGPCibg1iCf1qPoQJmZTOiv5lX6NNmJZ\nOBvYLXPizudtvdjDiWLCZ5nBEluWZJKc6rum3vb6THRE0EsH4x8tDydDASwzHtdV\nTnEOyRj31AEW/Q25AzGkRY0avGbQfCkrK8Ntpo1BUyhwtxO0rFwcAinr8oxV6GlX\ncCntthJGlpPBNuY7UCNBZopqey1cx9lU8NAfs8HKJ4NVlYqPtsymmEsYgFi14RB2\nO0J6bKlBuwoN6O3j3bjPQotsp3lCNzK/uwwiWNgrbUY4Cr0C2yH8OiwwZYrComU2\nNqQj3DS4vpUvWw50IycwaUWqor16wef+gP3XcZGtJLIv1WOv1ydbzS1H1bsaq535\nctFzVeyQYBGImPRUvCBLIbSgOVfy6IYOr0nHnkOhQxD3hXE9z0PAmovQu9m78u5t\nSlRfbSJxNqV3otRBUYps\n-----END CERTIFICATE-----\n" | tee /registry/SBKSServiceCA-chain.pem > /usr/local/share/ca-certificates/SBKSServiceCA-chain.crt  && /usr/sbin/update-ca-certificates

VOLUME ["/var/lib/registry"]
EXPOSE 5000
ENTRYPOINT ["registry"]
CMD ["/etc/docker/registry/config.yml"]
