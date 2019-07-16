//
//  MHLoginViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHLoginViewController.h"
#import "MHWechatPhoneVC.h"
#import "UIImage+Common.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "MHPhoneLoginVC.h"
#import "MHWechatPhoneVC.h"
#import <UMShare/UMShare.h>
#import <JPUSHService.h>


@interface MHLoginViewController ()

@property(strong,nonatomic)UIButton *phoneBtn;
@property(strong,nonatomic)UIButton *wechatBtn;

@end

@implementation MHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    //logo
    UIImageView *logoImageView = [[UIImageView alloc]init];
    logoImageView.userInteractionEnabled = YES;
    logoImageView.backgroundColor = [UIColor whiteColor];
//    if (isiPhoneX) {
//        logoImageView.image = [UIImage imageNamed:@"login_bg_phonex"];
//    }else{
//       logoImageView.image = [UIImage imageNamed:@"login_bg_nomal"];
//    }
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
    
   
    
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"ic_cloos_dark"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeLogin) forControlEvents:UIControlEventTouchUpInside];
    [logoImageView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kNavBarHeight, kNavBarHeight));
        make.left.equalTo(self.view.mas_left).with.offset(kRealValue(10));
        make.top.equalTo(self.view.mas_top).with.offset(kStatusBarHeight);
    }];
    
//
    
    UIImageView *logoVew = [[UIImageView alloc]init];
    logoVew.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logoVew];
    [logoVew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(kTopHeight+kRealValue(88));
        make.size.mas_equalTo(CGSizeMake(kRealValue(186), kRealValue(82)));;
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
    }];
    //wechat
    _wechatBtn = [[UIButton alloc]init];
    [_wechatBtn setBackgroundImage:[UIImage imageNamed:@"wechat_login"] forState:UIControlStateNormal];
    [_wechatBtn addTarget:self action:@selector(wxLogin) forControlEvents:UIControlEventTouchUpInside];
    [logoImageView addSubview:_wechatBtn];
    [_wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kRealValue(375), kRealValue(44)));
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-kRealValue(180)-kBottomHeight);
    }];
    
    //手机号登陆
    _phoneBtn = [[UIButton alloc]init];
    [_phoneBtn setBackgroundImage:[UIImage imageNamed:@"phone_login"] forState:UIControlStateNormal];
     [_phoneBtn addTarget:self action:@selector(phoneLogin) forControlEvents:UIControlEventTouchUpInside];
    [logoImageView addSubview:_phoneBtn];
    [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kRealValue(375), kRealValue(44)));
        make.centerX.equalTo(self.view.mas_centerX).with.offset(0);
        make.top.equalTo(self.wechatBtn.mas_bottom).with.offset(kRealValue(20));
    }];
}


-(void)closeLogin{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//微信登录
-(void)wxLogin {
    
     [[UMSocialManager defaultManager]getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            KLToast(@"您取消了微信登录");
        }else{
            UMSocialUserInfoResponse *resp = result;
            [MBProgressHUD  showActivityMessageInWindow:@"正在登录中.."];
            [[MHUserService sharedInstance]initWithThirdLogin:@"WX" uid: resp.openid unionid:resp.unionId nickName:resp.name avatar:resp.iconurl completionBlock:^(NSDictionary *response, NSError *error) {
        
                if (ValidResponseDict(response)) {
                    [JPUSHService setAlias:[[response objectForKey:@"data"]objectForKey:@"alia"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                        
                    } seq:1];
                    if ([response[@"data"][@"userStatus"] intValue] == 1) {
                        //回到首页 登录成功
                        [GVUserDefaults standardUserDefaults].accessToken = [[response objectForKey:@"data"]objectForKey:@"accessToken"];
                        [GVUserDefaults standardUserDefaults].refreshToken = [[response objectForKey:@"data"]objectForKey:@"refreshToken"];
                         [GVUserDefaults standardUserDefaults].userRole =  [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
                        UITabBarController *tabbarViewController = (UITabBarController *)kRootViewController;
                        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
                            
                            tabbarViewController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                            tabbarViewController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"level_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                            tabbarViewController.viewControllers[2].tabBarItem.title = @"升级店主";
                        }else{
                            tabbarViewController.viewControllers[2].tabBarItem.selectedImage = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_highlight"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                            tabbarViewController.viewControllers[2].tabBarItem.image = [[UIImage imageWithImageSimple:[UIImage imageNamed:@"shop_nomal"] scaledToSize:CGSizeMake(30, 30)]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                            tabbarViewController.viewControllers[2].tabBarItem.title = @"店主";
                        }
                        
                        [self dismissViewControllerAnimated:YES completion:^{
                            [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRereshHome object:nil userInfo:nil];
                        }];
                    }else{
                        //绑定手机号
                        MHWechatPhoneVC *vc = [[MHWechatPhoneVC alloc] init];
                        vc.uid = resp.openid;
                        vc.unionid = resp.unionId;
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                }else{
                    KLToast(response[@"message"]);
                }
                [MBProgressHUD hideHUD];
            }];
        }
    }];
}


-(void)phoneLogin{
    MHPhoneLoginVC *vc = [[MHPhoneLoginVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
