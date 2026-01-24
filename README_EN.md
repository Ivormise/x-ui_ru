# X-ui (Modernized & Localized)

Control panel for Xray with support for multiple protocols and users.
**Modernized version with full localization (Russian, English, Chinese), enhanced security, and optimized code.**

## Features

- **System Monitoring**: Server status, resource usage.
- **Multi-user Mode**: Support for multiple users and protocols with visual management.
- **Supported Protocols**: VMess, VLESS, Trojan, Shadowsocks, Dokodemo-door, Socks, HTTP.
- **Advanced Configuration**: Transport, TLS, XTLS, and other parameters.
- **Traffic Management**: Statistics, traffic limits, account expiration.
- **Configuration Templates**: Customizable Xray templates.
- **HTTPS Access**: Support for panel access via HTTPS (custom domain + SSL).
- **Localization**: Full support for Russian, English, and Chinese.
- **Telegram Bot**: Notifications for traffic, panel login, and expiration.
- **Security**: Password hashing (bcrypt), privacy settings for notifications.

## Installation and Update

### Automatic Installation (Linux)

```bash
bash <(curl -Ls https://raw.githubusercontent.com/Ivormise/x-ui_ru/main/install.sh)
```
*Note: The installation script supports language selection.*

### Uninstallation

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

## Telegram Bot

Follow these steps to set up notifications:

1.  **Create a Bot**: Find [@BotFather](https://t.me/BotFather) on Telegram, create a new bot, and get the **API Token**.
2.  **Get Chat ID**: Find [@userinfobot](https://t.me/userinfobot) or a similar bot to find your **Chat ID**.
3.  **Configure the Panel**:
    - Go to "Panel Settings".
    - Enter the **API Token** and **Chat ID**.
    - Set the notification schedule (e.g., `@daily` or `0 30 8 * * *` for 8:30 AM).
4.  **Privacy**: You can disable showing the IP address and hostname in notifications in the settings for better privacy.

## Security and Performance

This version includes important improvements:
- **Password Hashing**: Passwords are no longer stored in plain text. `bcrypt` is used with automatic migration on the first login.
- **IP Caching**: Server IP detection is optimized to reduce system load.
- **DB Optimization**: Reduced database writes when updating traffic statistics.

## System Requirements

- CentOS 7+, Ubuntu 16+, Debian 8+
- **Go 1.22+** (for building from source)

## Migration from v2-ui

```bash
x-ui v2-ui
```
*After migration, stop v2-ui and restart x-ui.*

---
*Original project: [vaxilu/x-ui](https://github.com/vaxilu/x-ui)*
