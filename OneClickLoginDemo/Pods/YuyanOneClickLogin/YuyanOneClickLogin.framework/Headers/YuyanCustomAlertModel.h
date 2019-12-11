//
//  YuyanCustomAlertModel.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/12/10.
//  Copyright © 2019 艾狄墨搏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuyanCustomAlertModel : NSObject

/// 底部蒙层背景颜色，默认黑色
@property (nonatomic, strong) UIColor *blurViewColor;

/// 底部蒙层背景透明度，默认0.5
@property (nonatomic, assign) CGFloat blurViewAlpha;

/// contentView的四个圆角值，顺序为左上，左下，右下，右上，需要填充4个值，不足4个值则无效，如果值<=0则为直角
@property (nonatomic, copy) NSArray<NSNumber *> *cornerRadiusArray;

/// 标题栏背景颜色
@property (nonatomic, strong) UIColor *titleBarColor;

/// 标题栏是否隐藏，默认NO
@property (nonatomic, assign) BOOL titleBarIsHidden;

/// 标题栏标题，内容、字体、大小、颜色
@property (nonatomic, copy) NSAttributedString *title;

/// 标题栏右侧关闭按钮图片设置
@property (nonatomic, strong) UIImage *closeImage;

/// 标题栏右侧关闭按钮是否显示，默认NO
@property (nonatomic, assign) BOOL closeItemIsHidden;

/// 构建标题栏的frame，view布局或布局发生变化时调用，不实现则按默认处理，实现时仅有height生效
@property (nonatomic, copy) CGRect(^titleBarFrameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);
/// 构建标题栏标题的frame，view布局或布局发生变化时调用，不实现则按默认处理
@property (nonatomic, copy) CGRect(^titleFrameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);
/// 构建标题栏右侧关闭按钮的frame，view布局或布局发生变化时调用，不实现则按默认处理
@property (nonatomic, copy) CGRect(^closeItemFrameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);
@end

NS_ASSUME_NONNULL_END
