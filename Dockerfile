FROM alpine as builder
ARG KIWI_VERSION=1.5.1
RUN apk add npm && \
    wget https://github.com/kiwiirc/kiwiirc/archive/v${KIWI_VERSION}.tar.gz && \
    tar -xzvf v${KIWI_VERSION}.tar.gz && \
    mv kiwiirc-${KIWI_VERSION} kiwiirc && \
    cd kiwiirc && \
    npm install && \
    npm run build

FROM nginx:stable-alpine as server
COPY --from=builder /kiwiirc/dist/ /usr/share/nginx/html/
COPY config.json /usr/share/nginx/html/static/

