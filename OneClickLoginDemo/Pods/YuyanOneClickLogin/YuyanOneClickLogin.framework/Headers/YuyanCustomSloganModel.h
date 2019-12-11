//
//  YuyanCustomSloganModel.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/12/10.
//  Copyright © 2019 艾狄墨搏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuyanCustomSloganModel : NSObject

/// slogan文案，内容、字体、大小、颜色
@property (nonatomic, copy) NSAttributedString *text;

/// slogan是否隐藏，默认NO
@property (nonatomic, assign) BOOL isHidden;

/// 构建slogan的frame，view布局或布局发生变化时调用，不实现则按默认处理
@property (nonatomic, copy) CGRect(^frameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);

@end

NS_ASSUME_NONNULL_END
