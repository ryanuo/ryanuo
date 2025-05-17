#!/bin/bash

# 配置端口
PORT=11434
WEB_PORT=9790

# 启动Ollama服务
start_ollama() {
  echo "正在启动 Ollama..."
  ollama serve &
  OLLAMA_PID=$!
  echo "Ollama 进程ID: $OLLAMA_PID"
}

# 启动OpenWebUI
start_webui() {
  echo "正在启动 OpenWebUI..."
  open-webui serve --port "$WEB_PORT" &
  WEBUI_PID=$!
  echo "OpenWebUI 进程ID: $WEBUI_PID"
}

# 自动打开浏览器
open_browser() {
  echo "正在打开浏览器..."
  # 支持macOS/Windows/Linux通用格式
  case "$(uname -s)" in
    Darwin) open "http://localhost:$WEB_PORT" ;;
    Linux) xdg-open "http://localhost:$WEB_PORT" ;;
    Windows) start "http://localhost:$WEB_PORT" ;;
    *) echo "不支持的操作系统，无法自动打开浏览器" ;;
  esac
}

# 主流程
start_ollama
sleep 5  # 等待Ollama服务启动（根据模型大小可调整时间）
start_webui
sleep 5  # 等待WebUI启动
open_browser  # 自动打开浏览器

# 输出访问信息
echo -e "\nOllama 服务运行在：http://localhost:$PORT"
echo -e "OpenWebUI 运行在：\033[32mhttp://localhost:$WEB_PORT\033[0m"
echo "按 Ctrl+C 停止所有服务"

# 终止信号处理
trap "echo '停止服务...'; kill -9 $OLLAMA_PID $WEBUI_PID 2>/dev/null; wait; echo '服务已停止'." SIGINT SIGTERM

# 等待进程结束
wait