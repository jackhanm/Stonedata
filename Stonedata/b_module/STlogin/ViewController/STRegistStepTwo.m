//
//  STRegistStepTwo.m
//  Stonedata
//
//  Created by yuhao on 2019/7/15.
//  Copyright © 2019 hf. All rights reserved.
//

#import "STRegistStepTwo.h"
#import "WLUnitField.h"
#import <JKCountDownButton.h>
@interface STRegistStepTwo () <WLUnitFieldDelegate>
@property(nonatomic,strong) WLUnitField *unitField;
@property(nonatomic,strong)JKCountDownButton *countDownCode;
@property (strong, nonatomic) UIButton *loginBtn;
@end

@implementation STRegistStepTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xffffff);
    [self createview];
    // Do any additional setup after loading the view.
}
-(void)createview
{
    // 标题
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(30), kRealValue(53),kScreenWidth - kRealValue(100) , kRealValue(25))];
    titlelab.text = @"请输入验证码";
    titlelab.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(20)];
    titlelab.textColor = KColorFromRGB(0x333333);
    titlelab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titlelab];
    
    UILabel *subtitlelab = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(30), kRealValue(78),kScreenWidth - kRealValue(100) , kRealValue(20))];
    subtitlelab.text = @"验证码已发送至手机:";
    subtitlelab.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    subtitlelab.textColor = KColorFromRGB(0x666666);
    subtitlelab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:subtitlelab];
    
    UILabel *phonelab = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(30), kRealValue(98),kScreenWidth - kRealValue(100) , kRealValue(20))];
    phonelab.text = @"159  5605  7392";
    phonelab.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    phonelab.textColor = KColorFromRGB(0x333333);
    phonelab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phonelab];
    
    
    self.unitField = [[WLUnitField alloc]initWithStyle:WLUnitFieldStyleUnderline inputUnitCount:4];
    self.unitField.delegate = self;
    self.unitField.keyboardType = UIKeyboardTypeNumberPad;
    self.unitField.frame = CGRectMake(kRealValue(30), kRealValue(140), kScreenWidth - kRealValue(60), kRealValue(50));
    [self.view addSubview:self.unitField];
    
    
    //发送验证码
    _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    _countDownCode.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_countDownCode setTitleColor:KColorFromRGB(kThemecolor) forState:UIControlStateNormal];
    [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:_countDownCode];
    [_countDownCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(20));
        make.left.equalTo(self.view.mas_left).offset(kRealValue(30));
        make.width.mas_equalTo(kRealValue(80));
        make.top.equalTo(self.unitField.mas_bottom).offset(kRealValue(20));
    }];
    [_countDownCode startCountDownWithSecond:60];
    //调用发送短信验证码接口
//    [[MHUserService sharedInstance]initWithSendCode:ValidStr(_phoneTextField.text)?_phoneTextField.text:@""
//                                              scene:@"THIRDPARTY_BIND_PHONE"
//                                    completionBlock:^(NSDictionary *response, NSError *error) {
//                                        if (ValidResponseDict(response)) {
//                                            KLToast(@"发送成功");
//                                            [sender startCountDownWithSecond:90];
//                                        }else{
//                                            KLToast(response[@"message"]);
//                                            sender.enabled = YES;
//                                        }
//                                        if (error) {
//                                            sender.enabled = YES;
//                                        }
//                                    }]
    
    
    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        ;
        [_countDownCode startCountDownWithSecond:60];
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"再次发送%zds",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"重新获取";
        }];
        
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"确定" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:KColorFromRGB(kThemecolor)] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#BEBEBE"]] forState:UIControlStateDisabled];
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.enabled = NO;
    _loginBtn.layer.cornerRadius = kRealValue(3);
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kScreenWidth-kRealValue(60));
        make.top.equalTo(self.countDownCode.mas_bottom).offset(kRealValue(25));
    }];
    
    
    
    
}

- (BOOL)unitField:(WLUnitField *)uniField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = nil;
    if (range.location >= uniField.text.length) {
        text = [uniField.text stringByAppendingString:string];
    } else {
        text = [uniField.text stringByReplacingCharactersInRange:range withString:string];
    }
    NSLog(@"******>%@", text);
    if (!klStringisEmpty(text)) {
        if (text.length>= 4) {
            self.loginBtn.enabled = YES;
        }
    }
    return YES;
}


-(void)regist
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view.window endEditing:YES];
}
-(void)closeLogin{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
