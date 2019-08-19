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

#define appID @"000000000"

@interface ViewController ()
@property (nonatomic, strong) YuyanOneClickLoginHandler *handler;

@property (nonatomic, strong) ADMobNetworkClient *networkRequest;

@property (nonatomic, strong) UIButton *loginBtn;

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
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    tipLab.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    tipLab.text = @"点击按钮 立即体验";
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(8);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(17);
    }];
    
    TimeView *timeView = [[TimeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    timeView.userInteractionEnabled = NO;
    [[UIApplication sharedApplication].delegate.window addSubview:timeView];
    self.timeView = timeView;
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

- (void)getLoginToken {
    YuyanCustomModel *model = [[YuyanCustomModel alloc] init];
    
    //自定义nav right btn
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(dismissBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    model.navMoreControl = rightBarItem;
    model.navTitle = [[NSAttributedString alloc] initWithString:@"一键登录/注册" attributes:@{NSForegroundColorAttributeName: UIColor.blackColor, NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size:16]}];
    
    // logo图片
    UIImage *logoImg = [UIImage imageNamed:@"icon-1024"];
    logoImg = [logoImg yy_imageByResizeToSize:CGSizeMake(79, 79)];
    logoImg = [logoImg yy_imageByRoundCornerRadius:79.0/2];
    model.logoSize = CGSizeMake(79, 79);
    model.logoImage = logoImg;
    model.logoTopOffetY = 49;
    
    // 号码
    model.numberColor = [UIColor colorWithRed:41/255.0 green:41/255.0 blue:41/255.0 alpha:1];
    model.numberSize = 16;
    model.numberTopOffetY = 176;
    
    // 自定义文案
    model.sloganIsHidden = NO;
//    model.sloganText = [[NSAttributedString alloc] initWithString:@"中国__提供认证服务" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1], NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size:12]}];
    model.sloganTopOffetY = 208;
    
    // 登录按钮
    model.loginBtnTitle = @"本机号码一键登录";
    model.loginBtnTopOffetY = 241;
    self.timeView.loginStr = model.loginBtnTitle;
    
    // 其他登录方式
    model.changeBtnTitle = [[NSAttributedString alloc] initWithString:@"切换登录方式" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1], NSFontAttributeName: [UIFont systemFontOfSize:16.0]}];
    model.changeBtnTopOffetY = 297;
    
    // 自定义协议
    model.privacyOne = @[@"APP用户协议1", @"https://www.taobao.com/"];
    model.privacyTwo = @[@"APP协议2", @"https://www.baidu.com/"];
    model.privacyColors = @[UIColor.darkTextColor,UIColor.blueColor];
    
    // 自定义View
    __weak ViewController *weakSelf = self;
    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
        weakSelf.timeView.tsView = superCustomView;
        
        UIView *thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, 418, self.view.frame.size.width, 100)];
        [superCustomView addSubview:thirdView];
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
        titleLab.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        titleLab.text = @"快捷登录";
        [superCustomView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(17);
        }];
        
        CGSize btnSiz = CGSizeMake(50, 70);
        NSArray *imgNames = @[@"QQ", @"weibo", @"other"];
        NSArray *titles = @[@"QQ", @"微薄", @"账号"];
        CGFloat btnGap = 19;
        CGFloat nowX = thirdView.frame.size.width/2 - btnSiz.width*1.5 - btnGap;
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
            [thirdView addSubview:btn];
        }
    };
    
    [self.handler getLoginTokenWithModel:model complete:^(NSString * _Nonnull token, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            
            switch (error.code) {
                case 6669:// 使用其他登录方式, 手动管理dismiss
                    [weakSelf dismissBtnClick:nil];
                    break;
                case 6667:// 点击返回按钮, 自动dismiss
                    break;
                default:
                    break;
            }
            
            [weakSelf showErrorVCWithCode:error.code message:error.localizedDescription];
            return;
        }
        
        [self requestPhoneWithToken:token];
    }];
}

#pragma mark - Lazy
- (YuyanOneClickLoginHandler *)handler {
    if (!_handler) {
        _handler = [[YuyanOneClickLoginHandler alloc] initWithViewController:self];
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

#pragma mark - Action
- (void)loginBtnClick:(UIButton *)sender {
    __weak ViewController *weakSelf = self;
    [self.handler prepareWithAppID:appID complete:^(NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            [weakSelf showErrorVCWithCode:error.code message:error.localizedDescription];
        } else {
            NSLog(@"初始化成功");
            [self getLoginToken];
        }
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

@end
