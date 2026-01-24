# X-ui (现代化与本地化)

支持多协议、多用户的 Xray 面板。
**现代化版本，包含完整本地化（俄语、英语、中文）、增强的安全性和优化的代码。**

## 功能特性

- **系统监控**: 服务器状态、资源使用情况。
- **多用户模式**: 支持多用户和多协议的视觉化管理。
- **支持协议**: VMess, VLESS, Trojan, Shadowsocks, Dokodemo-door, Socks, HTTP。
- **高级配置**: 传输配置、TLS、XTLS 等参数。
- **流量管理**: 统计、流量限制、账号过期设置。
- **配置模板**: 可自定义的 Xray 模板。
- **HTTPS 访问**: 支持通过 HTTPS 访问面板（自定义域名 + SSL）。
- **本地化**: 完整支持俄语、英语和中文。
- **Telegram 机器人**: 流量、登录和过期通知。
- **安全性**: 密码哈希 (bcrypt)，通知隐私设置。

## 安装与更新

### 自动安装 (Linux)

```bash
bash <(curl -Ls https://raw.githubusercontent.com/Ivormise/x-ui_ru/main/install.sh)
```
*注意：安装脚本支持语言选择。*

### 卸载

```bash
systemctl stop x-ui
systemctl disable x-ui
rm /etc/systemd/system/x-ui.service -f
systemctl daemon-reload
systemctl reset-failed
rm /etc/x-ui/ -rf
rm /usr/local/x-ui/ -rf
rm /usr/bin/x-ui -f
```

## Telegram 机器人

按照以下步骤设置通知：

1.  **创建机器人**: 在 Telegram 中找到 [@BotFather](https://t.me/BotFather)，创建一个新机器人并获取 **API Token**。
2.  **获取 Chat ID**: 找到 [@userinfobot](https://t.me/userinfobot) 或类似的机器人来获取您的 **Chat ID**。
3.  **配置面板**:
    - 进入“面板设置”。
    - 输入 **API Token** 和 **Chat ID**。
    - 设置通知计划（例如 `@daily` 或 `0 30 8 * * *` 表示上午 8:30）。
4.  **隐私**: 您可以在设置中禁用在通知中显示 IP 地址和主机名，以提高隐私性。

## 安全与性能

此版本包含重要的改进：
- **密码哈希**: 密码不再以明文存储。使用 `bcrypt`，并在首次登录时自动迁移。
- **IP 缓存**: 优化了服务器 IP 检测以减少系统负载。
- **数据库优化**: 减少了更新流量统计时的数据库写入。

## 系统要求

- CentOS 7+, Ubuntu 16+, Debian 8+
- **Go 1.22+** (用于从源码构建)

## 从 v2-ui 迁移

```bash
x-ui v2-ui
```
*迁移后，停止 v2-ui 并重启 x-ui。*

---
*原项目: [vaxilu/x-ui](https://github.com/vaxilu/x-ui)*
