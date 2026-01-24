#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

#Add some basic function here
function LOGD() {
    echo -e "${yellow}[DEG] $* ${plain}"
}

function LOGE() {
    echo -e "${red}[ERR] $* ${plain}"
}

function LOGI() {
    echo -e "${green}[INF] $* ${plain}"
}
# check root
[[ $EUID -ne 0 ]] && echo -e "${red}错误: 必须使用root用户运行此脚本!${plain}\n" && exit 1

LANG_FILE="/usr/local/x-ui/lang"

select_language() {
    echo -e "Please select a language / 请选择语言 / Пожалуйста, выберите язык:"
    echo -e "1. English"
    echo -e "2. 简体中文 (Simplified Chinese)"
    echo -e "3. Русский (Russian)"
    read -p "(default: English): " language_choice
    case $language_choice in
        2)
            echo "zh" > "$LANG_FILE"
            LANG="zh"
            ;;
        3)
            echo "ru" > "$LANG_FILE"
            LANG="ru"
            ;;
        *)
            echo "en" > "$LANG_FILE"
            LANG="en"
            ;;
    esac
    set_messages
}

set_messages() {
    if [[ -f "$LANG_FILE" ]]; then
        LANG=$(cat "$LANG_FILE")
    else
        LANG="en"
    fi

    if [[ "$LANG" == "zh" ]]; then
        MSG_ROOT_REQUIRED="错误: 必须使用root用户运行此脚本!"
        MSG_NO_OS="未检测到系统版本，请联系脚本作者！"
        MSG_CENTOS_VER="请使用 CentOS 7 或更高版本的系统！"
        MSG_UBUNTU_VER="请使用 Ubuntu 16 或更高版本的系统！"
        MSG_DEBIAN_VER="请使用 Debian 8 或更高版本的系统！"
        MSG_CONFIRM_RESTART="是否重启面板，重启面板也会重启 xray"
        MSG_PRESS_ENTER="按回车返回主菜单: "
        MSG_UPDATE_CONFIRM="本功能会强制重装当前最新版，数据不会丢失，是否继续?"
        MSG_CANCELLED="已取消"
        MSG_UPDATE_DONE="更新完成，已自动重启面板 "
        MSG_UNINSTALL_CONFIRM="确定要卸载面板吗,xray 也会卸载?"
        MSG_UNINSTALL_DONE="卸载成功，如果你想删除此脚本，则退出脚本后运行 ${green}rm /usr/bin/x-ui -f${plain} 进行删除"
        MSG_RESET_USER_CONFIRM="确定要将用户名和密码重置为 admin 吗"
        MSG_RESET_USER_DONE="用户名和密码已重置为 ${green}admin${plain}，现在请重启面板"
        MSG_RESET_CONFIG_CONFIRM="确定要重置所有面板设置吗，账号数据不会丢失，用户名和密码不会改变"
        MSG_RESET_CONFIG_DONE="所有面板设置已重置为默认值，现在请重启面板，并使用默认的 ${green}54321${plain} 端口访问面板"
        MSG_GET_SETTING_ERR="获取当前设置错误，请检查日志"
        MSG_INPUT_PORT="输入端口号[1-65535]: "
        MSG_SET_PORT_DONE="设置端口完毕，现在请重启面板，并使用新设置的端口 ${green}${port}${plain} 访问面板"
        MSG_ALREADY_RUNNING="面板已运行，无需再次启动，如需重启请选择重启"
        MSG_START_SUCCESS="x-ui 启动成功"
        MSG_START_FAIL="面板启动失败，可能是因为启动时间超过了两秒，请稍后查看日志信息"
        MSG_ALREADY_STOPPED="面板已停止，无需再次停止"
        MSG_STOP_SUCCESS="x-ui 与 xray 停止成功"
        MSG_STOP_FAIL="面板停止失败，可能是因为停止时间超过了两秒，请稍后查看日志信息"
        MSG_RESTART_SUCCESS="x-ui 与 xray 重启成功"
        MSG_RESTART_FAIL="面板重启失败，可能是因为启动时间超过了两秒，请稍后查看日志信息"
        MSG_ENABLE_SUCCESS="x-ui 设置开机自启成功"
        MSG_ENABLE_FAIL="x-ui 设置开机自启失败"
        MSG_DISABLE_SUCCESS="x-ui 取消开机自启成功"
        MSG_DISABLE_FAIL="x-ui 取消开机自启失败"
        MSG_DOWNLOAD_FAIL="下载脚本失败，请检查本机能否连接 Github"
        MSG_UPDATE_SHELL_SUCCESS="升级脚本成功，请重新运行脚本"
        MSG_ALREADY_INSTALLED="面板已安装，请不要重复安装"
        MSG_NOT_INSTALLED="请先安装面板"
        MSG_STATUS_RUNNING="面板状态: ${green}已运行${plain}"
        MSG_STATUS_NOT_RUNNING="面板状态: ${yellow}未运行${plain}"
        MSG_STATUS_NOT_INSTALLED="面板状态: ${red}未安装${plain}"
        MSG_ENABLE_YES="是否开机自启: ${green}是${plain}"
        MSG_ENABLE_NO="是否开机自启: ${red}否${plain}"
        MSG_XRAY_RUNNING="xray 状态: ${green}运行${plain}"
        MSG_XRAY_NOT_RUNNING="xray 状态: ${red}未运行${plain}"
        MSG_SSL_USAGE="******使用说明******"
        MSG_SSL_TIPS="该脚本将使用Acme脚本申请证书,使用时需保证:\n1.知晓Cloudflare 注册邮箱\n2.知晓Cloudflare Global API Key\n3.域名已通过Cloudflare进行解析到当前服务器\n4.该脚本申请证书默认安装路径为/root/cert目录"
        MSG_SSL_CONFIRM="我已确认以上内容"
        MSG_ACME_INSTALL="安装Acme脚本"
        MSG_ACME_FAIL="安装acme脚本失败"
        MSG_SET_DOMAIN="请设置域名:"
        MSG_INPUT_DOMAIN="Input your domain here:"
        MSG_DOMAIN_SET_TO="你的域名设置为:"
        MSG_SET_KEY="请设置API密钥:"
        MSG_INPUT_KEY="Input your key here:"
        MSG_KEY_SET_TO="你的API密钥为:"
        MSG_SET_EMAIL="请设置注册邮箱:"
        MSG_INPUT_EMAIL="Input your email here:"
        MSG_EMAIL_SET_TO="你的注册邮箱为:"
        MSG_CA_FAIL="修改默认CA为Lets'Encrypt失败,脚本退出"
        MSG_CERT_FAIL="证书签发失败,脚本退出"
        MSG_CERT_SUCCESS="证书签发成功,安装中..."
        MSG_CERT_INSTALL_FAIL="证书安装失败,脚本退出"
        MSG_CERT_INSTALL_SUCCESS="证书安装成功,开启自动更新..."
        MSG_AUTO_UP_FAIL="自动更新设置失败,脚本退出"
        MSG_CERT_DONE="证书已安装且已开启自动更新,具体信息如下"
        MSG_USAGE_TITLE="x-ui 管理脚本使用方法: "
        MSG_USAGE_MENU="x-ui              - 显示管理菜单 (功能更多)"
        MSG_USAGE_START="x-ui start        - 启动 x-ui 面板"
        MSG_USAGE_STOP="x-ui stop         - 停止 x-ui 面板"
        MSG_USAGE_RESTART="x-ui restart      - 重启 x-ui 面板"
        MSG_USAGE_STATUS="x-ui status       - 查看 x-ui 状态"
        MSG_USAGE_ENABLE="x-ui enable       - 设置 x-ui 开机自启"
        MSG_USAGE_DISABLE="x-ui disable      - 取消 x-ui 开机自启"
        MSG_USAGE_LOG="x-ui log          - 查看 x-ui 日志"
        MSG_USAGE_V2UI="x-ui v2-ui        - 迁移本机器的 v2-ui 账号数据至 x-ui"
        MSG_USAGE_UPDATE="x-ui update       - 更新 x-ui 面板"
        MSG_USAGE_INSTALL="x-ui install      - 安装 x-ui 面板"
        MSG_USAGE_UNINSTALL="x-ui uninstall    - 卸载 x-ui 面板"
        MSG_MENU_TITLE="x-ui 面板管理脚本"
        MSG_MENU_EXIT="退出脚本"
        MSG_MENU_INSTALL="安装 x-ui"
        MSG_MENU_UPDATE="更新 x-ui"
        MSG_MENU_UNINSTALL="卸载 x-ui"
        MSG_MENU_RESET_USER="重置用户名密码"
        MSG_MENU_RESET_CONFIG="重置面板设置"
        MSG_MENU_SET_PORT="设置面板端口"
        MSG_MENU_CHECK_CONFIG="查看当前面板设置"
        MSG_MENU_START="启动 x-ui"
        MSG_MENU_STOP="停止 x-ui"
        MSG_MENU_RESTART="重启 x-ui"
        MSG_MENU_STATUS="查看 x-ui 状态"
        MSG_MENU_LOG="查看 x-ui 日志"
        MSG_MENU_ENABLE="设置 x-ui 开机自启"
        MSG_MENU_DISABLE="取消 x-ui 开机自启"
        MSG_MENU_BBR="一键安装 bbr (最新内核)"
        MSG_MENU_SSL="一键申请SSL证书(acme申请)"
        MSG_MENU_LANG="切换语言 (Change Language)"
        MSG_INPUT_CHOICE="请输入选择"
        MSG_INVALID_CHOICE="请输入正确的数字"
    elif [[ "$LANG" == "ru" ]]; then
        MSG_ROOT_REQUIRED="Ошибка: Этот скрипт должен быть запущен от имени root!"
        MSG_NO_OS="Версия ОС не обнаружена, пожалуйста, свяжитесь с автором!"
        MSG_CENTOS_VER="Пожалуйста, используйте CentOS 7 или выше!"
        MSG_UBUNTU_VER="Пожалуйста, используйте Ubuntu 16 или выше!"
        MSG_DEBIAN_VER="Пожалуйста, используйте Debian 8 или выше!"
        MSG_CONFIRM_RESTART="Перезапустить панель? Это также перезапустит xray"
        MSG_PRESS_ENTER="Нажмите Enter, чтобы вернуться в главное меню: "
        MSG_UPDATE_CONFIRM="Эта функция принудительно переустановит последнюю версию. Данные не будут потеряны. Продолжить?"
        MSG_CANCELLED="Отменено"
        MSG_UPDATE_DONE="Обновление завершено, панель автоматически перезапущена "
        MSG_UNINSTALL_CONFIRM="Вы уверены, что хотите удалить панель? xray также будет удален."
        MSG_UNINSTALL_DONE="Удаление успешно. Если вы хотите удалить этот скрипт, выполните ${green}rm /usr/bin/x-ui -f${plain} после выхода."
        MSG_RESET_USER_CONFIRM="Вы уверены, что хотите сбросить имя пользователя и пароль на admin?"
        MSG_RESET_USER_DONE="Имя пользователя и пароль сброшены на ${green}admin${plain}, пожалуйста, перезапустите панель"
        MSG_RESET_CONFIG_CONFIRM="Вы уверены, что хотите сбросить все настройки панели? Данные аккаунтов не будут потеряны, имя пользователя и пароль не изменятся."
        MSG_RESET_CONFIG_DONE="Все настройки панели сброшены по умолчанию. Пожалуйста, перезапустите панель и используйте порт ${green}54321${plain} для доступа."
        MSG_GET_SETTING_ERR="Ошибка получения текущих настроек, проверьте логи"
        MSG_INPUT_PORT="Введите номер порта [1-65535]: "
        MSG_SET_PORT_DONE="Порт установлен. Пожалуйста, перезапустите панель и используйте новый порт ${green}${port}${plain} для доступа."
        MSG_ALREADY_RUNNING="Панель уже запущена, нет необходимости запускать ее снова. Используйте перезапуск, если нужно."
        MSG_START_SUCCESS="x-ui успешно запущен"
        MSG_START_FAIL="Ошибка запуска панели. Возможно, запуск занял более двух секунд, проверьте логи."
        MSG_ALREADY_STOPPED="Панель уже остановлена."
        MSG_STOP_SUCCESS="x-ui и xray успешно остановлены"
        MSG_STOP_FAIL="Ошибка остановки панели. Возможно, остановка заняла более двух секунд, проверьте логи."
        MSG_RESTART_SUCCESS="x-ui и xray успешно перезапущены"
        MSG_RESTART_FAIL="Ошибка перезапуска панели. Возможно, запуск занял более двух секунд, проверьте логи."
        MSG_ENABLE_SUCCESS="Автозапуск x-ui успешно включен"
        MSG_ENABLE_FAIL="Не удалось включить автозапуск x-ui"
        MSG_DISABLE_SUCCESS="Автозапуск x-ui успешно выключен"
        MSG_DISABLE_FAIL="Не удалось выключить автозапуск x-ui"
        MSG_DOWNLOAD_FAIL="Ошибка загрузки скрипта, проверьте подключение к GitHub"
        MSG_UPDATE_SHELL_SUCCESS="Скрипт успешно обновлен, пожалуйста, запустите его снова"
        MSG_ALREADY_INSTALLED="Панель уже установлена."
        MSG_NOT_INSTALLED="Пожалуйста, сначала установите панель"
        MSG_STATUS_RUNNING="Статус панели: ${green}Запущена${plain}"
        MSG_STATUS_NOT_RUNNING="Статус панели: ${yellow}Не запущена${plain}"
        MSG_STATUS_NOT_INSTALLED="Статус панели: ${red}Не установлена${plain}"
        MSG_ENABLE_YES="Автозапуск: ${green}Да${plain}"
        MSG_ENABLE_NO="Автозапуск: ${red}Нет${plain}"
        MSG_XRAY_RUNNING="Статус xray: ${green}Запущен${plain}"
        MSG_XRAY_NOT_RUNNING="Статус xray: ${red}Не запущен${plain}"
        MSG_SSL_USAGE="****** Инструкция ******"
        MSG_SSL_TIPS="Этот скрипт использует Acme для получения сертификата. Убедитесь, что:\n1. Вы знаете email регистрации Cloudflare\n2. Вы знаете Cloudflare Global API Key\n3. Домен направлен на этот сервер через Cloudflare\n4. Путь установки по умолчанию: /root/cert"
        MSG_SSL_CONFIRM="Я подтверждаю вышеуказанное"
        MSG_ACME_INSTALL="Установка скрипта Acme"
        MSG_ACME_FAIL="Ошибка установки скрипта acme"
        MSG_SET_DOMAIN="Установите домен:"
        MSG_INPUT_DOMAIN="Введите ваш домен здесь:"
        MSG_DOMAIN_SET_TO="Ваш домен установлен как:"
        MSG_SET_KEY="Установите API ключ:"
        MSG_INPUT_KEY="Введите ваш ключ здесь:"
        MSG_KEY_SET_TO="Ваш API ключ установлен как:"
        MSG_SET_EMAIL="Установите email регистрации:"
        MSG_INPUT_EMAIL="Введите ваш email здесь:"
        MSG_EMAIL_SET_TO="Ваш email установлен как:"
        MSG_CA_FAIL="Ошибка смены CA на Lets'Encrypt, выход"
        MSG_CERT_FAIL="Ошибка выпуска сертификата, выход"
        MSG_CERT_SUCCESS="Сертификат успешно выпущен, установка..."
        MSG_CERT_INSTALL_FAIL="Ошибка установки сертификата, выход"
        MSG_CERT_INSTALL_SUCCESS="Сертификат успешно установлен, автообновление включено..."
        MSG_AUTO_UP_FAIL="Ошибка настройки автообновления, выход"
        MSG_CERT_DONE="Сертификат установлен и настроен на автообновление, детали ниже"
        MSG_USAGE_TITLE="Использование скрипта управления x-ui: "
        MSG_USAGE_MENU="x-ui              - Показать меню управления (больше функций)"
        MSG_USAGE_START="x-ui start        - Запустить панель x-ui"
        MSG_USAGE_STOP="x-ui stop         - Остановить панель x-ui"
        MSG_USAGE_RESTART="x-ui restart      - Перезапустить панель x-ui"
        MSG_USAGE_STATUS="x-ui status       - Проверить статус x-ui"
        MSG_USAGE_ENABLE="x-ui enable       - Включить автозапуск x-ui"
        MSG_USAGE_DISABLE="x-ui disable      - Отключить автозапуск x-ui"
        MSG_USAGE_LOG="x-ui log          - Просмотреть логи x-ui"
        MSG_USAGE_V2UI="x-ui v2-ui        - Перенести данные v2-ui в x-ui"
        MSG_USAGE_UPDATE="x-ui update       - Обновить панель x-ui"
        MSG_USAGE_INSTALL="x-ui install      - Установить панель x-ui"
        MSG_USAGE_UNINSTALL="x-ui uninstall    - Удалить панель x-ui"
        MSG_MENU_TITLE="Скрипт управления панелью x-ui"
        MSG_MENU_EXIT="Выход"
        MSG_MENU_INSTALL="Установить x-ui"
        MSG_MENU_UPDATE="Обновить x-ui"
        MSG_MENU_UNINSTALL="Удалить x-ui"
        MSG_MENU_RESET_USER="Сбросить имя пользователя и пароль"
        MSG_MENU_RESET_CONFIG="Сбросить настройки панели"
        MSG_MENU_SET_PORT="Установить порт панели"
        MSG_MENU_CHECK_CONFIG="Просмотреть текущие настройки"
        MSG_MENU_START="Запустить x-ui"
        MSG_MENU_STOP="Остановить x-ui"
        MSG_MENU_RESTART="Перезапустить x-ui"
        MSG_MENU_STATUS="Проверить статус x-ui"
        MSG_MENU_LOG="Просмотреть логи x-ui"
        MSG_MENU_ENABLE="Включить автозапуск x-ui"
        MSG_MENU_DISABLE="Отключить автозапуск x-ui"
        MSG_MENU_BBR="Установить bbr (последнее ядро)"
        MSG_MENU_SSL="Получить SSL сертификат (через acme)"
        MSG_MENU_LANG="Сменить язык (Change Language)"
        MSG_INPUT_CHOICE="Выберите пункт"
        MSG_INVALID_CHOICE="Пожалуйста, введите правильное число"
    else
        # English Default
        MSG_ROOT_REQUIRED="Error: This script must be run as root!"
        MSG_NO_OS="OS version not detected, please contact the author!"
        MSG_CENTOS_VER="Please use CentOS 7 or higher!"
        MSG_UBUNTU_VER="Please use Ubuntu 16 or higher!"
        MSG_DEBIAN_VER="Please use Debian 8 or higher!"
        MSG_CONFIRM_RESTART="Restart the panel? This will also restart xray"
        MSG_PRESS_ENTER="Press Enter to return to the main menu: "
        MSG_UPDATE_CONFIRM="This function will force reinstall the latest version. Data will not be lost. Continue?"
        MSG_CANCELLED="Cancelled"
        MSG_UPDATE_DONE="Update completed, panel automatically restarted "
        MSG_UNINSTALL_CONFIRM="Are you sure you want to uninstall the panel? xray will also be uninstalled."
        MSG_UNINSTALL_DONE="Uninstall successful. If you want to delete this script, run ${green}rm /usr/bin/x-ui -f${plain} after exiting."
        MSG_RESET_USER_CONFIRM="Are you sure you want to reset the username and password to admin?"
        MSG_RESET_USER_DONE="Username and password reset to ${green}admin${plain}, please restart the panel"
        MSG_RESET_CONFIG_CONFIRM="Are you sure you want to reset all panel settings? Account data will not be lost, username and password will not change."
        MSG_RESET_CONFIG_DONE="All panel settings reset to default. Please restart the panel and use port ${green}54321${plain} for access."
        MSG_GET_SETTING_ERR="Error getting current settings, please check logs"
        MSG_INPUT_PORT="Enter port number [1-65535]: "
        MSG_SET_PORT_DONE="Port set. Please restart the panel and use the new port ${green}${port}${plain} for access."
        MSG_ALREADY_RUNNING="Panel is already running, no need to start again. Use restart if needed."
        MSG_START_SUCCESS="x-ui started successfully"
        MSG_START_FAIL="Panel start failed. It might have taken more than two seconds, please check the logs."
        MSG_ALREADY_STOPPED="Panel is already stopped."
        MSG_STOP_SUCCESS="x-ui and xray stopped successfully"
        MSG_STOP_FAIL="Panel stop failed. It might have taken more than two seconds, please check the logs."
        MSG_RESTART_SUCCESS="x-ui and xray restarted successfully"
        MSG_RESTART_FAIL="Panel restart failed. It might have taken more than two seconds, please check the logs."
        MSG_ENABLE_SUCCESS="x-ui set to start on boot successfully"
        MSG_ENABLE_FAIL="Failed to set x-ui to start on boot"
        MSG_DISABLE_SUCCESS="x-ui cancelled start on boot successfully"
        MSG_DISABLE_FAIL="Failed to cancel x-ui start on boot"
        MSG_DOWNLOAD_FAIL="Failed to download script, please check GitHub connectivity"
        MSG_UPDATE_SHELL_SUCCESS="Script updated successfully, please run it again"
        MSG_ALREADY_INSTALLED="Panel is already installed."
        MSG_NOT_INSTALLED="Please install the panel first"
        MSG_STATUS_RUNNING="Panel Status: ${green}Running${plain}"
        MSG_STATUS_NOT_RUNNING="Panel Status: ${yellow}Not Running${plain}"
        MSG_STATUS_NOT_INSTALLED="Panel Status: ${red}Not Installed${plain}"
        MSG_ENABLE_YES="Start on boot: ${green}Yes${plain}"
        MSG_ENABLE_NO="Start on boot: ${red}No${plain}"
        MSG_XRAY_RUNNING="xray Status: ${green}Running${plain}"
        MSG_XRAY_NOT_RUNNING="xray Status: ${red}Not Running${plain}"
        MSG_SSL_USAGE="****** Usage Instructions ******"
        MSG_SSL_TIPS="This script uses Acme to apply for a certificate. Ensure:\n1. You know the Cloudflare registration email\n2. You know the Cloudflare Global API Key\n3. Domain is pointed to this server via Cloudflare\n4. Default installation path is /root/cert"
        MSG_SSL_CONFIRM="I have confirmed the above"
        MSG_ACME_INSTALL="Installing Acme script"
        MSG_ACME_FAIL="Failed to install acme script"
        MSG_SET_DOMAIN="Set domain:"
        MSG_INPUT_DOMAIN="Input your domain here:"
        MSG_DOMAIN_SET_TO="Your domain is set to:"
        MSG_SET_KEY="Set API key:"
        MSG_INPUT_KEY="Input your key here:"
        MSG_KEY_SET_TO="Your API key is set to:"
        MSG_SET_EMAIL="Set registration email:"
        MSG_INPUT_EMAIL="Input your email here:"
        MSG_EMAIL_SET_TO="Your email is set to:"
        MSG_CA_FAIL="Failed to change default CA to Lets'Encrypt, exiting"
        MSG_CERT_FAIL="Certificate issuance failed, exiting"
        MSG_CERT_SUCCESS="Certificate issued successfully, installing..."
        MSG_CERT_INSTALL_FAIL="Certificate installation failed, exiting"
        MSG_CERT_INSTALL_SUCCESS="Certificate installed successfully, auto-update enabled..."
        MSG_AUTO_UP_FAIL="Auto-update setting failed, exiting"
        MSG_CERT_DONE="Certificate installed and auto-update enabled, details below"
        MSG_USAGE_TITLE="x-ui management script usage: "
        MSG_USAGE_MENU="x-ui              - Show management menu (more features)"
        MSG_USAGE_START="x-ui start        - Start x-ui panel"
        MSG_USAGE_STOP="x-ui stop         - Stop x-ui panel"
        MSG_USAGE_RESTART="x-ui restart      - Restart x-ui panel"
        MSG_USAGE_STATUS="x-ui status       - Check x-ui status"
        MSG_USAGE_ENABLE="x-ui enable       - Enable x-ui on boot"
        MSG_USAGE_DISABLE="x-ui disable      - Disable x-ui on boot"
        MSG_USAGE_LOG="x-ui log          - View x-ui logs"
        MSG_USAGE_V2UI="x-ui v2-ui        - Migrate v2-ui account data to x-ui"
        MSG_USAGE_UPDATE="x-ui update       - Update x-ui panel"
        MSG_USAGE_INSTALL="x-ui install      - Install x-ui panel"
        MSG_USAGE_UNINSTALL="x-ui uninstall    - Uninstall x-ui panel"
        MSG_MENU_TITLE="x-ui Panel Management Script"
        MSG_MENU_EXIT="Exit"
        MSG_MENU_INSTALL="Install x-ui"
        MSG_MENU_UPDATE="Update x-ui"
        MSG_MENU_UNINSTALL="Uninstall x-ui"
        MSG_MENU_RESET_USER="Reset Username/Password"
        MSG_MENU_RESET_CONFIG="Reset Panel Settings"
        MSG_MENU_SET_PORT="Set Panel Port"
        MSG_MENU_CHECK_CONFIG="View Current Settings"
        MSG_MENU_START="Start x-ui"
        MSG_MENU_STOP="Stop x-ui"
        MSG_MENU_RESTART="Restart x-ui"
        MSG_MENU_STATUS="Check x-ui Status"
        MSG_MENU_LOG="View x-ui Logs"
        MSG_MENU_ENABLE="Enable x-ui on Boot"
        MSG_MENU_DISABLE="Disable x-ui on Boot"
        MSG_MENU_BBR="Install BBR (Latest Kernel)"
        MSG_MENU_SSL="Get SSL Certificate (via acme)"
        MSG_MENU_LANG="Change Language"
        MSG_INPUT_CHOICE="Please enter choice"
        MSG_INVALID_CHOICE="Please enter a correct number"
    fi
}

set_messages

# check root
[[ $EUID -ne 0 ]] && echo -e "${red}${MSG_ROOT_REQUIRED}${plain}\n" && exit 1

# check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}${MSG_NO_OS}${plain}\n" && exit 1
fi

os_version=""

# os version
if [[ -f /etc/os-release ]]; then
    os_version=$(awk -F'[= ."]' '/VERSION_ID/{print $3}' /etc/os-release)
fi
if [[ -z "$os_version" && -f /etc/lsb-release ]]; then
    os_version=$(awk -F'[= ."]+' '/DISTRIB_RELEASE/{print $2}' /etc/lsb-release)
fi

if [[ x"${release}" == x"centos" ]]; then
    if [[ ${os_version} -le 6 ]]; then
        echo -e "${red}${MSG_CENTOS_VER}${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"ubuntu" ]]; then
    if [[ ${os_version} -lt 16 ]]; then
        echo -e "${red}${MSG_UBUNTU_VER}${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"debian" ]]; then
    if [[ ${os_version} -lt 8 ]]; then
        echo -e "${red}${MSG_DEBIAN_VER}${plain}\n" && exit 1
    fi
fi

confirm() {
    if [[ $# > 1 ]]; then
        echo && read -p "$1 [default $2]: " temp
        if [[ x"${temp}" == x"" ]]; then
            temp=$2
        fi
    else
        read -p "$1 [y/n]: " temp
    fi
    if [[ x"${temp}" == x"y" || x"${temp}" == x"Y" ]]; then
        return 0
    else
        return 1
    fi
}

confirm_restart() {
    confirm "${MSG_CONFIRM_RESTART}" "y"
    if [[ $? == 0 ]]; then
        restart
    else
        show_menu
    fi
}

before_show_menu() {
    echo && echo -n -e "${yellow}${MSG_PRESS_ENTER}${plain}" && read temp
    show_menu
}

install() {
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
    if [[ $? == 0 ]]; then
        if [[ $# == 0 ]]; then
            start
        else
            start 0
        fi
    fi
}

update() {
    confirm "${MSG_UPDATE_CONFIRM}" "n"
    if [[ $? != 0 ]]; then
        LOGE "${MSG_CANCELLED}"
        if [[ $# == 0 ]]; then
            before_show_menu
        fi
        return 0
    fi
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
    if [[ $? == 0 ]]; then
        LOGI "${MSG_UPDATE_DONE}"
        exit 0
    fi
}

uninstall() {
    confirm "${MSG_UNINSTALL_CONFIRM}" "n"
    if [[ $? != 0 ]]; then
        if [[ $# == 0 ]]; then
            show_menu
        fi
        return 0
    fi
    systemctl stop x-ui
    systemctl disable x-ui
    rm /etc/systemd/system/x-ui.service -f
    systemctl daemon-reload
    systemctl reset-failed
    rm /etc/x-ui/ -rf
    rm /usr/local/x-ui/ -rf

    echo ""
    echo -e "${MSG_UNINSTALL_DONE}"
    echo ""

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

reset_user() {
    confirm "${MSG_RESET_USER_CONFIRM}" "n"
    if [[ $? != 0 ]]; then
        if [[ $# == 0 ]]; then
            show_menu
        fi
        return 0
    fi
    /usr/local/x-ui/x-ui setting -username admin -password admin
    echo -e "${MSG_RESET_USER_DONE}"
    confirm_restart
}

reset_config() {
    confirm "${MSG_RESET_CONFIG_CONFIRM}" "n"
    if [[ $? != 0 ]]; then
        if [[ $# == 0 ]]; then
            show_menu
        fi
        return 0
    fi
    /usr/local/x-ui/x-ui setting -reset
    echo -e "${MSG_RESET_CONFIG_DONE}"
    confirm_restart
}

check_config() {
    info=$(/usr/local/x-ui/x-ui setting -show true)
    if [[ $? != 0 ]]; then
        LOGE "${MSG_GET_SETTING_ERR}"
        show_menu
    fi
    LOGI "${info}"
}

set_port() {
    echo && echo -n -e "${MSG_INPUT_PORT}" && read port
    if [[ -z "${port}" ]]; then
        LOGD "${MSG_CANCELLED}"
        before_show_menu
    else
        /usr/local/x-ui/x-ui setting -port ${port}
        echo -e "${MSG_SET_PORT_DONE}"
        confirm_restart
    fi
}

start() {
    check_status
    if [[ $? == 0 ]]; then
        echo ""
        LOGI "${MSG_ALREADY_RUNNING}"
    else
        systemctl start x-ui
        sleep 2
        check_status
        if [[ $? == 0 ]]; then
            LOGI "${MSG_START_SUCCESS}"
        else
            LOGE "${MSG_START_FAIL}"
        fi
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

stop() {
    check_status
    if [[ $? == 1 ]]; then
        echo ""
        LOGI "${MSG_ALREADY_STOPPED}"
    else
        systemctl stop x-ui
        sleep 2
        check_status
        if [[ $? == 1 ]]; then
            LOGI "${MSG_STOP_SUCCESS}"
        else
            LOGE "${MSG_STOP_FAIL}"
        fi
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

restart() {
    systemctl restart x-ui
    sleep 2
    check_status
    if [[ $? == 0 ]]; then
        LOGI "${MSG_RESTART_SUCCESS}"
    else
        LOGE "${MSG_RESTART_FAIL}"
    fi
    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

status() {
    systemctl status x-ui -l
    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

enable() {
    systemctl enable x-ui
    if [[ $? == 0 ]]; then
        LOGI "${MSG_ENABLE_SUCCESS}"
    else
        LOGE "${MSG_ENABLE_FAIL}"
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

disable() {
    systemctl disable x-ui
    if [[ $? == 0 ]]; then
        LOGI "${MSG_DISABLE_SUCCESS}"
    else
        LOGE "${MSG_DISABLE_FAIL}"
    fi

    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

show_log() {
    journalctl -u x-ui.service -e --no-pager -f
    if [[ $# == 0 ]]; then
        before_show_menu
    fi
}

migrate_v2_ui() {
    /usr/local/x-ui/x-ui v2-ui

    before_show_menu
}

install_bbr() {
    # temporary workaround for installing bbr
    bash <(curl -L -s https://raw.githubusercontent.com/teddysun/across/master/bbr.sh)
    echo ""
    before_show_menu
}

update_shell() {
    wget -O /usr/bin/x-ui -N --no-check-certificate https://github.com/vaxilu/x-ui/raw/master/x-ui.sh
    if [[ $? != 0 ]]; then
        echo ""
        LOGE "${MSG_DOWNLOAD_FAIL}"
        before_show_menu
    else
        chmod +x /usr/bin/x-ui
        LOGI "${MSG_UPDATE_SHELL_SUCCESS}" && exit 0
    fi
}

# 0: running, 1: not running, 2: not installed
check_status() {
    if [[ ! -f /etc/systemd/system/x-ui.service ]]; then
        return 2
    fi
    temp=$(systemctl status x-ui | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
    if [[ x"${temp}" == x"running" ]]; then
        return 0
    else
        return 1
    fi
}

check_enabled() {
    temp=$(systemctl is-enabled x-ui)
    if [[ x"${temp}" == x"enabled" ]]; then
        return 0
    else
        return 1
    fi
}

check_uninstall() {
    check_status
    if [[ $? != 2 ]]; then
        echo ""
        LOGE "${MSG_ALREADY_INSTALLED}"
        if [[ $# == 0 ]]; then
            before_show_menu
        fi
        return 1
    else
        return 0
    fi
}

check_install() {
    check_status
    if [[ $? == 2 ]]; then
        echo ""
        LOGE "${MSG_NOT_INSTALLED}"
        if [[ $# == 0 ]]; then
            before_show_menu
        fi
        return 1
    else
        return 0
    fi
}

show_status() {
    check_status
    case $? in
    0)
        echo -e "${MSG_STATUS_RUNNING}"
        show_enable_status
        ;;
    1)
        echo -e "${MSG_STATUS_NOT_RUNNING}"
        show_enable_status
        ;;
    2)
        echo -e "${MSG_STATUS_NOT_INSTALLED}"
        ;;
    esac
    show_xray_status
}

show_enable_status() {
    check_enabled
    if [[ $? == 0 ]]; then
        echo -e "${MSG_ENABLE_YES}"
    else
        echo -e "${MSG_ENABLE_NO}"
    fi
}

check_xray_status() {
    count=$(ps -ef | grep "xray-linux" | grep -v "grep" | wc -l)
    if [[ count -ne 0 ]]; then
        return 0
    else
        return 1
    fi
}

show_xray_status() {
    check_xray_status
    if [[ $? == 0 ]]; then
        echo -e "${MSG_XRAY_RUNNING}"
    else
        echo -e "${MSG_XRAY_NOT_RUNNING}"
    fi
}

ssl_cert_issue() {
    echo -E ""
    LOGD "${MSG_SSL_USAGE}"
    echo -e "${MSG_SSL_TIPS}"
    confirm "${MSG_SSL_CONFIRM} [y/n]" "y"
    if [ $? -eq 0 ]; then
        cd ~
        LOGI "${MSG_ACME_INSTALL}"
        curl https://get.acme.sh | sh
        if [ $? -ne 0 ]; then
            LOGE "${MSG_ACME_FAIL}"
            exit 1
        fi
        CF_Domain=""
        CF_GlobalKey=""
        CF_AccountEmail=""
        certPath=/root/cert
        if [ ! -d "$certPath" ]; then
            mkdir $certPath
        else
            rm -rf $certPath
            mkdir $certPath
        fi
        LOGD "${MSG_SET_DOMAIN}"
        read -p "${MSG_INPUT_DOMAIN}" CF_Domain
        LOGD "${MSG_DOMAIN_SET_TO}${CF_Domain}"
        LOGD "${MSG_SET_KEY}"
        read -p "${MSG_INPUT_KEY}" CF_GlobalKey
        LOGD "${MSG_KEY_SET_TO}${CF_GlobalKey}"
        LOGD "${MSG_SET_EMAIL}"
        read -p "${MSG_INPUT_EMAIL}" CF_AccountEmail
        LOGD "${MSG_EMAIL_SET_TO}${CF_AccountEmail}"
        ~/.acme.sh/acme.sh --set-default-ca --server letsencrypt
        if [ $? -ne 0 ]; then
            LOGE "${MSG_CA_FAIL}"
            exit 1
        fi
        export CF_Key="${CF_GlobalKey}"
        export CF_Email=${CF_AccountEmail}
        ~/.acme.sh/acme.sh --issue --dns dns_cf -d ${CF_Domain} -d *.${CF_Domain} --log
        if [ $? -ne 0 ]; then
            LOGE "${MSG_CERT_FAIL}"
            exit 1
        else
            LOGI "${MSG_CERT_SUCCESS}"
        fi
        ~/.acme.sh/acme.sh --installcert -d ${CF_Domain} -d *.${CF_Domain} --ca-file /root/cert/ca.cer \
        --cert-file /root/cert/${CF_Domain}.cer --key-file /root/cert/${CF_Domain}.key \
        --fullchain-file /root/cert/fullchain.cer
        if [ $? -ne 0 ]; then
            LOGE "${MSG_CERT_INSTALL_FAIL}"
            exit 1
        else
            LOGI "${MSG_CERT_INSTALL_SUCCESS}"
        fi
        ~/.acme.sh/acme.sh --upgrade --auto-upgrade
        if [ $? -ne 0 ]; then
            LOGE "${MSG_AUTO_UP_FAIL}"
            ls -lah cert
            chmod 755 $certPath
            exit 1
        else
            LOGI "${MSG_CERT_DONE}"
            ls -lah cert
            chmod 755 $certPath
        fi
    else
        show_menu
    fi
}

show_usage() {
    echo "${MSG_USAGE_TITLE}"
    echo "------------------------------------------"
    echo "${MSG_USAGE_MENU}"
    echo "${MSG_USAGE_START}"
    echo "${MSG_USAGE_STOP}"
    echo "${MSG_USAGE_RESTART}"
    echo "${MSG_USAGE_STATUS}"
    echo "${MSG_USAGE_ENABLE}"
    echo "${MSG_USAGE_DISABLE}"
    echo "${MSG_USAGE_LOG}"
    echo "${MSG_USAGE_V2UI}"
    echo "${MSG_USAGE_UPDATE}"
    echo "${MSG_USAGE_INSTALL}"
    echo "${MSG_USAGE_UNINSTALL}"
    echo "------------------------------------------"
}

show_menu() {
    echo -e "
  ${green}${MSG_MENU_TITLE}${plain}
  ${green}0.${plain} ${MSG_MENU_EXIT}
————————————————
  ${green}1.${plain} ${MSG_MENU_INSTALL}
  ${green}2.${plain} ${MSG_MENU_UPDATE}
  ${green}3.${plain} ${MSG_MENU_UNINSTALL}
————————————————
  ${green}4.${plain} ${MSG_MENU_RESET_USER}
  ${green}5.${plain} ${MSG_MENU_RESET_CONFIG}
  ${green}6.${plain} ${MSG_MENU_SET_PORT}
  ${green}7.${plain} ${MSG_MENU_CHECK_CONFIG}
————————————————
  ${green}8.${plain} ${MSG_MENU_START}
  ${green}9.${plain} ${MSG_MENU_STOP}
  ${green}10.${plain} ${MSG_MENU_RESTART}
  ${green}11.${plain} ${MSG_MENU_STATUS}
  ${green}12.${plain} ${MSG_MENU_LOG}
————————————————
  ${green}13.${plain} ${MSG_MENU_ENABLE}
  ${green}14.${plain} ${MSG_MENU_DISABLE}
————————————————
  ${green}15.${plain} ${MSG_MENU_BBR}
  ${green}16.${plain} ${MSG_MENU_SSL}
  ${green}17.${plain} ${MSG_MENU_LANG}
 "
    show_status
    echo && read -p "${MSG_INPUT_CHOICE} [0-17]: " num

    case "${num}" in
    0)
        exit 0
        ;;
    1)
        check_uninstall && install
        ;;
    2)
        check_install && update
        ;;
    3)
        check_install && uninstall
        ;;
    4)
        check_install && reset_user
        ;;
    5)
        check_install && reset_config
        ;;
    6)
        check_install && set_port
        ;;
    7)
        check_install && check_config
        ;;
    8)
        check_install && start
        ;;
    9)
        check_install && stop
        ;;
    10)
        check_install && restart
        ;;
    11)
        check_install && status
        ;;
    12)
        check_install && show_log
        ;;
    13)
        check_install && enable
        ;;
    14)
        check_install && disable
        ;;
    15)
        install_bbr
        ;;
    16)
        ssl_cert_issue
        ;;
    17)
        select_language
        ;;
    *)
        LOGE "${MSG_INVALID_CHOICE} [0-17]"
        ;;
    esac
}

if [[ $# > 0 ]]; then
    case $1 in
    "start")
        check_install 0 && start 0
        ;;
    "stop")
        check_install 0 && stop 0
        ;;
    "restart")
        check_install 0 && restart 0
        ;;
    "status")
        check_install 0 && status 0
        ;;
    "enable")
        check_install 0 && enable 0
        ;;
    "disable")
        check_install 0 && disable 0
        ;;
    "log")
        check_install 0 && show_log 0
        ;;
    "v2-ui")
        check_install 0 && migrate_v2_ui 0
        ;;
    "update")
        check_install 0 && update 0
        ;;
    "install")
        check_uninstall 0 && install 0
        ;;
    "uninstall")
        check_install 0 && uninstall 0
        ;;
    *) show_usage ;;
    esac
else
    show_menu
fi
