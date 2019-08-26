# 雨燕 一键登录SDK



# 1.1 概述

- 支持 iOS 8.0 及以上版本
- 支持`cocoapods`导入
- 支持 `电信 联通 移动`三大运营商
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

# 2.1 一键登录请求初始化

```
YuyanOneClickLoginHandler
```

```
- (void)prepareWithAppID:(NSString *)appID complete:(void(^_Nullable)(NSError *error))complete
```

返回值 | 说明
:---:|:---:
error == nil | 初始化成功
error != nil | 使用 error.localizedDescription 获取具体错误信息

登录成功后初始化将失效, 需要重新发起初始化方法

# 2.2 获取一键登录token

```
- (void)getLoginTokenWithModel:(YuyanCustomModel *)model complete:(void(^)( NSString *token, NSError * _Nullable error))complete
```

在调用方法前, 需要指定`YuyanOneClickLoginHandler`的`viewController`

登录页可以使用`YuyanCustomModel`配置自定义样式

非自动退出登录页的情况下需要在对应`VC`调用`dismissViewControllerAnimated`退出登录界面

返回值 | 自动退出 | 说明
:---:|:---:|:---:
error == nil | ❌ | 获取token成功
error.code == 6667 | ✅ | 点击导航栏返回按钮
error.code == 6669 | ❌ | 点击 `使用其他登录方式` 按钮
error.code == 4444 | ❌ | 运营商端发生异常
其他 | ❌ | 使用 error.localizedDescription 获取具体错误信息

# 3 登录页定制

![login](https://raw.githubusercontent.com/kaifa8019/yuyan-sdk-ios/master/info.png)

通过设置`YuyanCustomModel`相关属性即可定制登录页

# 3.1 导航栏

```
@property (nonatomic, strong) UIColor *navColor;
```

导航栏主题色, 默认[UIColor whiteColor]

```
@property (nonatomic, copy) NSAttributedString *navTitle;
```

导航栏标题，内容、字体、大小、颜色

```
@property (nonatomic, strong) UIImage *navBackImage;
```

导航栏返回图片

```
@property (nonatomic, strong) UIBarButtonItem *navMoreControl;
```

导航栏右侧自定义控件，UIBarButtonItem

# 3.2 logo图片

```
@property (nonatomic, strong) UIImage *logoImage;
```

logo图片

```
@property (nonatomic, assign) CGSize logoSize;
```

logo图片大小

```
@property (nonatomic, assign) BOOL logoIsHidden;
```

logo是否隐藏

```
@property (nonatomic, assign) CGFloat logoTopOffetY;
```

logo相对导航栏底部的Y轴距离

# 3.3 号码文案

```
@property (nonatomic, strong) UIColor *numberColor;
```

号码文案 颜色

```
@property (nonatomic, assign) CGFloat numberSize;
```

号码文案 大小

```
@property (nonatomic, assign) CGFloat numberTopOffetY;
```

number相对导航栏底部的Y轴距离

# 3.4 slogan文案

```
@property (nonatomic, copy) NSAttributedString *sloganText;
```

slogan文案，内容、字体、大小、颜色

```
@property (nonatomic, assign) BOOL sloganIsHidden;
```

slogan文案 是否隐藏

```
@property (nonatomic, assign) CGFloat sloganTopOffetY;
```

slogan文案 相对导航栏底部的Y轴距离

# 3.5 登录按钮

```
@property (nonatomic, strong) NSString *loginBtnTitle;
```

loginBtn标题

```
@property (nonatomic, strong) UIColor *loginBtnTitleColor;
```

loginBtn文本颜色

```
@property (nonatomic,strong) NSArray *loginBtnBgImgs;
```

loginBtn背景图片组，高度45.0pt，@[激活状态的图片,失效状态的图片,高亮状态的图片]

```
@property (nonatomic, assign) CGFloat loginBtnTopOffetY;
```

loginBtn相对导航栏底部的Y轴距离

# 3.6 切换到其他方式

```
@property (nonatomic, copy) NSAttributedString *changeBtnTitle;
```

changeBtn标题，内容、字体、大小、颜色

```
@property (nonatomic, assign) BOOL changeBtnIsHidden;
```

changeBtn是否隐藏

```
@property (nonatomic, assign) CGFloat changeBtnTopOffetY;
```

changeBtn相对导航栏底部的Y轴距离

# 3.7 自定义区域

```
@property (nonatomic,copy) void(^customViewBlock)(UIView *superCustomView);
```

`superCustomView`大小相当于`vc.view`

# 3.8 协议

```
@property (nonatomic, copy) NSArray<UIImage *> *checkBoxImages;
```

checkBox图片组，[uncheckedImg,checkedImg]

```
@property (nonatomic, assign) BOOL checkBoxIsChecked;
```

checkBox是否勾选，默认YES

```
@property (nonatomic, copy) NSArray<NSString *> *privacyOne;
```

协议1，[协议名称,协议Url]

```
@property (nonatomic, copy) NSArray<NSString *> *privacyTwo;
```

协议2，[协议名称,协议Url]

```
@property (nonatomic, copy) NSArray<UIColor *> *privacyColors;
```

协议内容颜色，[非点击文案颜色,协议颜色]

```
@property (nonatomic, assign) CGFloat privacyBottomOffetY;
```

协议相对全屏底部的Y轴距离！！！与其他有区别

# 4 常见问题

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