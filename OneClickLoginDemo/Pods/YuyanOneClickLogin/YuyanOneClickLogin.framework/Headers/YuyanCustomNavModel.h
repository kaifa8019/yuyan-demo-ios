//
//  YuyanCustomNavModel.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/10/14.
//  Copyright © 2019 艾狄墨搏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuyanCustomNavModel : NSObject

/// 导航栏是否隐藏
@property (nonatomic, assign) BOOL isHidden;

/// 导航栏主题色, 默认[UIColor whiteColor]
@property (nonatomic, strong) UIColor *color;

/// 导航栏标题，内容、字体、大小、颜色
@property (nonatomic, copy) NSAttributedString *title;

/// 导航栏返回图片
@property (nonatomic, strong) UIImage *backImage;

/// 是否隐藏授权页导航栏返回按钮，默认不隐藏
@property (nonatomic, assign) BOOL hideBackItem;

/// 导航栏右侧自定义控件，可以在创建该VIEW的时候添加手势操作，或者创建按钮或其他赋值给VIEW
@property (nonatomic, strong) UIView *moreView;

/// 构建导航栏返回按钮的frame，view布局或布局发生变化时调用，不实现则按默认处理
@property (nonatomic, copy) CGRect(^backButtonFrameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);
/// 构建导航栏标题的frame，view布局或布局发生变化时调用，不实现则按默认处理
@property (nonatomic, copy) CGRect(^titleFrameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);
/// 构建导航栏右侧more view的frame，view布局或布局发生变化时调用，不实现则按默认处理
@property (nonatomic, copy) CGRect(^moreViewFrameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);

@end

NS_ASSUME_NONNULL_END
