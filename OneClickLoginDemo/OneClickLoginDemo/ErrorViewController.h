//
//  ErrorViewController.h
//  OneClickLoginDemo
//
//  Created by 白粿 on 2019/8/14.
//  Copyright © 2019 Yuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ErrorViewController : UIViewController
@property (nonatomic, assign) NSInteger preCode;
@property (nonatomic, copy) NSString *preMsg;

@end

NS_ASSUME_NONNULL_END
