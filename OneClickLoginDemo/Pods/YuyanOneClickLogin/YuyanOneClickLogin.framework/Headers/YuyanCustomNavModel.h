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

/// 导航栏主题色, 默认[UIColor whiteColor]
@property (nonatomic, strong) UIColor *color;

/// 导航栏标题，内容、字体、大小、颜色
@property (nonatomic, copy) NSAttributedString *title;

/// 导航栏返回图片
@property (nonatomic, strong) UIImage *backImage;

/// 导航栏右侧自定义控件，UIBarButtonItem
@property (nonatomic, strong, nullable) UIBarButtonItem *moreControl;

/// 是否隐藏授权页导航栏返回按钮，默认不隐藏
@property (nonatomic, assign) BOOL hideBackItem;

@end

NS_ASSUME_NONNULL_END
