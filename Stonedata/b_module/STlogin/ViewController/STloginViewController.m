//
//  STloginViewController.m
//  Stonedata
//
//  Created by yuhao on 2019/7/15.
//  Copyright © 2019 hf. All rights reserved.
//

#import "STloginViewController.h"
#import "MHWebviewViewController.h"
#import "STRegistStepOne.h"
#import "STforgetPsd.h"
@interface STloginViewController ()
@property(strong,nonatomic)UITextField *phoneTextField;
@property(strong,nonatomic)UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic)UIView *phoneLineView;
@property (strong, nonatomic) UIView *passwordLineView;
@end

@implementation STloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xffffff);
    [self createview];
    // Do any additional setup after loading the view.
}
-(void)createview
{
    // 按钮
    UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [moreBtn setFrame:CGRectMake(5,0,kRealValue(70),kRealValue(30))];
    [moreBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [moreBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    // 标题
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(30), kRealValue(53),kScreenWidth - kRealValue(100) , kRealValue(25))];
    titlelab.text = @"欢迎来到xxxx";
    titlelab.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(20)];
    titlelab.textColor = KColorFromRGB(0x333333);
    titlelab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titlelab];
    // 隐私协议
   
    NSString *desc = @"我们承诺保证您的账号及个人信息的安全,登录即视为同意《免责与隐私申明》";
    NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
    textdesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    textdesc.color = [UIColor colorWithHexString:@"858384"];
    [textdesc setTextHighlightRange:[desc rangeOfString:@"《免责与隐私申明》"]
                              color:[UIColor colorWithHexString:@"3477FA"]
                    backgroundColor:[UIColor colorWithHexString:@"666666"]
                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                              
                            
                              MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://wap.mohuyoupin.com/privacy_policy.html" comefrom:@"home"];
                              [self.navigationController pushViewController:vc animated:YES];
                          }];
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kRealValue(280), CGFLOAT_MAX) text:textdesc];
    YYLabel *textLabel = [YYLabel new];
    textLabel.numberOfLines = 0;
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kScreenWidth-kRealValue(60));
        make.left.equalTo(self.view.mas_left).offset(kRealValue(30));
        make.height.mas_equalTo(layout.textBoundingSize.height);
        make.top.equalTo(titlelab.mas_bottom).offset(kRealValue(5));
    }];
    
    textLabel.attributedText = textdesc;
    
    // 手机号
    UILabel *loginlab = [[UILabel alloc]init];
    loginlab.text = @"手机号";
    loginlab.textColor = KColorFromRGB(0x999999);
    loginlab.textAlignment = NSTextAlignmentLeft;
    loginlab.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [self.view addSubview:loginlab];
    [loginlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel.mas_bottom).offset(kRealValue(30));
        make.left.equalTo(self.view.mas_left).offset(kRealValue(30));
    }];
    //手机号输入框
    _phoneTextField = [UITextField new];
    _phoneTextField.placeholder = @"请输入11位手机号码";
    _phoneTextField.backgroundColor = [UIColor whiteColor];
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_phoneTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_phoneTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    [_phoneTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [self.view addSubview:_phoneTextField];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kScreenWidth-kRealValue(60));
        make.left.equalTo(self.view.mas_left).offset(kRealValue(30));
        make.top.equalTo(loginlab.mas_bottom).offset(kRealValue(0));
    }];
    _phoneLineView = [[UIView alloc] init];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    [self.view addSubview:_phoneLineView];
    [_phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kScreenWidth-kRealValue(60));
        make.bottom.equalTo(self.phoneTextField.mas_bottom).offset(0);
    }];
    //密码
    UILabel *mimalab = [[UILabel alloc]init];
    mimalab.text = @"密码";
    mimalab.textColor = KColorFromRGB(0x999999);
    mimalab.textAlignment = NSTextAlignmentLeft;
    mimalab.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [self.view addSubview:mimalab];
    [mimalab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLineView.mas_bottom).offset(kRealValue(15));
        make.left.equalTo(self.view.mas_left).offset(kRealValue(30));
    }];
    _passwordTextField = [UITextField new];
    _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.placeholder = @"请输入6-16位密码";
    [_passwordTextField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_passwordTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [_passwordTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(44));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kScreenWidth-kRealValue(60));
        make.left.equalTo(self.view.mas_left).offset(kRealValue(30));
        make.top.equalTo(mimalab.mas_bottom).offset(kRealValue(0));
    }];
    _passwordLineView = [[UIView alloc] init];
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    [self.view addSubview:_passwordLineView];
    [_passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/kScreenScale);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.mas_equalTo(kScreenWidth-kRealValue(60));
        make.bottom.equalTo(self.passwordTextField.mas_bottom).offset(0);
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
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
        make.top.equalTo(self.passwordLineView.mas_bottom).offset(kRealValue(45));
    }];
    
    
    UIButton *forgetBtn = [[UIButton alloc] init];
    forgetBtn.backgroundColor = [UIColor clearColor];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetUser) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(20));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-67);
        make.width.mas_equalTo(kRealValue(74));
       
    }];
    
    
    
    
    
    
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)login{
    
    [self.view endEditing:YES];
    if (_phoneTextField.text.length != 11) {
        KLToast(@"请输入正确的手机号");
        return;
    }
    if (_passwordTextField.text.length >=0 && _passwordTextField.text.length < 6) {
        KLToast(@"请输入正确密码");
        return;
    }
    [GVUserDefaults standardUserDefaults].accessToken = @"1";
    [GVUserDefaults standardUserDefaults].refreshToken = @"2";
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)regist
{
    STRegistStepOne *vc= [[STRegistStepOne alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)closeLogin{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)forgetUser{
    
    STforgetPsd *vc = [[STforgetPsd alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
   
}


#pragma mark TextField
- (void)editDidBegin:(UITextField *)sender {
    MHLog(@"%@",sender);
    if (sender  == _phoneTextField) {
        _phoneLineView.backgroundColor = KColorFromRGB(kThemecolor);
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    }else{
        _passwordLineView.backgroundColor = KColorFromRGB(kThemecolor);
        _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    }
}

- (void)editDidEnd:(UITextField *)sender {
    _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
    _phoneLineView.backgroundColor = [UIColor colorWithHexString:@"#E1E1E1"];
}


- (void)textValueChanged:(id)sender {
    
    //手机号 11位
    if (_phoneTextField.text.length > 11) {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:11];
        
    }
    //验证码 4位
    if (_passwordTextField.text.length > 16) {
        _passwordTextField.text = [_passwordTextField.text substringToIndex:16];
        
    }
    
    if (_phoneTextField.text.length == 11 && _passwordTextField.text.length >=6) {
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.enabled = NO;
    }
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
