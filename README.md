运行：
flutter run （默认为debug环境）
flutter run --release (以release模式运行)
帮助：flutter -h 或 flutter --help
诊断flutter：flutter doctor
查看flutter版本号：flutter --version
flutter升级：flutter upgrade
获取flutter packages包：flutter packages get
json序列化，自动监听命令（使用json_annotation、build_runner、json_serializable库的执行命令）：
flutter packages pub run build_runner watch
打包apk包：
64位-release：
flutter build apk --release --target-platform android-arm64
32位-release：
flutter build apk --release --target-platform android-arm
查看flutter当前版本：flutter channel
切换flutter版本的master：flutter channel master
