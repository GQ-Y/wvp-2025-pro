# 第一阶段：构建阶段
FROM ubuntu:20.04 AS build

# 设置 git 仓库地址
ARG gitUrl="https://github.com/648540858/wvp-GB28181-pro"

# 使用国内源加速
COPY sources.list /etc/apt/sources.list

# 安装构建依赖
RUN export DEBIAN_FRONTEND=noninteractive &&\
    apt-get update && \
    apt-get install -y --no-install-recommends \
        openjdk-11-jre \
        git \
        maven \
        nodejs \
        npm \
        build-essential

# 配置 maven 设置
COPY settings.xml /usr/share/maven/conf/

# 克隆特定版本的代码
RUN cd /home && \
    git clone "${gitUrl}" -b wvp-28181-2.0 && \
    cd wvp-GB28181-pro &&\
    git checkout 1909c7f71fc1b0e290678a3efe95b62d0b9df75e

# 构建前端
RUN cd /home/wvp-GB28181-pro/web_src && \
    npm --registry=http://registry.npm.taobao.org install && \
    npm run build && \
    rm -rf node_modules  # 删除不需要的依赖

# 构建后端
RUN cd /home/wvp-GB28181-pro && \
    mvn clean package -Dmaven.test.skip=true && \
    mkdir -p /opt/wvp/record && \
    mkdir -p /opt/wvp/ && \
    cp /home/wvp-GB28181-pro/target/*.jar /opt/wvp/

# 第二阶段：运行阶段
FROM ubuntu:20.04

# 设置中文环境
ENV LC_ALL zh_CN.UTF-8

# 安装运行依赖
RUN export DEBIAN_FRONTEND=noninteractive &&\
    apt-get update && \
    apt-get install -y --fix-missing --no-install-recommends \
        openjdk-11-jre \
        curl \
        ca-certificates \
        language-pack-zh-hans && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*dic

# 从构建阶段复制构建产物
COPY --from=build /opt /opt

# 设置工作目录
WORKDIR /config

# 启动命令
CMD ["sh", "run-wvp.sh"]
