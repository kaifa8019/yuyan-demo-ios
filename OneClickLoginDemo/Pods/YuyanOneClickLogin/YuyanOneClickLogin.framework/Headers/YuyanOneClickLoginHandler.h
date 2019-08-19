//
//  YuyanOneClickLoginHandler.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/8/6.
//  Copyright © 2019 Yuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <YuyanOneClickLogin/YuyanCustomModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuyanOneClickLoginHandler : NSObject
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithViewController:(UIViewController *)vc NS_DESIGNATED_INITIALIZER;
@property (nonatomic, weak, readonly) UIViewController * viewController;

/**
 * @brief  初始化与预请求, 验证蜂窝数据网络, 勿频繁重复调用
 * @param  appID 初始化参数
 * @param  complete 结果回调（异步）
 */
- (void)prepareWithAppID:(NSString *)appID complete:(void(^_Nullable)(NSError *error))complete;

/*
 获取成功:
    token 授权字段, error = nil
    需要手动调用 dismissViewControllerAnimated 管理VC退出
 获取失败
    error.code == 6669, 使用其他登录方式, 手动管理dismiss
    error.code == 6667, 点击了返回按钮, 自动dismiss
    其他code, 获取token失败
 */
- (void)getLoginTokenWithModel:(YuyanCustomModel *)model complete:(void(^)( NSString *token, NSError * _Nullable error))complete;

@end

NS_ASSUME_NONNULL_END
