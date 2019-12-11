//
//  YuyanCustomAgreementModel.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/10/24.
//  Copyright © 2019 艾狄墨搏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuyanCustomAgreementModel : NSObject

/// checkBox图片组，[uncheckedImg,checkedImg]
@property (nonatomic, copy) NSArray<UIImage *> *images;

/// checkBox是否勾选，默认NO
@property (nonatomic, assign) BOOL isChecked;

/// checkBox是否隐藏，默认NO
@property (nonatomic, assign) BOOL checkBoxIsHidden;

/// checkBox大小，高宽一样，必须大于0
@property (nonatomic, assign) CGFloat checkBoxWH;

/// 协议1，[协议名称,协议Url]，注：两个协议名称不能相同
@property (nonatomic, copy) NSArray<NSString *> *privacyOne;

/// 协议2，[协议名称,协议Url]，注：两个协议名称不能相同
@property (nonatomic, copy) NSArray<NSString *> *privacyTwo;

/// 协议内容颜色数组，[非点击文案颜色，点击文案颜色]
@property (nonatomic, copy) NSArray<UIColor *> *colors;

/// 协议文案对其方式, 支持居中、居左设置，默认居左
@property (nonatomic, assign) NSTextAlignment alignment;

/// 协议文案 前缀
@property (nonatomic, copy) NSString *preText;

/// 协议文案 后缀
@property (nonatomic, copy) NSString *sufText;

/// 运营商协议名称前缀文案，仅支持 <([《（【『
@property (nonatomic, copy) NSString *operatorPreText;

/// 运营商协议名称后缀文案，仅支持 >)]》）】』
@property (nonatomic, copy) NSString *operatorSufText;

/// 文案字体
@property (nonatomic, strong) UIFont *font;

/**
 *  构建协议整体（包括checkBox）的frame，view布局或布局发生变化时调用，不实现则按默认处理
 *  如果设置的width小于checkBox的宽则不生效，最小x、y为0，最大width、height为父试图宽高
 *  最终会根据设置进来的width对协议文本进行自适应，得到的size是协议控件的最终大小
 */
@property (nonatomic, copy) CGRect(^frameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);

#pragma mark - 协议详情页
/// 导航栏背景颜色设置
@property (nonatomic, strong) UIColor *navColor;

/// 导航栏标题字体、大小
@property (nonatomic, strong) UIFont *navTitleFont;

/// 导航栏标题颜色
@property (nonatomic, strong) UIColor *navTitleColor;

/// 导航栏返回图片
@property (nonatomic, strong) UIImage *navBackImage;

@property (nonatomic, assign) CGFloat bottomOffetY DEPRECATED_MSG_ATTRIBUTE("请使用 .frameBlock");

@end

NS_ASSUME_NONNULL_END
