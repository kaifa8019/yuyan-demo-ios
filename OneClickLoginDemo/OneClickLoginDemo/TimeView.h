//
//  TimeView.h
//  OneClickLoginDemo
//
//  Created by 白粿 on 2019/8/14.
//  Copyright © 2019 Yuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeView : UIView
@property (nonatomic, weak) UIView *tsView;
@property (nonatomic, copy) NSString *loginStr;

@property (nonatomic, assign) double startTime;
@end

NS_ASSUME_NONNULL_END
