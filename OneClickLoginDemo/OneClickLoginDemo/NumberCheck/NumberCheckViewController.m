//
//  NumberCheckViewController.m
//  OneClickLoginDemo
//
//  Created by 白粿 on 2019/9/5.
//  Copyright © 2019 Yuyan. All rights reserved.
//

#import "NumberCheckViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <YuyanOneClickLogin/YuyanOneClickLogin.h>
#import <ADSuyiNetwork/ADSuyiNetworkClient.h>
#import <Masonry/Masonry.h>

#define appID @"000000000"

@interface NumberCheckViewController ()
@property (nonatomic, strong) UITextField *phoneTxtField;
@property (nonatomic, strong) ADSuyiNetworkClient *checkRequest;
@end

@implementation NumberCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"本机号码校验";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _phoneTxtField = [[UITextField alloc] init];
    self.phoneTxtField.placeholder = @"请输入需要校验的手机号码";
    self.phoneTxtField.layer.cornerRadius = 4;
    self.phoneTxtField.layer.borderWidth = 1;
    self.phoneTxtField.layer.borderColor = [UIColor grayColor].CGColor;
    self.phoneTxtField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.phoneTxtField];
    [self.phoneTxtField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *btnCheck = [[UIButton alloc] init];
    btnCheck.titleLabel.font = [UIFont systemFontOfSize:15];
    btnCheck.backgroundColor = [UIColor colorWithRed:64/255.0 green:112/255.0 blue:244/255.0 alpha:1];
    [btnCheck setTitle:@"号码校验" forState:UIControlStateNormal];
    btnCheck.layer.cornerRadius = 4;
    [btnCheck addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCheck];
    [btnCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTxtField.mas_bottom).offset(20);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.equalTo(self.phoneTxtField);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)requestPhoneCheck:(NSString *)phone token:(NSString *)token {
    _checkRequest = [[ADSuyiNetworkClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://yuyan.popadshop.com"]];
    
    [self.checkRequest POST:@"/test/verifymobile"
                 parameters:@{
                     @"certificate": token,
                 } success:^(NSURLSessionDataTask *task, NSHTTPURLResponse *response, id responseObject) {
        if (responseObject == nil || ![responseObject isKindOfClass:[NSDictionary class]]) {
            responseObject = @{};
        }
        
        if ([responseObject[@"data"] isEqualToString:@"PASS"]) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"data"]];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"data"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSHTTPURLResponse *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

#pragma mark - Action
- (void)checkBtnClick:(UIButton *)sender {
    NSString *phone = self.phoneTxtField.text;
    
    [SVProgressHUD show];
    [[YuyanNumberCheck shareHandler] prepareWithAppID:appID complete:^(NSError * _Nullable error) {
        if (error) {
            [SVProgressHUD showInfoWithStatus:error.localizedDescription];
            return;
        }
        
        [[YuyanNumberCheck shareHandler] getTokenWithPhone:phone complete:^(NSString * _Nonnull token, NSError * _Nullable error) {
            if (error) {
                [SVProgressHUD showInfoWithStatus:error.localizedDescription];
                return;
            }
            
            [self requestPhoneCheck:phone token:token];
        }];
    }];
}

@end
