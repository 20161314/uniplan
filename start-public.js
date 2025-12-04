import { spawn } from 'child_process';

console.log('🚀 正在启动开发服务器...\n');

// 启动 Vite 开发服务器
const vite = spawn('npm', ['run', 'dev'], {
  stdio: 'inherit',
  shell: true
});

// 等待 3 秒后启动 cloudflared
setTimeout(() => {
  console.log('\n🌐 正在创建公网链接...\n');
  
  const tunnel = spawn('cloudflared', ['tunnel', '--url', 'http://localhost:5173'], {
    stdio: 'inherit',
    shell: true
  });

  tunnel.on('error', (err) => {
    console.error('❌ 错误:', err.message);
    console.log('\n💡 提示：请确保 cloudflared 已安装');
  });

  // 清理
  process.on('SIGINT', () => {
    vite.kill();
    tunnel.kill();
    process.exit();
  });
}, 3000);

