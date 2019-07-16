//
//  MHOrderDetailViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHOrderDetailViewController.h"
#import "MHOrderDetailTableViewCell.h"
#import "MHAddressTableViewCell.h"
#import "MHSumbitProView.h"
#import "MHSumbitModel.h"
#import "MHShopSumbitModel.h"
#import "MHOrderDetailView.h"
#import "MHOrderNormalTableViewCell.h"
#import "MHOrderServiceListCell.h"
#import "MHMyOrderViewController.h"
#import "MHProDetailViewController.h"

@interface MHOrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property(strong,nonatomic)UIView *headView;
//是否展开
@property (nonatomic,assign) BOOL     isDeploy;
@property(strong,nonatomic) MHShopSumbitModel *sumbitModel;
@property(strong,nonatomic)MHOrderDetailView *footView;
@property (nonatomic,strong) NSMutableArray  *shopArr;
@property (nonatomic,strong) NSArray  *listArr;


@end
static NSString * const MHOrderDetailTableViewCellId = @"MHOrderDetailTableViewCellId";
static NSString * const MHOrderNormalTableViewCellId = @"MHOrderNormalTableViewCellId";
static NSString * const MHAddressTableViewCellId = @"MHAddressTableViewCellId";

@implementation MHOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    _isDeploy = NO;
    self.view.backgroundColor = [UIColor whiteColor];
   
    [[MHUserService sharedInstance]initwithorderDetail:_orderId completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.shopArr  =  [MHSumbitModel baseModelWithArr:response[@"data"][@"shops"]];
            self.sumbitModel = [MHShopSumbitModel baseModelWithDic:response[@"data"]];
            //退换货 对话
            [[MHUserService sharedInstance]initwithServiceList:self.orderId completionBlock:^(NSDictionary *response, NSError *error) {
                    if (ValidResponseDict(response)) {
                        self.listArr = response[@"data"];
                        [self.view addSubview:self.tableView];
                    }
                }];
        }
    }];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.sectionHeaderHeight= 0;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
        _tableView.tableHeaderView = self.headView;
        NSString *payType = @"";
        if ([self.sumbitModel.payType isEqualToString:@"WXPAY"]) {
            payType = @"微信支付";
        }else  if ([self.sumbitModel.payType isEqualToString:@"ALIPAY"]){
             payType = @"支付宝";
        }else{
            payType = @"陌币支付";
        }
//        ,
        _footView = [[MHOrderDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(450)) withTitleArr:@[[NSString stringWithFormat:@"%@件",self.sumbitModel.productCount],[NSString stringWithFormat:@"%@元",self.sumbitModel.orderPrice],[NSString stringWithFormat:@"%@元",self.sumbitModel.orderSendPrice],[NSString stringWithFormat:@"-%@元",self.sumbitModel.orderDiscountPrice],[NSString stringWithFormat:@"%@元",self.sumbitModel.orderTruePrice]] withMoney:[NSString stringWithFormat:@"%@元",self.sumbitModel.orderCommissionProfit] withContent:@[[NSString stringWithFormat:@"%@",self.sumbitModel.orderCode],payType,[NSString stringWithFormat:@"%@",self.sumbitModel.payTime]]];
        
        _tableView.tableFooterView = _footView;
        [_footView.isDeployBtn addTarget: self action:@selector(changeState) forControlEvents:UIControlEventTouchUpInside];
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerClass:[MHOrderDetailTableViewCell class] forCellReuseIdentifier:MHOrderDetailTableViewCellId];
        [_tableView registerClass:[MHOrderNormalTableViewCell class] forCellReuseIdentifier:MHOrderNormalTableViewCellId];
         [_tableView registerClass:[MHAddressTableViewCell class] forCellReuseIdentifier:MHAddressTableViewCellId];
         [_tableView registerClass:[MHOrderServiceListCell class] forCellReuseIdentifier:NSStringFromClass([MHOrderServiceListCell class])];

        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}


-(void)changeState{
    
    _isDeploy = !_isDeploy;
    if (_isDeploy == YES) {
        [_footView.isDeployBtn setTitle:@"收起全部商品" forState:UIControlStateNormal];
    }else{
        [_footView.isDeployBtn setTitle:@"展开全部商品" forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
    
}

-(UIView *)headView{
    
    if (!_headView) {
        _headView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(89))];
        _headView.backgroundColor = [UIColor colorWithHexString:@"F7F8FA"];
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(79))];
        contentView.backgroundColor = [UIColor colorWithHexString:@"#D71313"];
        [_headView addSubview:contentView];
        
        UILabel *xuLabel = [[UILabel alloc]init];
        xuLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        xuLabel.textColor =[UIColor colorWithHexString:@"FFFFFF"];
        [contentView addSubview:xuLabel];
        [xuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top).with.offset(kRealValue(31));
            make.right.equalTo(contentView.mas_right).with.offset(-kRealValue(16));
        }];
        xuLabel.hidden = YES;
        
        
        YYLabel *foot1Label = [YYLabel new];
        foot1Label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        foot1Label.textColor =[UIColor colorWithHexString:@"FFFFFF"];
        [contentView addSubview:foot1Label];
        [foot1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top).with.offset(kRealValue(25));
            make.right.equalTo(contentView.mas_right).with.offset(-kRealValue(16));
        }];
        
        UIImage *image = [UIImage imageNamed:@"ic_kuaidi_logo"];
        NSMutableAttributedString *attachment = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeScaleToFill attachmentSize:CGSizeMake(16, 16) alignToFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(13)] alignment:YYTextVerticalAlignmentCenter];
        NSMutableAttributedString *errorDesc = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_sumbitModel.expressType]];
        errorDesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        errorDesc.color = [UIColor colorWithHexString:@"ffffff"];
        [attachment appendAttributedString: errorDesc];
        foot1Label.attributedText = attachment;
        
        
        NSString *desc = [NSString stringWithFormat:@"%@ | 复制",_sumbitModel.expressCode];
        NSMutableAttributedString *textdesc = [[NSMutableAttributedString alloc] initWithString:desc];
        textdesc.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        textdesc.color = [UIColor colorWithHexString:@"ffffff"];
        [textdesc setTextHighlightRange:[desc rangeOfString:@"复制"]
                                  color:[UIColor colorWithHexString:@"ffffff"]
                        backgroundColor:[UIColor colorWithHexString:@"ffffff"]
                              tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                  UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                                  pasteboard.string = self.sumbitModel.expressCode;
                                  KLToast(@"复制成功");
                              }];
        YYLabel *foot2Label = [YYLabel new];
        foot2Label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        foot2Label.textColor =[UIColor colorWithHexString:@"FFFFFF"];
        [contentView addSubview:foot2Label];
        [foot2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top).with.offset(kRealValue(40));
            make.right.equalTo(contentView.mas_right).with.offset(-kRealValue(16));
            make.height.mas_equalTo(kRealValue(20));
        }];
        foot2Label.attributedText = textdesc;
        
        foot1Label.hidden = YES;
        foot2Label.hidden = YES;

        //订单状态
        UILabel *stateLabel = [[UILabel alloc]init];
        stateLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(18)];
        stateLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        
        if ([_sumbitModel.orderState isEqualToString:@"UNPAID"]) {
            stateLabel.text = @"待付款";
            self.title = @"待付款";
            xuLabel.hidden = NO;
            xuLabel.text = [NSString stringWithFormat:@"需付款：￥%@",_sumbitModel.orderTruePrice];
            foot1Label.hidden = YES;
            foot2Label.hidden = YES;
        }else if ([_sumbitModel.orderState isEqualToString:@"UNDELIVER"]){
            stateLabel.text = @"待发货";
            xuLabel.hidden = NO;
            self.title = @"待发货";
            foot1Label.hidden = YES;
            foot2Label.hidden = YES;
            
        }else if ([_sumbitModel.orderState isEqualToString:@"UNRECEIPT"]){
            stateLabel.text = @"待收货";
            self.title = @"待收货";
            foot1Label.hidden = NO;
            foot2Label.hidden = NO;
        }else if ([_sumbitModel.orderState isEqualToString:@"UNEVALUATED"]){
            stateLabel.text = @"待评价";
            self.title =@"待评价";
            foot1Label.hidden = NO;
            foot2Label.hidden = NO;
        }else if ([_sumbitModel.orderState isEqualToString:@"COMPLETED"]){
            stateLabel.text = @"已完成";
            self.title = @"已完成";
            foot1Label.hidden = NO;
            foot2Label.hidden = NO;
        }else if ([_sumbitModel.orderState isEqualToString:@"RETURN_GOOD"]){
            stateLabel.text = @"退换货";
            self.title = @"退换货";
            contentView.backgroundColor = [UIColor colorWithHexString:@"#2AB1AC"];
            foot1Label.hidden = NO;
            foot2Label.hidden = NO;
            UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [moreBtn setTitle:@"联系客服" forState:UIControlStateNormal];
            [moreBtn setFrame:CGRectMake(5,0,kRealValue(70),kRealValue(30))];
            [moreBtn setTitleColor:[UIColor colorWithHexString:@"689DFF"] forState:UIControlStateNormal];
            [moreBtn.titleLabel setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
            [moreBtn addTarget:self action:@selector(withDrawListClick) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
        }
        
        [contentView addSubview:stateLabel];
        [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top).with.offset(kRealValue(29));
            make.left.equalTo(contentView.mas_left).with.offset(kRealValue(16));
        }];
    }
    return _headView;
}


- (void)withDrawListClick{
    MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"确认拨打4000518180？" ];
    alertVC.messageAlignment = NSTextAlignmentCenter;
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
        [alertVC showDisappearAnimation];


    }];
    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确认" handler:^(CKAlertAction *action) {
        [alertVC showDisappearAnimation];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4000518180"]];
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    [self.navigationController presentViewController:alertVC animated:NO completion:nil];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isDeploy) {
        return 1 + _shopArr.count;
    }else{
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ([_sumbitModel.orderState isEqualToString:@"RETURN_GOOD"]) {
             return [self.listArr count];
        }else{
             return 1;
        }

    }else if (section == 1){
        if (_isDeploy) {
            MHSumbitModel *model = _shopArr[section - 1];
            return  [model.products count];
        }else{
            return 1;
        }
    }
     return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if ([_sumbitModel.orderState isEqualToString:@"RETURN_GOOD"]) {
             return  [_listArr[indexPath.row][@"progress"] heightForFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(13)] width:kRealValue(249)] + kRealValue(30);
        }else{
            return kRealValue(91);
        }
 
    }
      return kRealValue(140);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if ([_sumbitModel.orderState isEqualToString:@"RETURN_GOOD"]) {
            MHOrderServiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHOrderServiceListCell class])];
            cell.dict = _listArr[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            MHAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MHAddressTableViewCellId];
            cell.nameLabel.text = [NSString stringWithFormat:@"收货人：%@",self.sumbitModel.userName];
            cell.phoneLabel.text = self.sumbitModel.userPhone;
            cell.addressLabel.text = [NSString stringWithFormat:@"收货地址：%@ %@ %@ %@",self.sumbitModel.province,self.sumbitModel.city,self.sumbitModel.area,self.sumbitModel.details];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
       
    }else{
        MHSumbitModel *model = _shopArr[indexPath.section -1];
        NSDictionary *detailDict  = model.products[indexPath.row];
        MHOrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MHOrderDetailTableViewCellId];
        cell.dataDict = detailDict;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if ([_sumbitModel.orderState isEqualToString:@"RETURN_GOOD"]) {
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(42))];
            headView.backgroundColor = [UIColor whiteColor];
            UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), 0, kScreenWidth, kRealValue(42))];
            headLabel.text = @"进度反馈";
            headLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
            headLabel.textColor = [UIColor blackColor];
            [headView addSubview: headLabel];
            return headView;
            
        }else{
            return nil;
        }
    }
    if (section != 0) {
        MHSumbitProView *headView  = [[MHSumbitProView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(40))];
        MHSumbitModel *model = _shopArr[section -1];
        headView.titleLabel.text = model.sellerName;
        [headView.leftImageView sd_setImageWithURL:[NSURL URLWithString: model.sellerIcon] placeholderImage:nil];
        return headView;
    }else{
        return nil;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        if ([_sumbitModel.orderState isEqualToString:@"RETURN_GOOD"]) {
            return kRealValue(42);
        }
        return kRealValue(0);
        
    }
  return kRealValue(42);
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != 0) {
        return kRealValue(75);
    }else{
        return CGFLOAT_MIN;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section != 0) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(42))];
        headView.backgroundColor = [UIColor whiteColor];
        headView.layer.masksToBounds = YES;
        UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(10), kScreenWidth, kRealValue(20))];
        headLabel.text = @"留言：";
        headLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        headLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [headView addSubview: headLabel];
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(33), kRealValue(343), kRealValue(45))];
        MHSumbitModel  *model =   self.shopArr[section -1];
        if (ValidStr(model.leaveMessage )) {
            descLabel.text = model.leaveMessage;
        }else{
            descLabel.text = @"暂无留言";
        }
        
        descLabel.numberOfLines = 3;
        descLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        descLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [headView addSubview: descLabel];
        return headView;
    }else{
        return nil;
    }
}


- (void)backBtnClicked{
    if (ValidStr(self.type)) {
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MHProDetailViewController class]]) {
                MHProDetailViewController *revise =(MHProDetailViewController *)controller;
                [self.navigationController popToViewController:revise animated:YES];
                return;
            }
            if ([controller isKindOfClass:[MHMyOrderViewController class]]) {
                MHMyOrderViewController *revise =(MHMyOrderViewController *)controller;
                [self.navigationController popToViewController:revise animated:YES];
                return;
            }

        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
