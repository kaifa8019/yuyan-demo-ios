//
//  YuyanCustomLogoModel.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/10/22.
//  Copyright © 2019 艾狄墨搏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuyanCustomLogoModel : NSObject

/// logo图片
@property (nonatomic, strong, nullable) UIImage *image;

/// logo是否隐藏
@property (nonatomic, assign) BOOL isHidden;

/// 构建logo的frame，view布局或布局发生变化时调用，不实现则按默认处理
@property (nonatomic, copy) CGRect(^frameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);


@property (nonatomic, assign) CGSize size DEPRECATED_MSG_ATTRIBUTE("请使用 frameBlock");
@property (nonatomic, assign) CGFloat topOffetY DEPRECATED_MSG_ATTRIBUTE("请使用 frameBlock");

@end

NS_ASSUME_NONNULL_END
