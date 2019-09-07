//
//  YuyanBaseConfig.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/9/6.
//  Copyright © 2019 艾狄墨搏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuyanBaseConfig : NSObject

/// SDK版本号
+ (NSString *)sdkVersion;

/// 获取全局超时时间, 单位秒(s), 默认3s
+ (NSTimeInterval)timeoutLimit;
/// 设置超时时间
+ (void)setTimeoutLimit:(NSTimeInterval)time;

@end

NS_ASSUME_NONNULL_END
