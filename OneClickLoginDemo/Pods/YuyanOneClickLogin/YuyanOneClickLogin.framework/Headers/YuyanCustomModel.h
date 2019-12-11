//
//  YuyanCustomModel.h
//  YuyanOneClickLogin
//
//  Created by 白粿 on 2019/8/8.
//  Copyright © 2019 艾狄墨搏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YuyanCustomNavModel.h"
#import "YuyanCustomLogoModel.h"
#import "YuyanCustomAgreementModel.h"
#import "YuyanCustomAlertModel.h"
#import "YuyanCustomSloganModel.h"
#import "YuyanCustomLoginBtnModel.h"

typedef NS_ENUM(NSUInteger, YuyanPresentationDirection){
    YuyanPresentationDirection_Bottom = 0,
    YuyanPresentationDirection_Right,
    YuyanPresentationDirection_Top,
    YuyanPresentationDirection_Left,
};

@interface YuyanCustomModel : NSObject

#pragma mark - 全屏、弹窗模式设置
/**
 *  授权页面中，渲染并显示所有控件的view，称content view，不实现该block默认为全屏模式
 *  实现弹窗的方案 x > 0 || y > 0 width < 屏幕宽度 || height < 屏幕高度
 */
@property (nonatomic, copy) CGRect(^contentViewFrameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);

#pragma mark - 竖屏、横屏模式设置
/// 屏幕是否支持旋转方向，默认UIInterfaceOrientationMaskPortrait，注意：在刘海屏，UIInterfaceOrientationMaskPortraitUpsideDown属性慎用！
@property (nonatomic, assign) UIInterfaceOrientationMask supportedInterfaceOrientations;

#pragma mark - 弹窗模式属性
@property (nonatomic, strong) YuyanCustomAlertModel *alert;

#pragma mark - 导航栏（只对全屏模式有效）
/// 导航栏设置（只对全屏模式有效）
@property (nonatomic, strong) YuyanCustomNavModel *nav;

#pragma mark - 全屏、弹窗模式通用属性
/// 授权页弹出方向，默认YuyanPresentationDirection_Bottom
@property (nonatomic, assign) YuyanPresentationDirection presentDirection;

#pragma mark - 状态栏
/// 状态栏是否隐藏，默认NO
@property (nonatomic, assign) BOOL prefersStatusBarHidden;
/// 状态栏主题风格，默认UIStatusBarStyleDefault
@property (nonatomic, assign) UIStatusBarStyle preferredStatusBarStyle;

#pragma mark - logo图
/// logo图设置
@property (nonatomic, strong) YuyanCustomLogoModel *logo;

#pragma mark - slogan文案
/// slogan文案设置
@property (nonatomic, strong) YuyanCustomSloganModel *slogan;

@property (nonatomic, copy) NSAttributedString *sloganText DEPRECATED_MSG_ATTRIBUTE("请使用 .slogan.text");
@property (nonatomic, assign) BOOL sloganIsHidden DEPRECATED_MSG_ATTRIBUTE("请使用 .slogan.isHidden");
@property (nonatomic, assign) CGFloat sloganTopOffetY DEPRECATED_MSG_ATTRIBUTE("请使用 .slogan.frameBlock");

#pragma mark - 号码文案
/// 号码颜色设置
@property (nonatomic, strong) UIColor *numberColor;
/// 号码字体大小设置，大小小于16则不生效
@property (nonatomic, strong) UIFont *numberFont;
/**
 *  构建号码的frame，view布局或布局发生变化时调用，只有x、y生效，不实现则按默认处理，
 *  注：设置不能超出父视图 content view
 */
@property (nonatomic, copy) CGRect(^numberFrameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);

@property (nonatomic, assign) CGFloat numberTopOffetY DEPRECATED_MSG_ATTRIBUTE("请使用 .numberFrameBlock");

#pragma mark - 登录按钮设置
/// 登录按钮设置
@property (nonatomic, strong) YuyanCustomLoginBtnModel *loginBtn;

@property (nonatomic, strong) NSAttributedString *loginBtnText DEPRECATED_MSG_ATTRIBUTE("请使用 .loginBtn.text");
@property (nonatomic,strong) NSArray<UIImage *> *loginBtnBgImgs DEPRECATED_MSG_ATTRIBUTE("请使用 .loginBtn.bgImgs");
@property (nonatomic, assign) CGFloat loginBtnTopOffetY DEPRECATED_MSG_ATTRIBUTE("请使用 .loginBtn.frameBlock");
@property (nonatomic, assign) CGFloat loginBtnHeight DEPRECATED_MSG_ATTRIBUTE("请使用 .loginBtn.frameBlock");
@property (nonatomic, assign) CGFloat loginBtnLRPadding DEPRECATED_MSG_ATTRIBUTE("请使用 .loginBtn.frameBlock");

#pragma mark - 协议设置
/// 协议设置
@property (nonatomic, strong) YuyanCustomAgreementModel *agreement;

#pragma mark - 切换到其他方式
/// changeBtn标题，内容、字体、大小、颜色
@property (nonatomic, copy) NSAttributedString *changeBtnTitle;
/// changeBtn是否隐藏
@property (nonatomic, assign) BOOL changeBtnIsHidden;
/// 构建changeBtn的frame，view布局或布局发生变化时调用，不实现则按默认处理
@property (nonatomic, copy) CGRect(^changeBtnFrameBlock)(CGSize screenSize, CGSize superViewSize, CGRect frame);

@property (nonatomic, assign) CGFloat changeBtnTopOffetY DEPRECATED_MSG_ATTRIBUTE("请使用 .changeBtnFrameBlock");

// 自定义控件添加，注意：自定义视图的创建初始化和添加到父视图，都需要在主线程！！
@property (nonatomic,copy) void(^customViewBlock)(UIView *superCustomView);

/**
 *  每次授权页布局完成时会调用该block，可以在该block实现里面可设置自定义添加控件的frame
 *  @param  screenSize 屏幕的size
 *  @param  contentViewFrame content view的frame，
 *  @param  navFrame 导航栏的frame，仅全屏时有效
 *  @param  titleBarFrame 标题栏的frame，仅弹窗时有效
 *  @param  logoFrame logo图片的frame
 *  @param  sloganFrame slogan的frame
 *  @param  numberFrame 号码栏的frame
 *  @param  loginFrame 登录按钮的frame
 *  @param  changeBtnFrame 切换到其他方式按钮的frame
 *  @param  privacyFrame 协议整体（包括checkBox）的frame
*/
@property (nonatomic, copy) void(^customViewLayoutBlock)(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame);

@end
