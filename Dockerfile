FROM alpine:3.20

# 安装基础依赖：Node.js、curl、unzip、ca-certificates
RUN apk add --no-cache nodejs curl unzip ca-certificates

# 下载并安装官方最新版 Xray-core
RUN curl -sL --retry 5 --retry-delay 3 --retry-all-errors -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/download/v25.10.15/Xray-linux-64.zip && \
    unzip -q /tmp/xray.zip xray -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm -f /tmp/xray.zip

WORKDIR /app

# 拷贝核心服务端脚本
COPY server.js /app/server.js

# 默认环境变量（均可在 Cloady 控制台通过 Environment Variables 覆盖）
ENV PORT=8080
ENV UUID=d342d11e-d424-4583-b36e-524ab1f0afa4
ENV WS_PATH=airport
ENV NODE_NAME=Cloady-Free-Node

EXPOSE 8080

CMD ["node", "server.js"]
