#!/bin/bash

# 启动 Vite 开发服务器（后台运行）
npm run dev &
VITE_PID=$!

# 等待服务器启动
sleep 3

# 启动 localtunnel，将本地 5173 端口暴露到公网
echo "正在创建公网链接..."
lt --port 5173 --subdomain uniplandemo 2>&1 | while IFS= read -r line; do
    echo "$line"
    if [[ "$line" == *"your url is"* ]] || [[ "$line" == *"https://"* ]]; then
        echo ""
        echo "=========================================="
        echo "✅ 公网访问地址已生成！"
        echo "=========================================="
        echo "$line" | grep -o 'https://[^ ]*' || echo "$line"
        echo ""
        echo "📱 将这个链接分享给任何人，他们都可以访问你的网站！"
        echo "=========================================="
        echo ""
    fi
done

# 清理：当脚本退出时，停止 Vite 服务器
trap "kill $VITE_PID 2>/dev/null" EXIT

# 保持脚本运行
wait $VITE_PID

