//
//  MHAddWithDrawVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/7.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAddWithDrawVC.h"
#import "MHSumbitCouponCell.h"
#import "MHAddWithDrawnomalCell.h"
#import "MHAddWithDrawyzCell.h"
#import "MHAddWithDrawyzmCell.h"
#import "MHAddWithDrawBankCell.h"
#import "MHPickView.h"

@interface MHAddWithDrawVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, assign) NSInteger     selectPay;

@end

@implementation MHAddWithDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加提现方式";
    _selectPay = 0;
    [self.view addSubview:self.contentTableView];
    UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(16), kScreenHeight - kTopHeight - kRealValue(84)-kBottomHeight, kScreenWidth - kRealValue(32), kRealValue(44))];
    [btn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确认添加" forState:UIControlStateNormal];
    ViewRadius(btn, 5);
    [self.view addSubview:btn];
    
}

-(void)add{
    if (_selectPay == 0) {
        UILabel *bankName  =    [_contentTableView viewWithTag:6000];
        UITextField *banknumber  =    [_contentTableView viewWithTag:6001];
        UITextField *yzmnumber  =    [_contentTableView viewWithTag:6002];
        [[MHUserService sharedInstance]initwithAddWithdraw:bankName.text cardCode:banknumber.text verifyCode:yzmnumber.text withdrawType:@"0" completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                KLToast(@"添加成功");
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                 KLToast(response[@"message"]);
            }
            
        }];
        
    }else{
        UITextField *zfbnumber  =    [_contentTableView viewWithTag:6003];
        UITextField *yzmnumber  =    [_contentTableView viewWithTag:6004];
        [[MHUserService sharedInstance]initwithAddWithdraw:@"" cardCode:zfbnumber.text verifyCode:yzmnumber.text withdrawType:@"1" completionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                KLToast(@"添加成功");
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                KLToast(response[@"message"]);
            }
        }];
    }
    
}


-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight  -kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHSumbitCouponCell class] forCellReuseIdentifier:NSStringFromClass([MHSumbitCouponCell class])];
        [_contentTableView registerClass:[MHAddWithDrawnomalCell class] forCellReuseIdentifier:NSStringFromClass([MHAddWithDrawnomalCell class])];
        [_contentTableView registerClass:[MHAddWithDrawyzCell class] forCellReuseIdentifier:NSStringFromClass([MHAddWithDrawyzCell class])];
        [_contentTableView registerClass:[MHAddWithDrawyzmCell class] forCellReuseIdentifier:NSStringFromClass([MHAddWithDrawyzmCell class])];
         [_contentTableView registerClass:[MHAddWithDrawBankCell class] forCellReuseIdentifier:NSStringFromClass([MHAddWithDrawBankCell class])];
        
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        if (_selectPay == 0) {
            return 4;
        }else{
            return 3;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MHSumbitCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHSumbitCouponCell class])];
        if (indexPath.row == 0) {
            cell.leftImageView.image = kGetImage(@"ic_play_unionPay");
            cell.titleLabel.text = @"银行卡号";
            cell.footLabel.text = @"亿万用户的选择，更快更安全";
        }else{
            cell.leftImageView.image = kGetImage(@"ic_play_play");
            cell.titleLabel.text = @"支付宝";
            cell.footLabel.text = @"安全快捷，可支持银行卡支付";
        }
        
        if (indexPath.row == _selectPay) {
            cell.selectBtn.selected = YES;
        }else{
            cell.selectBtn.selected = NO;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if (_selectPay  == 0) {
            if (indexPath.row == 0) {
                MHAddWithDrawBankCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHAddWithDrawBankCell class])];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.selectClick = ^{
                    MHPickView *pick = [[MHPickView alloc]initWithComponentArr:@[@"中国工商银行",@"中国农业银行",@"中国建设银行",@"招商银行",@"中国银行",@"民生银行",@"光大银行",@"中信银行",@"交通银行",@"兴业银行",@"华夏银行",@"邮政储蓄银行",@"广发银行"]];
                    pick.sureBlock = ^(NSString *arr){
                        cell.contentLabel.textColor = [UIColor blackColor];
                        cell.contentLabel.text = arr;
                        cell.contentLabel.tag = 6000;
                    };
                    [self.view addSubview:pick];
                };
                return cell;
            }else if (indexPath.row == 1){
                MHAddWithDrawnomalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHAddWithDrawnomalCell class])];
                cell.titleLabel.text = @"银 行 卡 号";
                cell.numberTextField.placeholder = @"请输入银行卡号";
                cell.numberTextField.tag = 6001;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else if (indexPath.row == 2){
                MHAddWithDrawyzCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHAddWithDrawyzCell class])];
                cell.titleLabel.text = @"验证手机号";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else if (indexPath.row == 3){
                MHAddWithDrawyzmCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHAddWithDrawyzmCell class])];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.numberTextField.tag = 6002;
                [cell.countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
                    sender.enabled = NO;
                    [[MHUserService sharedInstance]initWithSendCode:[GVUserDefaults standardUserDefaults].phone
                                                              scene:@"WITHDRAW"
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
                return cell;
            }
            
        }else{
            if (indexPath.row == 0) {
                MHAddWithDrawnomalCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHAddWithDrawnomalCell class])];
                cell.titleLabel.text = @"支付宝账号";
                 cell.numberTextField.placeholder = @"请输入支付宝账户";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.numberTextField.tag = 6003;
                return cell;
            }else if (indexPath.row == 1){
                MHAddWithDrawyzCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHAddWithDrawyzCell class])];
                cell.titleLabel.text = @"验证手机号";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else if (indexPath.row == 2){
                MHAddWithDrawyzmCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHAddWithDrawyzmCell class])];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.numberTextField.tag = 6004;
                [cell.countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
                    sender.enabled = NO;
                    [[MHUserService sharedInstance]initWithSendCode:[GVUserDefaults standardUserDefaults].phone
                                                              scene:@"WITHDRAW"
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
                return cell;
            }
        }
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(42))];
    headView.backgroundColor = kBackGroudColor;
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kScreenWidth, kRealValue(42))];
    if (section == 0) {
        headLabel.text = @"提现方式";
    }else{
        if (_selectPay == 0) {
            headLabel.text = @"银行卡信息";
        }else{
            headLabel.text = @"支付宝";
        }
    }
    headLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
    headLabel.textColor = [UIColor blackColor];
    [headView addSubview: headLabel];
    return headView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        _selectPay = indexPath.row;
        [_contentTableView reloadData];
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kRealValue(42);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
         return kRealValue(64);
    }else{
        return kRealValue(44);
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
