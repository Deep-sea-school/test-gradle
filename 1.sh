#!/bin/bash

# 检查常见的 Android SDK 路径
check_sdk_path() {
    # 通常的默认路径
    local paths=(
        "$HOME/Android/Sdk"                    # Linux 默认路径
        "$HOME/.android/sdk"                   # 可能的备用路径
        "/opt/android-sdk"                     # 系统级安装路径
        "/usr/local/android-sdk"               # 另一常见系统路径
    )

    for path in "${paths[@]}"; do
        if [ -d "$path" ]; then
            echo "Android SDK 找到: $path"
            return 0
        fi
    done

    # 如果没有找到 SDK，检查 ANDROID_HOME 环境变量
    if [ -n "$ANDROID_HOME" ] && [ -d "$ANDROID_HOME" ]; then
        echo "Android SDK 找到 (来自 ANDROID_HOME): $ANDROID_HOME"
        return 0
    fi

    echo "未找到 Android SDK，请检查是否已安装或配置 ANDROID_HOME 环境变量"
    return 1
}

# 执行检查
check_sdk_path
