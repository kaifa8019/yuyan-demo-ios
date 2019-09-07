//
//  YuyanOneClickLoginConfig.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/8/6.
//  Copyright © 2019 Yuyan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YuyanOneClickLoginConfig : NSObject

+ (NSString *)getVersion NS_DEPRECATED_IOS(2_0,7_0, "请使用 [YuyanBaseConfig sdkVersion]");

@end

NS_ASSUME_NONNULL_END
