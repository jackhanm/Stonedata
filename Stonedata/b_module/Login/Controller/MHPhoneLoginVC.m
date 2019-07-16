//
//  MHPhoneLoginVC.m
//  mohu
//
//  Created by AllenQin on 2018/9/21.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHPhoneLoginVC.h"
#import "JKCountDownButton.h"
#import "UIImage+Common.h"
#import "MHYQVC.h"
#import "MHWebviewViewController.h"
#import <JPUSHService.h>

@interface MHPhoneLoginVC ()

@property(strong,nonatomic)UITextField *phoneTextField;

@property(strong,nonatomic)UITextField *passwordTextField;

@property (strong, nonatomic)UIView *phoneLineView;

@property (strong, nonatomic) UIView *passwordLineView;

@property (strong, nonatomic) UIButton *loginBtn;

@property (strong, nonatomic) JKCountDownButton *countDownCode;

@end

@implementation MHPhoneLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"手机号登录";
    
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [_phoneTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_phoneTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(50));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.top.equalTo(self.view.mas_top).offset(kRealValue(110));
    }];
    
    
    _passwordTextField = [UITextField new];
    _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    _passwordTextField.placeholder = @"验证码";
    [_passwordTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [_passwordTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_passwordTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(50));
        make.left.equalTo(_phoneTextField.mas_left).offset(0);
        make.width.mas_equalTo(kRealValue(250));
        make.top.equalTo(_phoneTextField.mas_bottom).offset(0);
    }];
    
    //发送验证码
    _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [_countDownCode setTitleColor:[UIColor colorWithHexString:@"689DFF"] forState:UIControlStateNormal];
    [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:_countDownCode];
    [_countDownCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(50));
        make.right.equalTo(_phoneTextField.mas_right).offset(0);
        make.width.mas_equalTo(kRealValue(80));
        make.bottom.equalTo(_passwordTextField.mas_bottom).offset(0);
    }];
    
    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
         sender.enabled = NO;
        [[MHUserService sharedInstance]initWithSendCode:ValidStr(_phoneTextField.text)?_phoneTextField.text:@""
                                                  scene:@"LOGIN"
                                        completionBlock:^(NSDictionary *response, NSError *error) {
                                            if (ValidResponseDict(response)) {
                                                KLToast(@"发送成功");
                                                [sender startCountDownWithSecond:90];
                                            }else{
                                                KLToast(response[@"message"]);
                                                sender.enabled = YES;
                                            }
                                            if (error) {
                                                sender.enabled = YES;
                                            }
        }];
        
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"%zds",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"重新获取";
        }];
        
    }];
    
    _phoneLineView = [[UIView alloc] init];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    [self.view addSubview:_phoneLineView];
    [_phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.bottom.equalTo(_phoneTextField.mas_bottom).offset(0);
    }];
    
    _passwordLineView = [[UIView alloc] init];
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"CCCCCC"];
    [self.view addSubview:_passwordLineView];
    [_passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.bottom.equalTo(_passwordTextField.mas_bottom).offset(0);
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#ff8900"];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = kRealValue(22);
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(350));
        make.top.equalTo(_passwordLineView.mas_bottom).offset(kRealValue(25));
    }];
    
    NSString *desc = @"温馨提示：未注册未来商视账户的手机号，登录时将自动注册，且代表您已同意《未来商视注册协议》";
    NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
    textdesc.font = [UIFont fontWithName:kPingFangLight size:kFontValue(11)];
    textdesc.color = [UIColor colorWithHexString:@"000000"];
    [textdesc setTextHighlightRange:[desc rangeOfString:@"《未来商视注册协议》"]
                              color:[UIColor colorWithHexString:@"689DFF"]
                    backgroundColor:[UIColor colorWithHexString:@"666666"]
                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                              MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://wap.mohuyoupin.com/registration_agreement.html" comefrom:@"mine"];
                              [self.navigationController pushViewController:vc animated:YES];
                          }];
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kRealValue(320), CGFLOAT_MAX) text:textdesc];
    YYLabel *textLabel = [YYLabel new];
    textLabel.numberOfLines = 0;
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(320));
        make.height.mas_equalTo(layout.textBoundingSize.height);
        make.top.equalTo(_loginBtn.mas_bottom).offset(kRealValue(13));
    }];
    textLabel.attributedText = textdesc;
    
}

- (void)login{
    [self.view endEditing:YES];
    if (_phoneTextField.text.length < 11) {
        KLToast(@"手机号格式不正确");
        return;
    }
    if (_passwordTextField.text.length < 4) {
        KLToast(@"验证码不正确");
        return;
    }

    [[MHUserService sharedInstance]initWithLogin:ValidStr(_phoneTextField.text)?_phoneTextField.text:@""
                                             sms:ValidStr(_passwordTextField.text)?_passwordTextField.text:@"" completionBlock:^(NSDictionary *response, NSError *error) {
                                                 if (ValidResponseDict(response)) {
                                                     
                                                     [JPUSHService setAlias:[[response objectForKey:@"data"]objectForKey:@"alia"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                                                         
                                                     } seq:1];
                                                     
                                                     //注册  登陆
                                                     if ([response[@"data"][@"userStatus"] intValue] == 1) {
                                                         //回到首页 登录成功
                                                         [GVUserDefaults standardUserDefaults].accessToken = [[response objectForKey:@"data"]objectForKey:@"accessToken"];
                                                         [GVUserDefaults standardUserDefaults].refreshToken = [[response objectForKey:@"data"]objectForKey:@"refreshToken"];
                                                         [GVUserDefaults standardUserDefaults].userRole = [NSString stringWithFormat:@"%@",response[@"data"][@"userRole"]];
                                               
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
                                                         //邀请码
                                                         MHYQVC *vc = [[MHYQVC alloc]init];
                                                         vc.accessToken = [[response objectForKey:@"data"]objectForKey:@"accessToken"];
                                                         vc.phoneStr = _phoneTextField.text;
                                                         vc.refreshToken = [[response objectForKey:@"data"]objectForKey:@"refreshToken"];
                                                         [self.navigationController pushViewController:vc animated:YES];
                                                     }
                                                 }else{
                                                      KLToast(response[@"message"]);
                                                 }

}];
}


#pragma mark TextField
- (void)editDidBegin:(UITextField *)sender {
    MHLog(@"%@",sender);
    if (sender  == _phoneTextField) {
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }else{
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"FF5100"];
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }
}

- (void)editDidEnd:(UITextField *)sender {
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)textValueChanged:(id)sender {
    
    //手机号 11位
    if (_phoneTextField.text.length > 11) {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:11];
        
    }
    //验证码 4位
    if (_passwordTextField.text.length > 4) {
        _passwordTextField.text = [_passwordTextField.text substringToIndex:4];
        
    }
}

- (void)backBtnClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
