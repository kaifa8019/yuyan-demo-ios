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

/// checkBox是否勾选，默认YES
@property (nonatomic, assign) BOOL isChecked;

/// 协议1，[协议名称,协议Url]
@property (nonatomic, copy) NSArray<NSString *> *privacyOne;

/// 协议2，[协议名称,协议Url]
@property (nonatomic, copy) NSArray<NSString *> *privacyTwo;

/// 协议内容颜色，[非点击文案颜色,协议颜色]
@property (nonatomic, copy) NSArray<UIColor *> *colors;

/// 协议相对全屏底部的Y轴距离！！！与其他有区别
@property (nonatomic, assign) CGFloat bottomOffetY;

/// 协议文案对其方式, 支持居中、居左设置，默认居左
@property (nonatomic, assign) NSTextAlignment alignment;

/// 协议文案 前缀
@property (nonatomic, copy) NSString *preText;

/// 协议文案 后缀
@property (nonatomic, copy) NSString *sufText;

/// 文案字体
@property (nonatomic, strong) UIFont *font;

@end

NS_ASSUME_NONNULL_END
