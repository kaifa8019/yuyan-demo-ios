//
//  ViewController.m
//  OneClickLoginDemo
//
//  Created by 白粿 on 2019/8/12.
//  Copyright © 2019 Yuyan. All rights reserved.
//

#import "ViewController.h"
#import <YuyanOneClickLogin/YuyanOneClickLogin.h>
#import <ADMobGenNetwork/ADMobNetworkClient.h>
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <YYWebImage/YYWebImage.h>
#import "TimeView.h"
#import "SuccessViewController.h"
#import "ErrorViewController.h"
#import "NumberCheckViewController.h"

#define appID @"000000000"

@interface ViewController ()
@property (nonatomic, strong) YuyanCustomModel *baseModel;
@property (nonatomic, strong) YuyanOneClickLoginHandler *handler;

@property (nonatomic, strong) ADMobNetworkClient *networkRequest;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIView *thirdView;

@property (nonatomic, weak) TimeView *timeView;
@property (nonatomic, assign) double stTime;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat slfWidth = self.view.frame.size.width;
    
    
    UIImageView *topImgv = [[UIImageView alloc] init];
    topImgv.frame = CGRectMake(0, 44,
                               slfWidth, slfWidth/3*2);
    topImgv.animationImages = @[[UIImage imageNamed:@"A"], [UIImage imageNamed:@"B"], [UIImage imageNamed:@"C"]];
    topImgv.animationDuration = 2;
    [topImgv startAnimating];
    [self.view addSubview:topImgv];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    titleLab.text = @"无需输入 一键快速登录";
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImgv.mas_bottom).offset(24);
        make.left.mas_equalTo(15);
    }];
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(26);
        make.size.mas_equalTo(CGSizeMake(140, 40));
        make.centerX.mas_equalTo(0);
    }];
    
    UIButton *btnCheck = [[UIButton alloc] init];
    btnCheck.titleLabel.font = [UIFont systemFontOfSize:15];
    btnCheck.backgroundColor = self.loginBtn.backgroundColor;
    btnCheck.layer.cornerRadius = self.loginBtn.layer.cornerRadius;
    [btnCheck setTitle:@"本机号码校验" forState:UIControlStateNormal];
    [btnCheck addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCheck];
    [btnCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(8);
        make.centerX.mas_equalTo(0);
        make.size.equalTo(self.loginBtn);
    }];
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    tipLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    tipLab.text = @"点击按钮 立即体验";
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnCheck.mas_bottom).offset(8);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(17);
    }];
    
    TimeView *timeView = [[TimeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    timeView.userInteractionEnabled = NO;
    [[UIApplication sharedApplication].delegate.window addSubview:timeView];
    self.timeView = timeView;
    
    __weak typeof(self) weakSelf = self;
    [self.handler prepareWithAppID:appID complete:^(NSError * _Nonnull error) {
        if (!error) {
            NSLog(@"初始化成功");
            return;
        }
        
        NSLog(@"%@", error.localizedDescription);
        [weakSelf showErrorVCWithCode:error.code message:error.localizedDescription];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)requestPhoneWithToken:(NSString *)token {
    _networkRequest = [[ADMobNetworkClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://yuyan.popadshop.com"]];
    
    [self.networkRequest POST:@"/test/getmobile"
                   parameters:@{
                                @"certificate": token,
                                } success:^(NSURLSessionDataTask *task, id responseObject) {
                                    [self dismissBtnClick:nil];
                                    
                                    NSString *data = responseObject[@"data"];
                                    if (!data.length) {
                                        NSInteger code = [responseObject[@"code"] integerValue];
                                        [self showErrorVCWithCode:code message:responseObject[@"msg"]];
                                        return;
                                    }
                                    
                                    SuccessViewController *sucessVC = [[SuccessViewController alloc] init];
                                    sucessVC.preTime = [[NSDate date] timeIntervalSince1970] - self.timeView.startTime;
                                    sucessVC.prePhone = data;
                                    
                                    [self.navigationController pushViewController:sucessVC animated:YES];
                                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                    [self dismissBtnClick:nil];
                                    [self showErrorVCWithCode:error.code message:error.localizedDescription];
                                }];
}

- (void)showErrorVCWithCode:(NSInteger)code message:(NSString *)msg {
    ErrorViewController *errorVC = [[ErrorViewController alloc] init];
    errorVC.preCode = code;
    errorVC.preMsg = msg;
    [self.navigationController pushViewController:errorVC animated:YES];
}

#pragma mark - Lazy
- (YuyanOneClickLoginHandler *)handler {
    if (!_handler) {
        _handler = [YuyanOneClickLoginHandler shareHandler];
        _handler.viewController = self;
    }
    return _handler;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.loginBtn.backgroundColor = [UIColor colorWithRed:64/255.0 green:112/255.0 blue:244/255.0 alpha:1];
        [self.loginBtn setTitle:@"一键登录/注册" forState:UIControlStateNormal];
        self.loginBtn.layer.cornerRadius = 4;
        [self.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIView *)thirdView {
    if (_thirdView) return _thirdView;
    
    _thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, 418, self.view.frame.size.width, 100)];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
    titleLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    titleLab.text = @"快捷登录";
    [_thirdView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(17);
    }];
    
    CGSize btnSiz = CGSizeMake(50, 70);
    NSArray *imgNames = @[@"QQ", @"weibo", @"other"];
    NSArray *titles = @[@"QQ", @"微薄", @"账号"];
    CGFloat btnGap = 19;
    CGFloat nowX = _thirdView.frame.size.width/2 - btnSiz.width*1.5 - btnGap;
    for (int i = 0; i < imgNames.count; ++i) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(nowX, 30, btnSiz.width, btnSiz.height)];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
        [btn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imgNames[i]] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(-27, 0, 0, -24);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -50, -60, 0);
        [btn addTarget:self action:@selector(thirdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        nowX += btnSiz.width + btnGap;
        [_thirdView addSubview:btn];
    }
    
    return _thirdView;
}

- (YuyanCustomModel *)baseModel {
    YuyanCustomModel *model = [[YuyanCustomModel alloc] init];
    
    //自定义nav right btn
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(dismissBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    model.nav.moreView = rightBtn;
    
    model.nav.title = [[NSAttributedString alloc] initWithString:@"一键登录/注册" attributes:@{
        NSForegroundColorAttributeName: UIColor.blackColor,
        NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size:16]
    }];
        
    // logo图片
    UIImage *logoImg = [UIImage imageNamed:@"icon-1024"];
    logoImg = [logoImg yy_imageByResizeToSize:CGSizeMake(79, 79)];
    logoImg = [logoImg yy_imageByRoundCornerRadius:79.0/2];
    model.logo.image = logoImg;
    model.logo.frameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = (superViewSize.width - 79)/2;
        CGFloat y = 49;
        if (screenSize.width > screenSize.height) {
            x -= 70;
            y -= 40;
        }
        return CGRectMake(x, y, 79, 79);
    };
    
    // 号码文案
    model.numberColor = [UIColor colorWithRed:41/255.0 green:41/255.0 blue:41/255.0 alpha:1];
    model.numberFont = [UIFont systemFontOfSize:16];
    model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = (superViewSize.width - frame.size.width)/2;
        CGFloat y = 176;
        if (screenSize.width > screenSize.height) {
            x += 55;
            y -= 150;
        }
        return CGRectMake(x, y, EOF, EOF);
    };
    
    // slogan文案
    model.slogan.isHidden = NO;
//    model.slogan.text = [[NSAttributedString alloc] initWithString:@"这是一条slogan文案" attributes:@{
//        NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1],
//        NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size:12],
//    }];
    model.slogan.frameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = 0;
        CGFloat y = 208;
        if (screenSize.width > screenSize.height) {
            x += 90;
            y -= 140;
        }
        return CGRectMake(x, y, superViewSize.width, 17);
    };
        
    // 登录按钮
    model.loginBtn.text = [[NSAttributedString alloc] initWithString:@"本机号码一键登录" attributes:@{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName: [UIFont systemFontOfSize:20.0],
    }];
    model.loginBtn.frameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat width = MIN(superViewSize.width, superViewSize.height) - 16*2;
        CGFloat x = (superViewSize.width - width)/2;
        CGFloat y = 241;
        if (screenSize.width > screenSize.height) {
            x -= 15;
            y -= 126;
        }
        return CGRectMake(x, y, width, 40);
    };
    self.timeView.loginStr = model.loginBtn.text.string;
    
    // 其他登录方式
    model.changeBtnTitle = [[NSAttributedString alloc] initWithString:@"切换登录方式" attributes:@{
        NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1],
        NSFontAttributeName: [UIFont systemFontOfSize:16.0],
    }];
    model.changeBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = (superViewSize.width - frame.size.width)/2;
        CGFloat y = 297;
        if (screenSize.width > screenSize.height) {
            x += 10;
            y -= 117;
        }
        return CGRectMake(x, y, frame.size.width, frame.size.height);
    };
    
    // 自定义协议
    model.agreement.privacyOne = @[@"自定义协议1", @"https://github.com/"];
    model.agreement.privacyTwo = @[@"自定义协议2", @"https://www.baidu.com/"];
//    model.agreement.colors = @[UIColor.darkTextColor,UIColor.blueColor];
    
    // 自定义View
    __weak typeof(self) weakSelf = self;
    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
        weakSelf.timeView.tsView = superCustomView;
        
        [superCustomView addSubview:weakSelf.thirdView];
    };
    
    model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
        UIView *thirdView = weakSelf.thirdView;
        CGFloat x = (contentViewFrame.size.width - thirdView.frame.size.width)/2;
        CGFloat y = 418;
        if (screenSize.width > screenSize.height) {
            x += 10;
            y -= 200;
        }
        thirdView.frame = CGRectMake(x, y, thirdView.frame.size.width, thirdView.frame.size.height);
    };
    
    return model;
}


#pragma mark - Action
- (void)loginBtnClick:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [self.handler getLoginTokenWithModel:self.baseModel complete:^(NSString * _Nonnull token, NSError * _Nullable error) {
        if (!error) {
            [self requestPhoneWithToken:token];
            return;
        }
        
        switch (error.code) {
            case 700001: //使用其他登录方式, 手动管理dismiss
                [weakSelf dismissBtnClick:nil];
                break;
            case 700000: //点击返回按钮, 自动dismiss
                break;
            default:
                break;
        }
        NSLog(@"%@", error.localizedDescription);
        [weakSelf showErrorVCWithCode:error.code message:error.localizedDescription];
    }];
}

- (void)dismissBtnClick:(UIButton *)sender {
    [self  dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)thirdBtnClick:(UIButton *)sender {
    NSString *msg = [NSString stringWithFormat:@"使用%@登录", sender.currentTitle];
    [SVProgressHUD showInfoWithStatus:msg];
}

- (void)checkBtnClick:(UIButton *)sender {
    NumberCheckViewController *vc = [[NumberCheckViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
