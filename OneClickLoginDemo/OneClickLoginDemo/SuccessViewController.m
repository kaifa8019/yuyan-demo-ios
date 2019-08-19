//
//  SuccessViewController.m
//  OneClickLoginDemo
//
//  Created by 白粿 on 2019/8/14.
//  Copyright © 2019 Yuyan. All rights reserved.
//

#import "SuccessViewController.h"
#import <Masonry/Masonry.h>
#import <YYText/YYText.h>

#define gapX 17

@interface SuccessViewController ()
@property (nonatomic, strong) UILabel *phoneLab;
@property (nonatomic, strong) UILabel *timeLab;
@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"一键登录/注册";
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    UIColor *topColor = [UIColor colorWithRed:97/255.0 green:161/255.0 blue:220/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = topColor;
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = topColor;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(196);
    }];
    
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 5;
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(-95);
        make.left.mas_equalTo(gapX);
        make.right.mas_equalTo(-gapX);
        make.height.mas_equalTo(172);
    }];
    
    _phoneLab = [[UILabel alloc] init];
    self.phoneLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.phoneLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [mainView addSubview:self.phoneLab];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    _timeLab = [[UILabel alloc] init];
    self.timeLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:30];
    self.timeLab.textColor = [UIColor colorWithRed:64/255.0 green:112/255.0 blue:242/255.0 alpha:1];
    [mainView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLab.mas_bottom).offset(9);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(42);
    }];
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    tipLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    tipLab.text = @"采用传统短信验证需要约30秒";
    [mainView addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab.mas_bottom).offset(1);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(17);
    }];
    
    UIButton *againBtn = [[UIButton alloc] init];
    againBtn.backgroundColor = self.timeLab.textColor;
    againBtn.layer.cornerRadius = 5;
    againBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [againBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [againBtn setTitle:@"再次体验" forState:UIControlStateNormal];
    [againBtn addTarget:self action:@selector(againBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:againBtn];
    [againBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-23);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(120, 32));
    }];
    
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    infoView.layer.cornerRadius = 5;
    [self.view addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainView.mas_bottom).offset(16);
        make.left.right.equalTo(mainView);
    }];
    
    UIFont *titleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    UIFont *txtFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    
    UIColor *titleColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    UIColor *txtColor = [UIColor colorWithRed:112/255.0 green:112/255.0 blue:112/255.0 alpha:1];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = titleFont;
    titleLab.textColor = titleColor;
    titleLab.text = @"产品优势";
    [infoView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(25);
    }];
    
    NSString *info = @"一键登录\n一键即可完成认证，是短信验证码的升级方案，校验更加安全、便捷、低时延\n\n全网支持\n支持国内三大运营商全网手机号码验证，一点接入，全国全网覆盖。\n\n便捷登录\nSDK简易接入，降低接入成本，支持应用开发者便捷调用。\n\n场景丰富\n适用于一切以手机号进行注册、登录、安全风控的场景，可实现用户无感校验。";
    NSArray *titles = @[@"一键登录", @"全网支持", @"便捷登录", @"场景丰富"];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:info];
    attStr.yy_font = txtFont;
    attStr.yy_color = txtColor;
    
    for (NSString *title in titles) {
        [attStr yy_setFont:titleFont range:[info rangeOfString:title]];
        [attStr yy_setColor:titleColor range:[info rangeOfString:title]];
    }
    
    UILabel *infoLab = [[UILabel alloc] init];
    infoLab.numberOfLines = 0;
    infoLab.attributedText = attStr;
    [infoView addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(46, gapX, 24, gapX));
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.phoneLab.text = [NSString stringWithFormat:@"本机登录号码为：%@", self.prePhone];
    self.timeLab.text = [NSString stringWithFormat:@"%g秒", self.preTime];
}

#pragma mark - Action
- (void)againBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
