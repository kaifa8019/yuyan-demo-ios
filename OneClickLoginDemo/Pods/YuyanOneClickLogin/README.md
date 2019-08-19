# 雨燕 一键登录SDK



# 1.1 概述

系统支持: iOS 8.0 及以上版本

推荐使用`cocoapods`进行导入

一键登录的验证号码以`蜂窝移动数据`为准

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

# 2.1 一键登录请求初始化

YuyanOneClickLoginHandler

```
- (void)prepareWithAppID:(NSString *)appID complete:(void(^_Nullable)(NSError *error))complete
```

预请求初始化, 若当前环境可以进行一键登录则返回`error = nil`

# 2.2 获取一键登录token

```
- (void)getLoginTokenWithModel:(YuyanCustomModel *)model complete:(void(^)( NSString *token, NSError * _Nullable error))complete
```

开启登录页, 自定义样式在`YuyanCustomModel`中配置

成功获取token后, 需要调用对应VC的`dismissViewControllerAnimated`退出一键登录视图

error.code

 - 6669, 点击`使用其他登录方式`按钮, 需要手动管理dismiss
 - 6667, 点击了返回按钮, 自动dismiss
 - 其他状态码, 登录失败
