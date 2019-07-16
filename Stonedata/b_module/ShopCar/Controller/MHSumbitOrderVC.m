//
//  MHSumbitOrderVC.m
//  mohu
//
//  Created by AllenQin on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHSumbitOrderVC.h"
#import "MHSumbitCouponCell.h"
#import "MHOrderProCell.h"
#import "MHSumbitProView.h"
#import "MHSumbitMessageView.h"
#import "MHSumbitFootView.h"
#import "MHSumbitCoustomCell.h"
#import "MHSumbitHeadView.h"
#import "CYPasswordView.h"
#import "MHSumbitModel.h"
#import "MHSetPsdVC.h"
#import "MHShopSumbitModel.h"
#import "MHMineUserInfoAddressViewController.h"
#import "RichStyleLabel.h"
#import "MHPayClass.h"
#import "MHPayResultVC.h"
#import "MHMineuserAddress.h"
#import "MHTaskVC.h"


@interface MHSumbitOrderVC ()<UITableViewDataSource,UITableViewDelegate,YYTextViewDelegate>

@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) UIView        *bottomNav;

@property (nonatomic, strong) UIView        *lineNav;
//是否展开
@property (nonatomic,assign) BOOL     isDeploy;
//选择支付方式
@property (nonatomic,assign) NSInteger  selectPay;

@property (nonatomic,copy) NSArray  *picArr;

@property (nonatomic,copy) NSArray  *titleArr;
@property (nonatomic,strong) NSMutableDictionary  *mobiDict;

@property (nonatomic,strong) NSMutableArray  *shopArr;

@property (nonatomic,strong) NSMutableArray  *liuyanArr;
@property (nonatomic,strong) NSMutableArray  *sellerId;

@property (nonatomic, strong) CYPasswordView *passwordView;
@property (nonatomic, strong)MHSumbitHeadView *headView ;
@property (nonatomic, strong)MHSumbitFootView *footView;

@property (nonatomic, strong) MHShopSumbitModel *sumbitModel;
@property (nonatomic, strong) MHMineuserAddress *adress;

@end

@implementation MHSumbitOrderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.view.backgroundColor = kBackGroudColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancel) name:@"CYPasswordViewCancleButtonClickNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPWD) name:@"CYPasswordViewForgetPWDButtonClickNotification" object:nil];
       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAdress:) name:KNotificationchangeAdress object:nil];
    _isDeploy = NO;
    _selectPay = 0;
    _picArr = @[@"ic_play_wechat",@"ic_play_play",@"ic_play_mobi"];
    _titleArr = @[@"微信支付",@"支付宝支付",@"陌币支付"];
    _liuyanArr = [NSMutableArray array];
    _sellerId  = [NSMutableArray array];
    
    [[MHUserService sharedInstance]initwithUserStateCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [[MHUserService sharedInstance]initwithConfirmProduct:self.arr completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    self.shopArr  =  [MHSumbitModel baseModelWithArr:response[@"data"][@"shops"]];
                    self.sumbitModel = [MHShopSumbitModel baseModelWithDic:response[@"data"]];
                    [self.liuyanArr removeAllObjects];
                    [self.sellerId removeAllObjects];
                    [self.shopArr enumerateObjectsUsingBlock:^(MHSumbitModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [self.liuyanArr addObject:@""];
                        [self.sellerId addObject:obj.sellerId];
                    }];
                    
                    [self createTableView];
                    [self creatbottomNav];
                    [self creatLineNav];
                    if (ValidStr(self.sumbitModel.userName)) {
                        self.headView.addressLabel.hidden = NO;
                        self.headView.nameLabel.hidden = NO;
                        self.headView.phoneLabel.hidden = NO;
                        self.headView.emtyLabel.hidden = YES;
                        self.headView.nameLabel.text = self.sumbitModel.userName;
                        self.headView.phoneLabel.text = self.sumbitModel.userPhone;
                        self.headView.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",self.sumbitModel.province,self.sumbitModel.city,self.sumbitModel.area,self.sumbitModel.details];
                    }else{
                        self.headView.addressLabel.hidden = YES;
                        self.headView.nameLabel.hidden = YES;
                        self.headView.phoneLabel.hidden = YES;
                        self.headView.emtyLabel.hidden = NO;
                    }
                    
                    [self.contentTableView reloadData];
                }else{
                    KLToast(response[@"message"]);
                }
            }];
            
        }
    }];
    
    

 
}


-(void)changeAdress:(NSNotification *)noti
{
    self.adress  = [noti object];
    if (ValidStr(self.adress .userName)) {
        self.headView.addressLabel.hidden = NO;
        self.headView.nameLabel.hidden = NO;
        self.headView.phoneLabel.hidden = NO;
        self.headView.emtyLabel.hidden = YES;
        self.headView.nameLabel.text = self.adress .userName;
        self.headView.phoneLabel.text = self.adress .userPhone;
        self.headView.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",self.adress .province,self.adress .city,self.adress .area,self.adress .details];
    }else{
        self.headView.addressLabel.hidden = YES;
        self.headView.nameLabel.hidden = YES;
        self.headView.phoneLabel.hidden = YES;
        self.headView.emtyLabel.hidden = NO;
    }
    
}



- (void)createTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kTopHeight- kRealValue(40)-kBottomHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kRealValue(80), 0);
        _contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _contentTableView.showsVerticalScrollIndicator = NO;
        _headView = [[MHSumbitHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(86))];

        _headView.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAdress)];
        [_headView addGestureRecognizer:tap];
        _contentTableView.tableHeaderView = _headView;
       _footView = [[MHSumbitFootView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(211)) withTitleArr:@[[NSString stringWithFormat:@"%@件",self.sumbitModel.productCount],[NSString stringWithFormat:@"+%@元",self.sumbitModel.orderPrice],[NSString stringWithFormat:@"+%@元",self.sumbitModel.orderSendPrice],[NSString stringWithFormat:@"-%@元",self.sumbitModel.orderDiscountPrice]]];
        
        //    _sumbitModel.,_sumbitModel.orderSendPrice,_sumbitModel.
        [_footView.isDeployBtn addTarget: self action:@selector(changeState) forControlEvents:UIControlEventTouchUpInside];
        _contentTableView.tableFooterView = _footView;
        [_contentTableView registerClass:[MHSumbitCouponCell class] forCellReuseIdentifier:NSStringFromClass([MHSumbitCouponCell class])];
        [_contentTableView registerClass:[MHOrderProCell class] forCellReuseIdentifier:NSStringFromClass([MHOrderProCell class])];
        [_contentTableView registerClass:[MHSumbitCoustomCell class] forCellReuseIdentifier:NSStringFromClass([MHSumbitCoustomCell class])];
        
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}
-(void)selectAdress{
    MHMineUserInfoAddressViewController *vc = [[MHMineUserInfoAddressViewController alloc] init];
    vc.type = @"sumbit";
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)creatbottomNav{
    if (!_bottomNav) {
        _bottomNav = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kTopHeight-kRealValue(44), kScreenWidth, kRealValue(44))];
        _bottomNav.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bottomNav];
        
        RichStyleLabel *priceLabel = [[RichStyleLabel alloc]init];
        priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        priceLabel.textColor =[UIColor colorWithHexString:@"#000000"];
        priceLabel.textAlignment = NSTextAlignmentRight;
        [_bottomNav addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bottomNav.mas_top).with.offset(0);
            make.left.equalTo(self.bottomNav.mas_left).with.offset(kRealValue(16));
            make.height.mas_equalTo(kRealValue(44));
        }];
        
      [priceLabel setAttributedText:[NSString stringWithFormat:@"需支付  ¥%@",self.sumbitModel.orderTruePrice] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#FB3131"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(14)]}];
        
        UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(100),0, kRealValue(100), kRealValue(44))];
        [submitBtn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(100), kRealValue(44))] forState:UIControlStateNormal];
        submitBtn.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
        [submitBtn setTitle:@"去支付" forState:UIControlStateNormal];
        [_bottomNav addSubview:submitBtn];
    }
}


- (void)creatLineNav{
    
    if (!_lineNav) {
        _lineNav =  [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-kTopHeight-kRealValue(84), kScreenWidth, kRealValue(40))];
        _lineNav.backgroundColor = [UIColor colorWithHexString:@"#F9FAFB"];
        [self.view addSubview:_lineNav];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(kRealValue(19),kRealValue(12.5),kRealValue(30),kRealValue(15));
        label.text = @" 返佣 ";
        label.backgroundColor = [UIColor colorWithHexString:@"#FD5D3A"];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFontValue(11)];
        label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentLeft;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = kRealValue(3);
        [_lineNav addSubview:label];
        
        UILabel *titleLabel =  [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(kRealValue(54),kRealValue(12.5),kRealValue(243),kRealValue(15));
        titleLabel.text = self.sumbitModel.orderDisCountTip;
        titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFontValue(11)];
        titleLabel.textColor = [UIColor colorWithHexString:@"#6E6E6E"];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [_lineNav addSubview:titleLabel];
        
        
       UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(85), 0, kRealValue(70), kRealValue(40))];
        btn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        btn.userInteractionEnabled = YES;
        [btn setTarget:self action:@selector(pushLevel) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"leve_desc_arrow"] forState:UIControlStateNormal];
        [btn setTitle:@"去升级" forState:UIControlStateNormal];
         [btn setTitleColor:[UIColor colorWithHexString:@"#FF5100"] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, - btn.imageView.image.size.width +kRealValue(5), 0, btn.imageView.image.size.width)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width-kRealValue(5), 0, -btn.titleLabel.bounds.size.width+kRealValue(0))];
        [_lineNav addSubview:btn];
        

        
        if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"4"]) {
            btn.hidden = YES;
        }else{
           btn.hidden = NO;
        }
        
        
        if ([self.sumbitModel.orderType isEqualToString:@"VIP_ORDER"]) {
            _lineNav.hidden = YES;
        }else{
            _lineNav.hidden = NO;
        }
        
    }
}

- (void)pushLevel{
    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
        self.tabBarController.selectedIndex = 2;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        MHTaskVC *vc = [[MHTaskVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }

  
}



-(void)submit{
    NSMutableDictionary *dict =  [NSMutableDictionary dictionary];
    //产品
    [dict setObject:_arr forKey:@"products"];
    //支付方式
    if (_selectPay == 0) {
        [dict setObject:@"WXPAY" forKey:@"payType"];
    }else if (_selectPay == 1){
       [dict setObject:@"ALIPAY" forKey:@"payType"];
    }else if (_selectPay == 2){
      [dict setObject:@"BALANCEPAY" forKey:@"payType"];
    }
    //购物车id
    if ([self.cartIdArr count]>0) {
      [dict setObject:self.cartIdArr forKey:@"cartIds"];
    }
    NSMutableArray *message = [NSMutableArray array];
    [message removeAllObjects];
    for (int i = 0; i < [self.liuyanArr count]; i++) {
        NSMutableDictionary *messageDict  = [NSMutableDictionary dictionary];
        [messageDict setObject:self.liuyanArr[0] forKey:@"leaveMessage"];
        [messageDict setObject:[NSString stringWithFormat:@"%@",self.sellerId[0]] forKey:@"sellerId"];
        [message addObject:messageDict];
    }
    [dict setObject:message forKey:@"orderLeaveMessages"];
    
    if (ValidStr(self.adress.userName)) {
         [dict setObject:self.adress.addressId forKey:@"addressId"];
    }else{
        if (ValidStr(self.sumbitModel.userName)) {
            [dict setObject:self.sumbitModel.addressId forKey:@"addressId"];
        }else{
            KLToast(@"请选择收货地址")
            return;
        }
    }

    //总价格
    [dict setObject: self.sumbitModel.orderTruePrice forKey:@"orderTruePrice"];

    if (_selectPay == 2) {
        
        [[MHUserService sharedInstance] initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.mobiDict  = response[@"data"];
                if ([[NSString stringWithFormat:@"%@",self.mobiDict [@"modifyPayPassword"]] isEqualToString:@"0"]) {
                    
                    MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"请先设置资金密码" ];
                    alertVC.messageAlignment = NSTextAlignmentCenter;
                    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
                        [alertVC showDisappearAnimation];

                    }];
                    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"去设置" handler:^(CKAlertAction *action) {
                        [alertVC showDisappearAnimation];
                        MHSetPsdVC *vc = [[MHSetPsdVC alloc] init];
                        vc.navtitle =@"设置资金密码";
                        vc.dic = self.mobiDict;
                        [self.navigationController pushViewController:vc animated:YES];
                    }];
                    [alertVC addAction:cancel];
                    [alertVC addAction:sure];
                    [self presentViewController:alertVC animated:NO completion:nil];
         
                    
                }else{
                    self.passwordView = [[CYPasswordView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) WithMoneyStr:@"123"];
                    self.passwordView.loadingText = @"陌币支付中...";
                    self.passwordView.moneyStr = [NSString stringWithFormat:@"¥%@",self.sumbitModel.orderTruePrice];
                    self.passwordView.title = @"未来商视支付";
                    [self.passwordView showInView:self.view.window];
                    kWeakSelf(self);
                    self.passwordView.finish = ^(NSString *password) {
                        [weakself.passwordView hideKeyboard];
//                        [weakself.passwordView startLoading];
                        [dict setObject:password forKey:@"payPassword"];
                        [[MHUserService sharedInstance]initwithUserStateCompletionBlock:^(NSDictionary *response, NSError *error) {
                            if (ValidResponseDict(response)){
                                [[MHUserService sharedInstance]initwithSumitOrder:dict completionBlock:^(NSDictionary *response, NSError *error) {
                                    if (ValidResponseDict(response)) {
                                        //                                [weakself.passwordView requestComplete:YES message:@"支付成功"];
                                        //                                [weakself.passwordView stopLoading];
                                        KLToast(@"支付成功");
                                        
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            //push
                                            [weakself.passwordView hide];
                                            MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                                            vc.stateStr = @"success";
                                            vc.commissionProfit = self.sumbitModel.orderCommissionProfit;
                                            vc.orderTruePrice = self.sumbitModel.orderTruePrice;
                                            vc.orderCode = [NSString stringWithFormat:@"%@",response[@"data"][@"orderCode"]];
                                            vc.orderId = [response[@"data"][@"orderId"] integerValue];
                                            [self.navigationController pushViewController:vc animated:YES];
                                            if ([self.sumbitModel.orderType isEqualToString:@"VIP_ORDER"]) {
                                                vc.orderType = @"VIP_ORDER";
                                            }
                                            
                                        });
                                    }else{
                                        //                                [weakself.passwordView requestComplete:NO message:response[@"message"]];
                                        //                                [weakself.passwordView stopLoading];
                                        KLToast(response[@"message"]);
                                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                            [weakself.passwordView hide];
                                        });
                                    }
                                }];
                            }
                        }];
  
                    };
                }
         
            }
        }];
   
        
    }else{
        [MBProgressHUD showActivityMessageInWindow:@"正在支付中"];
        [[MHUserService sharedInstance]initwithUserStateCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                [[MHUserService sharedInstance]initwithSumitOrder:dict completionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        //"orderId":982,"orderCode":"NC201810101631334331"
                        NSDictionary *order = response[@"data"];
                        NSString *payType = @"";
                        if (self.selectPay == 0) {
                            payType = @"WXPAY";
                        }else  if (self.selectPay == 1){
                            payType = @"ALIPAY";
                        }else{
                            payType = @"BALANCEPAY";
                        }
                        
                        //支付接口
                        [[MHUserService sharedInstance]initwithContinuePay:[order[@"orderId"] integerValue] payType:payType payPassword:@"" completionBlock:^(NSDictionary *response, NSError *error) {
                            [MBProgressHUD hideHUD];
                            if (ValidResponseDict(response)) {
                                if (self.selectPay == 0) {
                                    NSString *payParam = response[@"data"][@"orderPayParam"];
                                    NSData *jsonData = [payParam dataUsingEncoding:NSUTF8StringEncoding];
                                    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                                    [[MHPayClass sharedApi]wxPayWithPayParam:dict success:^(payresult ResultCode) {
                                        if (wxsuceess ==  ResultCode) {
                                            MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                                            vc.stateStr = @"success";
                                            vc.typeStr = @"WXPAY";
                                            vc.commissionProfit = self.sumbitModel.orderCommissionProfit;
                                            vc.orderTruePrice = self.sumbitModel.orderTruePrice;
                                            vc.orderCode = [NSString stringWithFormat:@"%@",order[@"orderCode"]];
                                            vc.orderId = [order[@"orderId"] integerValue];
                                            if ([self.sumbitModel.orderType isEqualToString:@"VIP_ORDER"]) {
                                                vc.orderType = @"VIP_ORDER";
                                            }
                                            [self.navigationController pushViewController:vc animated:YES];
                                            
                                        }else{
                                            MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                                            vc.stateStr = @"failure";
                                            vc.commissionProfit = self.sumbitModel.orderCommissionProfit;
                                            vc.orderCode = [NSString stringWithFormat:@"%@",order[@"orderCode"]];
                                            vc.orderTruePrice = self.sumbitModel.orderTruePrice;
                                            vc.orderId = [order[@"orderId"] integerValue];
                                            [self.navigationController pushViewController:vc animated:YES];
                                        }
                                        
                                    } failure:^(payresult ResultCode) {
                                        
                                        MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                                        vc.stateStr = @"failure";
                                        vc.commissionProfit = self.sumbitModel.orderCommissionProfit;
                                        vc.orderCode = [NSString stringWithFormat:@"%@",order[@"orderCode"]];
                                        vc.orderTruePrice = self.sumbitModel.orderTruePrice;
                                        vc.orderId = [order[@"orderId"] integerValue];
                                        [self.navigationController pushViewController:vc animated:YES];
                                    }];
                                }
                                if (self.selectPay == 1) {
                                    
                                    [[MHPayClass sharedApi]aliPayWithPayParam:response[@"data"][@"orderPayParam"] success:^(payresult code) {
                                        if (alipaysuceess ==  code) {
                                            MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                                            vc.stateStr = @"success";
                                             vc.typeStr = @"ALIPAY";
                                            vc.commissionProfit = self.sumbitModel.orderCommissionProfit;
                                            vc.orderTruePrice = self.sumbitModel.orderTruePrice;
                                            vc.orderCode = [NSString stringWithFormat:@"%@",order[@"orderCode"]];
                                            vc.orderId = [order[@"orderId"] integerValue];
                                            if ([self.sumbitModel.orderType isEqualToString:@"VIP_ORDER"]) {
                                                vc.orderType = @"VIP_ORDER";
                                            }
                                            [self.navigationController pushViewController:vc animated:YES];
                                        }else{
                                            MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                                            vc.stateStr = @"failure";
                                            vc.commissionProfit = self.sumbitModel.orderCommissionProfit;
                                            vc.orderTruePrice = self.sumbitModel.orderTruePrice;
                                            
                                            vc.orderCode = [NSString stringWithFormat:@"%@",order[@"orderCode"]];
                                            vc.orderId = [order[@"orderId"] integerValue];
                                            [self.navigationController pushViewController:vc animated:YES];
                                        }
                                    } failure:^(payresult code) {
                                        MHPayResultVC *vc = [[MHPayResultVC alloc] init];
                                        vc.stateStr = @"failure";
                                        vc.commissionProfit = self.sumbitModel.orderCommissionProfit;
                                        vc.orderTruePrice = self.sumbitModel.orderTruePrice;
                                        vc.orderCode = [NSString stringWithFormat:@"%@",order[@"orderCode"]];
                                        vc.orderId = [order[@"orderId"] integerValue];
                                        [self.navigationController pushViewController:vc animated:YES];
                                    }];
                                }
                            }
                        }];
                    }else{
                        [MBProgressHUD hideHUD];
                        KLToast(response[@"message"]);
                    }
                }];
            }
        }];
        
    }
    

}


-(void)changeState{
    
    _isDeploy = !_isDeploy;
    if (_isDeploy == YES) {
            [_footView.isDeployBtn setTitle:@"收起全部商品" forState:UIControlStateNormal];
    }else{
            [_footView.isDeployBtn setTitle:@"展开全部商品" forState:UIControlStateNormal];
    }
    [self.contentTableView reloadData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (_isDeploy) {
        return 2 + _shopArr.count;
    }else{
        return 3;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else{
        if (_isDeploy) {
            MHSumbitModel *model = _shopArr[section - 2];
             return  [model.products count];
        }else{
             return 1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        MHSumbitCoustomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHSumbitCoustomCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 1){
        MHSumbitCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHSumbitCouponCell class])];
        cell.leftImageView.image = kGetImage(_picArr[indexPath.row]);
        cell.titleLabel.text = _titleArr[indexPath.row];
        [cell.selectBtn setImage:kGetImage(@"ic_choice_unselect") forState:UIControlStateDisabled];
        [cell.selectBtn setImage:kGetImage(@"ic_choice_unselect_border") forState:UIControlStateNormal];
        [cell.selectBtn setImage:kGetImage(@"ic_choice_select") forState:UIControlStateSelected];
        if ([self.sumbitModel.availableBalance doubleValue] >=  [self.sumbitModel.orderTruePrice doubleValue]) {
              cell.selectBtn.enabled = YES;
            if (indexPath.row == _selectPay) {
                cell.selectBtn.selected = YES;
            }else{
                cell.selectBtn.selected = NO;
            }
        }else{
            
            if (indexPath.row == 2) {
                cell.selectBtn.selected = NO;
                cell.selectBtn.enabled = NO;
            }else{

                if (indexPath.row == _selectPay) {
                    cell.selectBtn.selected = YES;
                }else{
                     cell.selectBtn.selected = NO;
                }
                cell.selectBtn.enabled = YES;
            }
        }

        if(indexPath.row == 0){
            cell.footLabel.text = @"亿万用户的选择，更快更安全";
        }else if (indexPath.row == 1){
            cell.footLabel.text = @"安全快捷，可支持银行卡支付";
        }else{
            
            cell.footLabel.text = [NSString stringWithFormat:@"陌币余额¥%@",_sumbitModel.availableBalance];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        MHSumbitModel *model = _shopArr[indexPath.section -2];
        NSDictionary *detailDict  = model.products[indexPath.row];
        MHOrderProCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHOrderProCell class])];
        cell.dataDict = detailDict;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        if (indexPath.row == 2) {
            if ([self.sumbitModel.availableBalance doubleValue] <   [self.sumbitModel.orderTruePrice doubleValue]) {
                return;
            }
        }
        _selectPay = indexPath.row;
        [UIView performWithoutAnimation:^{
            [_contentTableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
        }];

    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0 || section == 1) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(42))];
        headView.backgroundColor = kBackGroudColor;
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kScreenWidth, kRealValue(42))];
        if (section == 0) {
            headLabel.text = @"优惠券";
        }else{
            headLabel.text = @"选择支付方式";
        }
        headLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        headLabel.textColor = [UIColor blackColor];
        [headView addSubview: headLabel];
        
        return headView;
    }else{
        MHSumbitProView *headView  = [[MHSumbitProView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(40))];
        MHSumbitModel *model = _shopArr[section -2];
        headView.titleLabel.text = model.sellerName;
        [headView.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.sellerIcon] placeholderImage:nil];
        return headView;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 ||indexPath.section == 0) {
          return kRealValue(64);
    }
       return kRealValue(110);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else if (section == 1) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(42))];
        headView.backgroundColor = kBackGroudColor;
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kScreenWidth, kRealValue(42))];
        headLabel.text = @"已购商品";
        headLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        headLabel.textColor = [UIColor blackColor];
        [headView addSubview: headLabel];
        return headView;
    }else{
        MHSumbitMessageView *view  = [[MHSumbitMessageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(51))];
        view.textView.text = self.liuyanArr[section-2];
        view.textView.tag = 4444 + section -2;
        view.textView.delegate = self;
        return view;
    }
    return nil;
}

-(void)textViewDidChange:(YYTextView *)textView{
    _liuyanArr[textView.tag -4444]   = textView.text ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
        return CGFLOAT_MIN;
    }else if (section == 1) {
        return kRealValue(42);
    }else{
        return kRealValue(51);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return kRealValue(42);
    }
    return kRealValue(40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cancel {
    MHLog(@"关闭密码框");
//    [MBProgressHUD showSuccess:@"关闭密码框"];
}

- (void)forgetPWD {
    MHLog(@"忘记密码");
    [self.passwordView hide];
    MHSetPsdVC *vc = [[MHSetPsdVC alloc] init];
    vc.navtitle =@"修改资金密码";
    vc.dic = self.mobiDict;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
