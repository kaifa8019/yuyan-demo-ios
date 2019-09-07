//
//  YuyanNumberCheck.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/9/3.
//  Copyright © 2019 艾狄墨搏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuyanNumberCheck : NSObject

+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)alloc NS_UNAVAILABLE;
+ (instancetype)shareHandler;

/**
 * @brief  SDK初始化
 * @param  appID 初始化参数
 * @param  complete 结果回调（异步）
 */
- (void)prepareWithAppID:(NSString *)appID complete:(void(^)(NSError * _Nullable error))complete;

/**
 * @brief  获取本机号码校验token
 * @param  phone    需要进行校验的手机号码
 * @param  complete 结果回调（异步）
 */
- (void)getTokenWithPhone:(NSString *)phone complete:(void (^)(NSString *token, NSError * _Nullable error))complete;

/// 请使用 -getTokenWithPhone: timeout: complete:
- (void)getTokenWithPhone:(NSString *)phone Timeout:(NSTimeInterval )timeout complete:(void (^)(NSString *token, NSError * _Nullable error))complete NS_DEPRECATED_IOS(2_0,7_0, "请使用 -getTokenWithPhone: complete:");

@end

NS_ASSUME_NONNULL_END
