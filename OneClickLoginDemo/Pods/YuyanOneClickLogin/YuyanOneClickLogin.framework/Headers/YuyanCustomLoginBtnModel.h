//
//  YuyanCustomLoginBtnModel.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/12/10.
//  Copyright © 2019 艾狄墨搏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuyanCustomLoginBtnModel : NSObject

/// 登陆按钮文案，内容、字体、大小、颜色
@property (nonatomic, strong) NSAttributedString *text;

/// 登录按钮背景图片组，默认高度50.0pt，@[激活状态的图片,失效状态的图片,高亮状态的图片]
@property (nonatomic, strong) NSArray<UIImage *> *bgImgs;

/**
 *  是否自动隐藏点击登录按钮之后授权页上转圈的 loading, 默认为YES，在获取登录Token成功后自动隐藏
 *  如果设置为 NO，需要自己手动调用 hideLoginLoading 隐藏
 */
@property (nonatomic, assign) BOOL autoHideLoginLoading;

/**
 *  构建登录按钮的frame，view布局或布局发生变化时调用，不实现则按默认处理
 *  注：不能超出父视图 content view，height不能小于40，width不能小于父视图宽度的一半
 */
@property (nonatomic, copy) CGRect(^frameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);

/// 手动隐藏一键登录获取登录Token之后的等待动画，默认为自动隐藏，当设置 autoHideLoginLoading = NO 时, 可调用该方法手动隐藏
- (void)hideLoginLoading;

@end

NS_ASSUME_NONNULL_END
