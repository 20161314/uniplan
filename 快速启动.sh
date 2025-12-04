#!/bin/bash

echo "🚀 启动开发服务器..."
npm run dev &
VITE_PID=$!

echo "⏳ 等待服务器启动..."
sleep 5

echo ""
echo "🌐 正在创建公网链接..."
echo "=========================================="
cloudflared tunnel --url http://localhost:5173
echo "=========================================="

# 清理
trap "kill $VITE_PID 2>/dev/null" EXIT

