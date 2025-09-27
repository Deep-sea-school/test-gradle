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

# 打印 SDK 目录下所有内容
list_sdk_contents() {
    # 获取 SDK 路径
    sdk_path=$(find_sdk_path)
    if [ $? -ne 0 ]; then
        exit 1
    fi

    # 检查路径是否有效
    if [ -d "$sdk_path" ]; then
        echo "正在列出 $sdk_path 下的所有内容："
        echo "----------------------------------------"
        # 使用 find 列出所有文件和目录（包括子目录）
        find "$sdk_path" -type f -o -type d | sort
    else
        echo "错误：SDK 路径 $sdk_path 无效"
        exit 1
    fi
}

# 执行操作
list_sdk_contents
