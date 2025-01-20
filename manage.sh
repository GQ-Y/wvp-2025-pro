#!/bin/bash

# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 服务列表
SERVICES=("redis" "mysql" "wvp" "zlm")

# 显示帮助信息
show_help() {
    echo -e "${YELLOW}WVP Docker 管理脚本${NC}"
    echo "用法: $0 [命令] [服务名]"
    echo
    echo "命令:"
    echo "  start    启动所有服务或指定服务"
    echo "  stop     停止所有服务或指定服务"
    echo "  restart  重启所有服务或指定服务"
    echo "  status   查看所有服务或指定服务状态"
    echo "  logs     查看指定服务日志"
    echo
    echo "服务名:"
    echo "  redis    Redis 服务"
    echo "  mysql    MySQL 服务"
    echo "  wvp      WVP 服务"
    echo "  zlm      ZLM 服务"
    echo
    echo "示例:"
    echo "  $0 start          # 启动所有服务"
    echo "  $0 stop wvp       # 停止 WVP 服务"
    echo "  $0 restart zlm    # 重启 ZLM 服务"
    echo "  $0 status         # 查看所有服务状态"
    echo "  $0 logs wvp       # 查看 WVP 服务日志"
}

# 检查服务名是否有效
check_service() {
    local service=$1
    for s in "${SERVICES[@]}"; do
        if [ "$s" == "$service" ]; then
            return 0
        fi
    done
    return 1
}

# 启动服务
start_service() {
    local service=$1
    if [ -z "$service" ]; then
        echo -e "${GREEN}启动所有服务...${NC}"
        docker-compose up -d
    else
        if check_service "$service"; then
            echo -e "${GREEN}启动 $service 服务...${NC}"
            docker-compose up -d "wvp_$service"
        else
            echo -e "${RED}错误: 无效的服务名 '$service'${NC}"
            return 1
        fi
    fi
}

# 停止服务
stop_service() {
    local service=$1
    if [ -z "$service" ]; then
        echo -e "${YELLOW}停止所有服务...${NC}"
        docker-compose down
    else
        if check_service "$service"; then
            echo -e "${YELLOW}停止 $service 服务...${NC}"
            docker-compose stop "wvp_$service"
        else
            echo -e "${RED}错误: 无效的服务名 '$service'${NC}"
            return 1
        fi
    fi
}

# 重启服务
restart_service() {
    local service=$1
    if [ -z "$service" ]; then
        echo -e "${YELLOW}重启所有服务...${NC}"
        docker-compose down
        docker-compose up -d
    else
        if check_service "$service"; then
            echo -e "${YELLOW}重启 $service 服务...${NC}"
            docker-compose restart "wvp_$service"
        else
            echo -e "${RED}错误: 无效的服务名 '$service'${NC}"
            return 1
        fi
    fi
}

# 查看服务状态
show_status() {
    local service=$1
    if [ -z "$service" ]; then
        echo -e "${GREEN}所有服务状态:${NC}"
        docker-compose ps
    else
        if check_service "$service"; then
            echo -e "${GREEN}$service 服务状态:${NC}"
            docker-compose ps "wvp_$service"
        else
            echo -e "${RED}错误: 无效的服务名 '$service'${NC}"
            return 1
        fi
    fi
}

# 查看服务日志
show_logs() {
    local service=$1
    if [ -z "$service" ]; then
        echo -e "${RED}错误: 请指定要查看日志的服务${NC}"
        return 1
    else
        if check_service "$service"; then
            echo -e "${GREEN}查看 $service 服务日志:${NC}"
            docker-compose logs -f "wvp_$service"
        else
            echo -e "${RED}错误: 无效的服务名 '$service'${NC}"
            return 1
        fi
    fi
}

# 主函数
main() {
    local command=$1
    local service=$2

    case $command in
        "start")
            start_service "$service"
            ;;
        "stop")
            stop_service "$service"
            ;;
        "restart")
            restart_service "$service"
            ;;
        "status")
            show_status "$service"
            ;;
        "logs")
            show_logs "$service"
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            echo -e "${RED}错误: 无效的命令 '$command'${NC}"
            show_help
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@" 