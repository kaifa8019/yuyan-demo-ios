//
//  TimeView.m
//  OneClickLoginDemo
//
//  Created by 白粿 on 2019/8/14.
//  Copyright © 2019 Yuyan. All rights reserved.
//

#import "TimeView.h"

@implementation TimeView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.tsView) return nil;
    UIButton *btn = (UIButton *)[self.tsView.superview hitTest:point withEvent:event];
    if (![btn isKindOfClass:[UIButton class]]) return nil;
    if (![btn.currentTitle isEqualToString:self.loginStr]) return nil;
    
    self.startTime = [[NSDate date] timeIntervalSince1970];
    
    return nil;
}

@end
