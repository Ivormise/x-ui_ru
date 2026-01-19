#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

cur_dir=$(pwd)

# Language selection
select_language() {
    echo -e "Please select a language / 请选择语言 / Пожалуйста, выберите язык:"
    echo -e "1. English"
    echo -e "2. 简体中文 (Simplified Chinese)"
    echo -e "3. Русский (Russian)"
    read -p "(default: English): " language_choice
    case $language_choice in
        2)
            LANG="zh"
            ;;
        3)
            LANG="ru"
            ;;
        *)
            LANG="en"
            ;;
    esac
}

# Define messages based on language
set_messages() {
    if [[ "$LANG" == "zh" ]]; then
        MSG_ERROR="${red}错误：${plain}"
        MSG_ROOT_REQUIRED="必须使用root用户运行此脚本！"
        MSG_NO_OS="未检测到系统版本，请联系脚本作者！"
        MSG_ARCH_FAIL="检测架构失败，使用默认架构: "
        MSG_ARCH="架构: "
        MSG_NO_32BIT="本软件不支持 32 位系统(x86)，请使用 64 位系统(x86_64)，如果检测有误，请联系作者"
        MSG_CENTOS_VER="请使用 CentOS 7 或更高版本的系统！"
        MSG_UBUNTU_VER="请使用 Ubuntu 16 或更高版本的系统！"
        MSG_DEBIAN_VER="请使用 Debian 8 或更高版本的系统！"
        MSG_SECURITY_CONFIG="${yellow}出于安全考虑，安装/更新完成后需要强制修改端口与账户密码${plain}"
        MSG_CONFIRM_CONTINUE="确认是否继续?[y/n]: "
        MSG_SET_USER="请设置您的账户名:"
        MSG_USER_SET_TO="${yellow}您的账户名将设定为:${plain}"
        MSG_SET_PWD="请设置您的账户密码:"
        MSG_PWD_SET_TO="${yellow}您的账户密码将设定为:${plain}"
        MSG_SET_PORT="请设置面板访问端口:"
        MSG_PORT_SET_TO="${yellow}您的面板访问端口将设定为:${plain}"
        MSG_CONFIGURING="${yellow}确认设定,设定中${plain}"
        MSG_USER_PWD_DONE="${yellow}账户密码设定完成${plain}"
        MSG_PORT_DONE="${yellow}面板端口设定完成${plain}"
        MSG_CANCELLED="${red}已取消,所有设置项均为默认设置,请及时修改${plain}"
        MSG_CHECK_VER_FAIL="${red}检测 x-ui 版本失败，可能是超出 Github API 限制，请稍后再试，或手动指定 x-ui 版本安装${plain}"
        MSG_DETECTED_VER="检测到 x-ui 最新版本："
        MSG_START_INSTALL="，开始安装"
        MSG_DOWNLOAD_FAIL="${red}下载 x-ui 失败，请确保你的服务器能够下载 Github 的文件${plain}"
        MSG_INSTALL_VER="开始安装 x-ui v"
        MSG_DOWNLOAD_VER_FAIL="${red}下载 x-ui v"
        MSG_DOWNLOAD_VER_FAIL_SUFFIX=" 失败，请确保此版本存在${plain}"
        MSG_INSTALL_DONE="${green}x-ui v"
        MSG_INSTALL_DONE_SUFFIX="${plain} 安装完成，面板已启动，"
        MSG_USAGE="x-ui 管理脚本使用方法: "
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
        MSG_STARTING_INSTALL="${green}开始安装${plain}"
    elif [[ "$LANG" == "ru" ]]; then
        MSG_ERROR="${red}Ошибка: ${plain}"
        MSG_ROOT_REQUIRED="Этот скрипт должен быть запущен от имени root!"
        MSG_NO_OS="Версия ОС не обнаружена, пожалуйста, свяжитесь с автором!"
        MSG_ARCH_FAIL="Не удалось определить архитектуру, используется по умолчанию: "
        MSG_ARCH="Архитектура: "
        MSG_NO_32BIT="Это программное обеспечение не поддерживает 32-битные системы (x86), пожалуйста, используйте 64-битную систему (x86_64). Если это ошибка, свяжитесь с автором."
        MSG_CENTOS_VER="Пожалуйста, используйте CentOS 7 или выше!"
        MSG_UBUNTU_VER="Пожалуйста, используйте Ubuntu 16 или выше!"
        MSG_DEBIAN_VER="Пожалуйста, используйте Debian 8 или выше!"
        MSG_SECURITY_CONFIG="${yellow}В целях безопасности после установки/обновления необходимо изменить порт и пароль учетной записи${plain}"
        MSG_CONFIRM_CONTINUE="Продолжить? [y/n]: "
        MSG_SET_USER="Пожалуйста, установите имя пользователя:"
        MSG_USER_SET_TO="${yellow}Ваше имя пользователя будет установлено как:${plain}"
        MSG_SET_PWD="Пожалуйста, установите пароль:"
        MSG_PWD_SET_TO="${yellow}Ваш пароль будет установлен как:${plain}"
        MSG_SET_PORT="Пожалуйста, установите порт панели:"
        MSG_PORT_SET_TO="${yellow}Ваш порт панели будет установлен как:${plain}"
        MSG_CONFIGURING="${yellow}Подтверждение настроек, настройка...${plain}"
        MSG_USER_PWD_DONE="${yellow}Имя пользователя и пароль установлены${plain}"
        MSG_PORT_DONE="${yellow}Порт панели установлен${plain}"
        MSG_CANCELLED="${red}Отменено, все настройки по умолчанию, пожалуйста, измените их вовремя${plain}"
        MSG_CHECK_VER_FAIL="${red}Не удалось проверить версию x-ui, возможно превышен лимит Github API, попробуйте позже или укажите версию вручную${plain}"
        MSG_DETECTED_VER="Обнаружена последняя версия x-ui: "
        MSG_START_INSTALL=", начало установки"
        MSG_DOWNLOAD_FAIL="${red}Не удалось скачать x-ui, убедитесь, что ваш сервер может скачивать файлы с Github${plain}"
        MSG_INSTALL_VER="Начало установки x-ui v"
        MSG_DOWNLOAD_VER_FAIL="${red}Скачивание x-ui v"
        MSG_DOWNLOAD_VER_FAIL_SUFFIX=" не удалось, убедитесь, что эта версия существует${plain}"
        MSG_INSTALL_DONE="${green}x-ui v"
        MSG_INSTALL_DONE_SUFFIX="${plain} установка завершена, панель запущена,"
        MSG_USAGE="Как использовать скрипт управления x-ui: "
        MSG_USAGE_MENU="x-ui              - Показать меню управления (больше функций)"
        MSG_USAGE_START="x-ui start        - Запустить панель x-ui"
        MSG_USAGE_STOP="x-ui stop         - Остановить панель x-ui"
        MSG_USAGE_RESTART="x-ui restart      - Перезапустить панель x-ui"
        MSG_USAGE_STATUS="x-ui status       - Проверить статус x-ui"
        MSG_USAGE_ENABLE="x-ui enable       - Включить автозапуск x-ui"
        MSG_USAGE_DISABLE="x-ui disable      - Отключить автозапуск x-ui"
        MSG_USAGE_LOG="x-ui log          - Просмотреть логи x-ui"
        MSG_USAGE_V2UI="x-ui v2-ui        - Перенести данные аккаунта v2-ui на x-ui"
        MSG_USAGE_UPDATE="x-ui update       - Обновить панель x-ui"
        MSG_USAGE_INSTALL="x-ui install      - Установить панель x-ui"
        MSG_USAGE_UNINSTALL="x-ui uninstall    - Удалить панель x-ui"
        MSG_STARTING_INSTALL="${green}Начало установки${plain}"
    else
        # English Default
        MSG_ERROR="${red}Error: ${plain}"
        MSG_ROOT_REQUIRED="This script must be run as root!"
        MSG_NO_OS="OS version not detected, please contact the author!"
        MSG_ARCH_FAIL="Architecture detection failed, using default: "
        MSG_ARCH="Architecture: "
        MSG_NO_32BIT="This software does not support 32-bit systems (x86), please use a 64-bit system (x86_64). If this is an error, please contact the author."
        MSG_CENTOS_VER="Please use CentOS 7 or higher!"
        MSG_UBUNTU_VER="Please use Ubuntu 16 or higher!"
        MSG_DEBIAN_VER="Please use Debian 8 or higher!"
        MSG_SECURITY_CONFIG="${yellow}For security reasons, you must modify the port and account password after installation/update${plain}"
        MSG_CONFIRM_CONTINUE="Confirm to continue? [y/n]: "
        MSG_SET_USER="Please set your username:"
        MSG_USER_SET_TO="${yellow}Your username will be set to:${plain}"
        MSG_SET_PWD="Please set your password:"
        MSG_PWD_SET_TO="${yellow}Your password will be set to:${plain}"
        MSG_SET_PORT="Please set the panel port:"
        MSG_PORT_SET_TO="${yellow}Your panel port will be set to:${plain}"
        MSG_CONFIGURING="${yellow}Confirming settings, configuring...${plain}"
        MSG_USER_PWD_DONE="${yellow}Username and password set${plain}"
        MSG_PORT_DONE="${yellow}Panel port set${plain}"
        MSG_CANCELLED="${red}Cancelled, all settings are default, please modify them in time${plain}"
        MSG_CHECK_VER_FAIL="${red}Failed to check x-ui version, possibly exceeding Github API limit, please try again later or specify x-ui version manually${plain}"
        MSG_DETECTED_VER="Detected latest x-ui version: "
        MSG_START_INSTALL=", starting installation"
        MSG_DOWNLOAD_FAIL="${red}Failed to download x-ui, please ensure your server can download files from Github${plain}"
        MSG_INSTALL_VER="Starting installation of x-ui v"
        MSG_DOWNLOAD_VER_FAIL="${red}Download x-ui v"
        MSG_DOWNLOAD_VER_FAIL_SUFFIX=" failed, please ensure this version exists${plain}"
        MSG_INSTALL_DONE="${green}x-ui v"
        MSG_INSTALL_DONE_SUFFIX="${plain} installation completed, panel started,"
        MSG_USAGE="x-ui management script usage: "
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
        MSG_STARTING_INSTALL="${green}Starting installation${plain}"
    fi
}

select_language
set_messages

# check root
[[ $EUID -ne 0 ]] && echo -e "${MSG_ERROR} ${MSG_ROOT_REQUIRED}\n" && exit 1

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

arch=$(arch)

if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
    arch="amd64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
    arch="arm64"
elif [[ $arch == "s390x" ]]; then
    arch="s390x"
else
    arch="amd64"
    echo -e "${red}${MSG_ARCH_FAIL} ${arch}${plain}"
fi

echo "${MSG_ARCH} ${arch}"

if [ $(getconf WORD_BIT) != '32' ] && [ $(getconf LONG_BIT) != '64' ]; then
    echo "${MSG_NO_32BIT}"
    exit -1
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

install_base() {
    if [[ x"${release}" == x"centos" ]]; then
        yum install wget curl tar -y
    else
        apt install wget curl tar -y
    fi
}

#This function will be called when user installed x-ui out of sercurity
config_after_install() {
    echo -e "${MSG_SECURITY_CONFIG}"
    read -p "${MSG_CONFIRM_CONTINUE}": config_confirm
    if [[ x"${config_confirm}" == x"y" || x"${config_confirm}" == x"Y" ]]; then
        read -p "${MSG_SET_USER}" config_account
        echo -e "${MSG_USER_SET_TO} ${config_account}${plain}"
        read -p "${MSG_SET_PWD}" config_password
        echo -e "${MSG_PWD_SET_TO} ${config_password}${plain}"
        read -p "${MSG_SET_PORT}" config_port
        echo -e "${MSG_PORT_SET_TO} ${config_port}${plain}"
        echo -e "${MSG_CONFIGURING}"
        /usr/local/x-ui/x-ui setting -username ${config_account} -password ${config_password}
        echo -e "${MSG_USER_PWD_DONE}"
        /usr/local/x-ui/x-ui setting -port ${config_port}
        echo -e "${MSG_PORT_DONE}"
    else
        echo -e "${MSG_CANCELLED}"
    fi
}

install_x-ui() {
    systemctl stop x-ui
    cd /usr/local/

    if [ $# == 0 ]; then
        last_version=$(curl -Ls "https://api.github.com/repos/Ivormise/x-ui_ru/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
        if [[ ! -n "$last_version" ]]; then
            echo -e "${MSG_CHECK_VER_FAIL}"
            exit 1
        fi
        echo -e "${MSG_DETECTED_VER}${last_version}${MSG_START_INSTALL}"
        wget -N --no-check-certificate -O /usr/local/x-ui-linux-${arch}.tar.gz https://github.com/Ivormise/x-ui_ru/releases/download/${last_version}/x-ui-linux-${arch}.tar.gz
        if [[ $? -ne 0 ]]; then
            echo -e "${MSG_DOWNLOAD_FAIL}"
            exit 1
        fi
    else
        last_version=$1
        url="https://github.com/Ivormise/x-ui_ru/releases/download/${last_version}/x-ui-linux-${arch}.tar.gz"
        echo -e "${MSG_INSTALL_VER}$1"
        wget -N --no-check-certificate -O /usr/local/x-ui-linux-${arch}.tar.gz ${url}
        if [[ $? -ne 0 ]]; then
            echo -e "${MSG_DOWNLOAD_VER_FAIL}$1${MSG_DOWNLOAD_VER_FAIL_SUFFIX}"
            exit 1
        fi
    fi

    if [[ -e /usr/local/x-ui/ ]]; then
        rm /usr/local/x-ui/ -rf
    fi

    tar zxvf x-ui-linux-${arch}.tar.gz
    rm x-ui-linux-${arch}.tar.gz -f
    cd x-ui
    chmod +x x-ui bin/xray-linux-${arch}
    cp -f x-ui.service /etc/systemd/system/
    wget --no-check-certificate -O /usr/bin/x-ui https://raw.githubusercontent.com/Ivormise/x-ui_ru/main/x-ui.sh
    chmod +x /usr/local/x-ui/x-ui.sh
    chmod +x /usr/bin/x-ui
    config_after_install
    
    systemctl daemon-reload
    systemctl enable x-ui
    systemctl start x-ui
    echo -e "${MSG_INSTALL_DONE}${last_version}${MSG_INSTALL_DONE_SUFFIX}"
    echo -e ""
    echo -e "${MSG_USAGE}"
    echo -e "----------------------------------------------"
    echo -e "${MSG_USAGE_MENU}"
    echo -e "${MSG_USAGE_START}"
    echo -e "${MSG_USAGE_STOP}"
    echo -e "${MSG_USAGE_RESTART}"
    echo -e "${MSG_USAGE_STATUS}"
    echo -e "${MSG_USAGE_ENABLE}"
    echo -e "${MSG_USAGE_DISABLE}"
    echo -e "${MSG_USAGE_LOG}"
    echo -e "${MSG_USAGE_V2UI}"
    echo -e "${MSG_USAGE_UPDATE}"
    echo -e "${MSG_USAGE_INSTALL}"
    echo -e "${MSG_USAGE_UNINSTALL}"
    echo -e "----------------------------------------------"
}

echo -e "${MSG_STARTING_INSTALL}"
install_base
install_x-ui $1

