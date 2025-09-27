#!/bin/bash

# 检查 Android SDK 路径
find_sdk_path() {
    local paths=(
        "$HOME/Android/Sdk"                    # Linux 默认路径
        "$HOME/.android/sdk"                   # 可能的备用路径
        "/opt/android-sdk"                     # 系统级安装路径
        "/usr/local/android-sdk"               # 另一常见系统路径
    )

    for path in "${paths[@]}"; do
        if [ -d "$path" ]; then
            echo "Android SDK 找到: $path"
            echo "$path"
            return 0
        fi
    done

    # 检查 ANDROID_HOME 环境变量
    if [ -n "$ANDROID_HOME" ] && [ -d "$ANDROID_HOME" ]; then
        echo "Android SDK 找到 (来自 ANDROID_HOME): $ANDROID_HOME"
        echo "$ANDROID_HOME"
        return 0
    fi

    echo "未找到 Android SDK，请检查是否已安装或配置 ANDROID_HOME 环境变量"
    return 1
}

# 使用 tree 命令打印 SDK 目录结构
list_sdk_contents_with_tree() {
    # 检查是否安装了 tree 命令
    if ! command -v tree &> /dev/null; then
        echo "错误：未安装 tree 命令。请先安装 tree（例如：sudo apt install tree 或 sudo dnf install tree）"
        sudo apt install tree
    fi

    # 获取 SDK 路径
    sdk_path=$(find_sdk_path)
    if [ $? -ne 0 ]; then
        exit 1
    fi

    # 检查路径是否有效
    if [ -d "$sdk_path" ]; then
        echo "正在以树状结构列出 $sdk_path 下的所有内容："
        echo "----------------------------------------"
        # 使用 tree 命令列出目录结构
        tree "$sdk_path" -a --noreport
    else
        echo "错误：SDK 路径 $sdk_path 无效"
        exit 1
    fi
}

# 执行操作
list_sdk_contents_with_tree
