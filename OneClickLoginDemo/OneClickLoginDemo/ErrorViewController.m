//
//  ErrorViewController.m
//  OneClickLoginDemo
//
//  Created by 白粿 on 2019/8/14.
//  Copyright © 2019 Yuyan. All rights reserved.
//

#import "ErrorViewController.h"
#import <Masonry/Masonry.h>

#define gapX 16

@interface ErrorViewController ()

@end

@implementation ErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"一键登录/注册";
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    
    UIColor *topColor = [UIColor colorWithRed:97/255.0 green:161/255.0 blue:220/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = topColor;
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
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
        make.height.mas_equalTo(290);
    }];
    
    UIImageView *errorImgv = [[UIImageView alloc] init];
    errorImgv.image = [UIImage imageNamed:@"error"];
    [mainView addSubview:errorImgv];
    [errorImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(19);
        make.centerX.mas_equalTo(0);
    }];
    
    UILabel *errorLab = [[UILabel alloc] init];
    errorLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    errorLab.textColor = [UIColor colorWithRed:238/255.0 green:111/255.0 blue:93/255.0 alpha:1];
    errorLab.text = @"登录失败";
    [mainView addSubview:errorLab];
    [errorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(errorImgv.mas_bottom).offset(5);
        make.centerX.mas_equalTo(0);
    }];
    
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    infoView.layer.cornerRadius = 5;
    [mainView addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(106);
        make.left.mas_equalTo(gapX);
        make.right.mas_equalTo(-gapX);
        make.height.mas_equalTo(88);
    }];
    
    
    UIColor *txtColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    UIFont *txtFont = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.font = txtFont;
    tipLab.textColor = txtColor;
    tipLab.text = @"请按以下提示排除原因";
    [infoView addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(gapX);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *codeLab = [[UILabel alloc] init];
    codeLab.font = txtFont;
    codeLab.textColor = txtColor;
    codeLab.text = [NSString stringWithFormat:@"错误代码：%ld", (long)self.preCode];
    [infoView addSubview:codeLab];
    [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35);
        make.left.height.equalTo(tipLab);
    }];
    
    UILabel *msgLab = [[UILabel alloc] init];
    msgLab.font = txtFont;
    msgLab.textColor = txtColor;
    msgLab.text = [NSString stringWithFormat:@"错误日志: %@", self.preMsg];
    [infoView addSubview:msgLab];
    [msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.height.equalTo(tipLab);
    }];
    
    UIButton *againBtn = [[UIButton alloc] init];
    againBtn.backgroundColor = [UIColor colorWithRed:64/255.0 green:112/255.0 blue:242/255.0 alpha:1];
    againBtn.layer.cornerRadius = 5;
    againBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [againBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [againBtn setTitle:@"再次体验" forState:UIControlStateNormal];
    [againBtn addTarget:self action:@selector(againBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:againBtn];
    [againBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-24);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(120, 32));
    }];
}

#pragma mark - Action
- (void)againBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
