# 自定义Lint规则

## use_emit_synchronously

用于检测bloc中使用emit前，如果有异步操作，且没有添加isClosed判断的情况。此种情况下，emit会抛出异常。

## 使用方法

参考custom_lint[官方配置](https://pub.dev/packages/custom_lint)