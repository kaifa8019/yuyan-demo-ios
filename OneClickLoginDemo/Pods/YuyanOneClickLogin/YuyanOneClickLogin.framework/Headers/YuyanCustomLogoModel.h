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

/// logo大小
@property (nonatomic, assign) CGSize size;

/// logo是否隐藏
@property (nonatomic, assign) BOOL isHidden;

/// logo相对导航栏底部的Y轴距离
@property (nonatomic, assign) CGFloat topOffetY;

@end

NS_ASSUME_NONNULL_END
