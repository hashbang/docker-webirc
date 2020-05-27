ARG ALPINE_VERSION=3.11
ARG ALPINE_DIGEST=sha256:9a839e63dad54c3a6d1834e29692c8492d93f90c59c978c1ed79109ea4fb9a54
ARG NGINX_VERSION=1.18.0-alpine
ARG NGINX_DIGEST=sha256:2668e65e1a36a749aa8b3a5297eee45504a4efea423ec2affcbbf85e31a9a571

FROM alpine:${ALPINE_VERSION}@${ALPINE_DIGEST} as builder
ARG KIWI_VERSION=1.5.1
ARG KIWI_SHA256SUM="620df0d4bb88e1f5fa3b6a5db7a5cc4fe873896ef63a2ff905adf4671a8346fc  v1.5.1.tar.gz"
RUN apk add npm && \
    wget https://github.com/kiwiirc/kiwiirc/archive/v${KIWI_VERSION}.tar.gz && \
    echo ${KIWI_SHA256SUM} | sha256sum v${KIWI_VERSION}.tar.gz && \
    tar -xzvf v${KIWI_VERSION}.tar.gz && \
    mv kiwiirc-${KIWI_VERSION} kiwiirc && \
    cd kiwiirc && \
    npm install && \
    npm run build

FROM nginx:${NGINX_VERSION}@${NGINX_DIGEST} as server
COPY --from=builder /kiwiirc/dist/ /usr/share/nginx/html/
COPY config.json /usr/share/nginx/html/static/
