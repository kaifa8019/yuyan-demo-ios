# 雨燕 一键登录SDK



# 1.1 概述

- 支持 iOS 9.0 及以上版本
- 支持`cocoapods`导入
- 支持 `电信 联通 移动`三大运营商
- 支持 `本机号码校验`
- 取号以`蜂窝移动数据`为准

# 1.2 工程环境配置

1. 打开项目的 app target，查看 Build Settings 中的 Linking-Other Linker Flags 选项，确保含有 -ObjC 一值， 若没有则添加。

2. 在项目的 app target 中，查看 Build Settings 中的 Build options - Enable Bitcode 选项， 设置为NO。 

3. info.plist 添加支持 Http访问字段

```obj-c
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```

# 1.3 采用cocoapods进行SDK的导入

```
pod 'YuyanOneClickLogin'
```

导入头文件

```
#import <YuyanOneClickLogin/YuyanOneClickLogin.h>
```

# 2. 主要功能

- [一键登录](https://github.com/kaifa8019/yuyan-sdk-ios/blob/master/Document/一键登录.md)
- [本机号码校验](https://github.com/kaifa8019/yuyan-sdk-ios/blob/master/Document/本机号码校验.md)

# 3. 通用属性

```
[YuyanBaseConfig sdkVersion]
```

获取SDK版本号

```
[YuyanBaseConfig timeoutLimit]
```

获取接口超时时间, 默认3s

```
[YuyanBaseConfig setTimeoutLimit:(NSTimeInterval)]
```

设置接口超时时间

# 4. 常见问题

### 移动卡返回【103101,错误的请求签名】

执行

```
[NSBundle mainBundle].localizedInfoDictionary
```
如果不为nil，则有国际本地化逻辑，这样的情况，目前有两种方法修复：

1. 如果.strings文件内容为空且无用，删除即可；
2. 如果.strings文件必须要使用，则需要在主工程中所有.strings文件中增加CFBundleIdentifier = "bundleId名称"；

### 一键登录服务一般只4G或者4G+Wifi情况下，如果是3G、2G会怎么样？

中国移动支持2G/3G/4G、中国联通支持3G/4G、中国电信支持4G，但2G和3G网络下接口请求失败或超时概率稍高。