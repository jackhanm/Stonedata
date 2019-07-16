//
//  MHChildOrderViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHChildOrderViewController.h"
#import "MHChildOrderTableViewCell.h"
#import "MHOrderDetailViewController.h"
#import "MHMyOrderModel.h"
#import "MHMyOrderListModel.h"
#import "MHNetworkErrorPlaceHolder.h"
#import "MHNoDataPlaceHolder.h"
#import "UIControl+BlocksKit.h"
#import "MHCustomerServiceVC.h"
#import "MHMineProductCommentController.h"
#import "MHProDetailViewController.h"
#import "MHContinuePayVC.h"

@interface MHChildOrderViewController ()<UITableViewDataSource, UITableViewDelegate,CYLTableViewPlaceHolderDelegate, MHNetworkErrorPlaceHolderDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, copy) NSString  *indexId;
@property (nonatomic, assign) NSInteger  index;

@end

@implementation MHChildOrderViewController

static NSString * const MHChildOrderViewCellId = @"MHChildOrderViewCellId";



- (instancetype)initWithId:(NSString *)indexId {
    if (self = [super init]) {
        _indexId  = indexId;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F7F8FA"];
    _index = 1;
    _listArr = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    _tableView.mj_header = [MHRefreshNomalHeader headerWithRefreshingBlock:^{
        self.index = 1;
        [self getData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.index ++;
        [self getData];
    }];
    
}


- (UIView *)makePlaceHolderView {

    if ([[MHBaseClass sharedInstance]isErrorNetWork]) {
        UIView *errorNetWork = [self MHNetworkErrorPlaceHolder];
        return errorNetWork;
    }else{
        UIView *noData = [self MHNoDataPlaceHolder];
        return noData;
    }

}


- (UIView *)MHNetworkErrorPlaceHolder {
    MHNetworkErrorPlaceHolder *networkErrorPlaceHolder = [[MHNetworkErrorPlaceHolder alloc] initWithFrame:self.tableView.frame];
    networkErrorPlaceHolder.delegate = self;
    return networkErrorPlaceHolder;
}

- (UIView *)MHNoDataPlaceHolder {
    MHNoDataPlaceHolder *networkErrorPlaceHolder = [[MHNoDataPlaceHolder alloc] initWithFrame:self.tableView.frame];
    return networkErrorPlaceHolder;
}








- (void)emptyOverlayClicked:(id)sender {
    self.index = 1;
    [self getData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.index = 1;
    [self getData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kTopHeight- 44);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.sectionHeaderHeight= 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[MHChildOrderTableViewCell class] forCellReuseIdentifier:MHChildOrderViewCellId];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        

    }
    return _tableView;
}



- (void)getData{
    
    [[MHUserService sharedInstance]initwithMyorder:_indexId pageIndex:self.index pageSize:10 completionBlock:^(NSDictionary *response, NSError *error) {
        
        if (ValidResponseDict(response)) {
            if (self.index == 1) {
                [self.listArr removeAllObjects];
            }
            [self.listArr  addObjectsFromArray:[MHMyOrderListModel baseModelWithArr:response[@"data"][@"list"]]];
            [self.tableView cyl_reloadData];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
        if (error) {
            [self.tableView cyl_reloadData];
        }
    }];
}


-(void)endRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
    [_tableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _listArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     MHMyOrderListModel *model = _listArr[section];
     return [model.products count];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(128);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHChildOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MHChildOrderViewCellId];
    MHMyOrderListModel *model = _listArr[indexPath.section];
    [cell createListModel:model.products[indexPath.row]];
    cell.superVC = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MHMyOrderListModel *model = _listArr[indexPath.section];
    MHOrderDetailViewController *vc = [[MHOrderDetailViewController alloc] init];
    vc.orderId  = model.orderId;
    
    [self.navigationController pushViewController:vc animated:YES];

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(41))];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(10), kRealValue(10), kRealValue(355), kRealValue(31))];
    headView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:headView];
    UILabel *dingdanLabel = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(17), 0, kRealValue(200), kRealValue(31))];
    dingdanLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
    dingdanLabel.textColor =[UIColor colorWithHexString:@"#666666"];
    dingdanLabel.numberOfLines = 1;
    [headView addSubview:dingdanLabel];
    
    UILabel *stateLabel = [[UILabel alloc]init];
    stateLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    stateLabel.textColor =[UIColor colorWithHexString:@"#FF5100"];
    stateLabel.textAlignment = NSTextAlignmentRight;
    [headView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top).with.offset(0);
        make.right.equalTo(headView.mas_right).with.offset(-kRealValue(14));
        make.height.mas_equalTo(kRealValue(31));
    }];
    
    UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16), kRealValue(30), kRealValue(325), 1/kScreenScale)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    [headView addSubview:lineView];
    
    MHMyOrderListModel *model = _listArr[section];
    dingdanLabel.text  = [NSString stringWithFormat:@"交易编号:%@",model.orderCode];
    if ([model.orderTradeState isEqualToString:@"CLOSED"]) {
        stateLabel.text = @"已关闭";
    }else{
        if ([model.orderState isEqualToString:@"UNPAID"]) {
            stateLabel.text = @"待付款";
        }else if ([model.orderState isEqualToString:@"UNDELIVER"]){
            stateLabel.text = @"待发货";
        }else if ([model.orderState isEqualToString:@"UNRECEIPT"]){
            stateLabel.text = @"待收货";
        }else if ([model.orderState isEqualToString:@"UNEVALUATED"]){
            stateLabel.text = @"待评价";
        }else if ([model.orderState isEqualToString:@"COMPLETED"]){
            if ([model.orderTradeState isEqualToString:@"COMPLETED"]) {
                stateLabel.text = @"已完成";
            }else{
                stateLabel.text = @"已完成";
            }
            
        }else if ([model.orderState isEqualToString:@"RETURN_GOOD"]){
            stateLabel.text = @"退换货";
        }
    }
    
    return  bgView;
    
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(75))];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(10), 0, kRealValue(355), kRealValue(75))];
    footerView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:footerView];
    
    
    UILabel *pricelabel = [[UILabel alloc]init];
    pricelabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    pricelabel.textColor =[UIColor colorWithHexString:@"#E51C23"];
    [footerView addSubview:pricelabel];
    [pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView.mas_top).with.offset(0);
        make.right.equalTo(footerView.mas_right).with.offset(-kRealValue(14));
    }];
    
    
    
    UILabel *alllabel = [[UILabel alloc]init];
    alllabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
    alllabel.textColor =[UIColor colorWithHexString:@"333333"];
    [footerView addSubview:alllabel];
    [alllabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView.mas_top).with.offset(kRealValue(22));
        make.right.equalTo(footerView.mas_right).with.offset(-kRealValue(14));
    }];
    
    UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16), kRealValue(43), kRealValue(325), 1/kScreenScale)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    [footerView addSubview:lineView];
    
    UILabel *dataLabel = [[UILabel alloc]init];
    dataLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
    dataLabel.textColor =[UIColor colorWithHexString:@"#999999"];
    [footerView addSubview:dataLabel];
    [dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(footerView.mas_bottom).with.offset(-kRealValue(10));
        make.left.equalTo(footerView.mas_left).with.offset(kRealValue(17));
    }];


    UIButton *rightBtn = [[UIButton alloc] init];
    rightBtn.backgroundColor =  [UIColor whiteColor];
    ViewBorderRadius(rightBtn, kRealValue(2.5),1/kScreenScale, [UIColor colorWithHexString:@"#E51C23"]);
    rightBtn.userInteractionEnabled = YES;

    rightBtn.titleLabel.font =  [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"#E51C23"] forState:UIControlStateNormal];
    rightBtn.hidden = YES;
    rightBtn.layer.masksToBounds = YES;
    [footerView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(footerView.mas_bottom).with.offset(-kRealValue(6));
        make.right.equalTo(footerView.mas_right).with.offset(-kRealValue(14));
        make.size.mas_equalTo(CGSizeMake(kRealValue(71), kRealValue(22)));
    }];

    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.userInteractionEnabled = YES;

    leftBtn.backgroundColor =  [UIColor whiteColor];
    [leftBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    leftBtn.titleLabel.font =  [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    leftBtn.hidden = YES;
    leftBtn.layer.masksToBounds = YES;
    ViewBorderRadius(leftBtn, kRealValue(2.5), 1/kScreenScale, [UIColor colorWithHexString:@"#333333"]);
    [footerView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(footerView.mas_bottom).with.offset(-kRealValue(6));
        make.right.equalTo(rightBtn.mas_left).with.offset(-kRealValue(6));
        make.size.mas_equalTo(CGSizeMake(kRealValue(71), kRealValue(22)));
    }];
    
    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
        pricelabel.hidden = YES;
    }else{
        pricelabel.hidden = NO;
    }
    

    
    MHMyOrderListModel *model = _listArr[section];
    dataLabel.text = [NSString stringWithFormat:@"%@  %@",model.createDate,model.createTime];
    NSString *moneyStr = [NSString stringWithFormat:@"￥%@",model.orderTruePrice];
    NSMutableAttributedString *integralStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"共%ld件商品  合计：%@",model.totalProducts,moneyStr]];
  
    [integralStr addAttribute:NSFontAttributeName value:  [UIFont fontWithName:kPingFangRegular size:kFontValue(14)] range:NSMakeRange(0,[integralStr length] - [moneyStr length])];
    alllabel.attributedText = integralStr;
    
    NSString *priceStr = [NSString stringWithFormat:@"¥%@",model.commissionProfit];
    NSMutableAttributedString *priceMutableStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"可赚：%@",priceStr]];
    [priceMutableStr addAttribute:NSFontAttributeName value:  [UIFont fontWithName:kPingFangRegular size:kFontValue(14)] range:NSMakeRange(0,[priceMutableStr length] - [priceStr length])];
    
    pricelabel.attributedText = priceMutableStr;
    
    
    
    if ([model.orderTradeState isEqualToString:@"CLOSED"]) {
        leftBtn.hidden = YES;
        rightBtn.hidden = NO;
        [rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
//        [rightBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        rightBtn.userInteractionEnabled = YES;
    }else{
        if ([model.orderState isEqualToString:@"UNPAID"]) {
            leftBtn.hidden = NO;
            rightBtn.hidden = NO;
            [leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [rightBtn setTitle:@"去支付" forState:UIControlStateNormal];
            rightBtn.userInteractionEnabled = YES;
        }else if ([model.orderState isEqualToString:@"UNDELIVER"]){
            leftBtn.hidden = YES;
            rightBtn.hidden = YES;
            rightBtn.userInteractionEnabled = YES;
        }else if ([model.orderState isEqualToString:@"UNRECEIPT"]){
            leftBtn.hidden = YES;
            rightBtn.hidden = NO;
            [rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            rightBtn.userInteractionEnabled = YES;
        }else if ([model.orderState isEqualToString:@"UNEVALUATED"]){
            leftBtn.hidden = NO;
            rightBtn.hidden = NO;
            [leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            [rightBtn setTitle:@"立即评价" forState:UIControlStateNormal];
            rightBtn.userInteractionEnabled = YES;
        }else if ([model.orderState isEqualToString:@"COMPLETED"]){
            if ([model.orderTradeState isEqualToString:@"COMPLETED"]) {
                leftBtn.hidden = YES;
                rightBtn.hidden = YES;
            }else{
                leftBtn.hidden = YES;
                rightBtn.hidden = NO;
                [rightBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            }
            
        }else if ([model.orderState isEqualToString:@"RETURN_GOOD"]){
            leftBtn.hidden = YES;
            rightBtn.hidden = NO;
            [rightBtn setTitle:@"查看进度" forState:UIControlStateNormal];
            rightBtn.userInteractionEnabled = YES;
        }
    }
    
    [leftBtn bk_addEventHandler:^(id sender) {
        
//        if ([model.orderTradeState isEqualToString:@"CLOSED"]) {
//            MHOrderDetailViewController *vc = [[MHOrderDetailViewController alloc] init];
//            vc.orderId  = model.orderId;
//            [self.navigationController pushViewController:vc animated:YES];
//
//        }else{
        
            if ([model.orderState isEqualToString:@"UNPAID"]) {
                
                MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"确认取消订单？" ];
                alertVC.messageAlignment = NSTextAlignmentCenter;
                CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
                    [alertVC showDisappearAnimation];
                    [[MHUserService sharedInstance]initwithCancleorder:model.orderId completionBlock:^(NSDictionary *response, NSError *error) {
                        if (ValidResponseDict(response)) {
                            self.index = 1;
                            [self getData];
                        }
                        
                    }];
                }];
                CKAlertAction *sure = [CKAlertAction actionWithTitle:@"我在想想" handler:^(CKAlertAction *action) {
                    [alertVC showDisappearAnimation];
                }];
                [alertVC addAction:cancel];
                [alertVC addAction:sure];
                [self presentViewController:alertVC animated:NO completion:nil];
                
            }else if ([model.orderState isEqualToString:@"UNEVALUATED"]){
                //push
                MHCustomerServiceVC *vc  = [[MHCustomerServiceVC alloc]init];
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
//        }
  
    } forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn bk_addEventHandler:^(id sender) {
        
        if ([model.orderTradeState isEqualToString:@"CLOSED"]) {
            MHOrderDetailViewController *vc = [[MHOrderDetailViewController alloc] init];
            vc.orderId  = model.orderId;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            if ([model.orderState isEqualToString:@"UNEVALUATED"]) {
                MHMineProductCommentController *vc  = [[MHMineProductCommentController alloc]initWithorderId:[NSString stringWithFormat:@"%ld",model.orderId]];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if ([model.orderState isEqualToString:@"UNDELIVER"]){
                MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"是否确认收货？" ];
                alertVC.messageAlignment = NSTextAlignmentCenter;
                CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
                    [alertVC showDisappearAnimation];
                    
                }];
                CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确认" handler:^(CKAlertAction *action) {
                    [alertVC showDisappearAnimation];
                    [[MHUserService sharedInstance]initwithOkorder:model.orderId completionBlock:^(NSDictionary *response, NSError *error) {
                        if (ValidResponseDict(response)) {
                            self.index = 1;
                            [self getData];
                        }
                        
                    }];
                }];
                [alertVC addAction:cancel];
                [alertVC addAction:sure];
                [self presentViewController:alertVC animated:NO completion:nil];
                
            }else if ([model.orderState isEqualToString:@"UNRECEIPT"]){
                
                MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"是否确认收货？" ];
                alertVC.messageAlignment = NSTextAlignmentCenter;
                CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
                    [alertVC showDisappearAnimation];
                    
                }];
                CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确认" handler:^(CKAlertAction *action) {
                    [alertVC showDisappearAnimation];
                    [[MHUserService sharedInstance]initwithOkorder:model.orderId completionBlock:^(NSDictionary *response, NSError *error) {
                        if (ValidResponseDict(response)) {
                            self.index = 1;
                            [self getData];
                        }
                        
                    }];
                }];
                [alertVC addAction:cancel];
                [alertVC addAction:sure];
                [self presentViewController:alertVC animated:NO completion:nil];
                
                
                
            }else if ([model.orderState isEqualToString:@"UNPAID"]) {
                MHContinuePayVC *vc = [[MHContinuePayVC alloc]init];
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }else if ([model.orderState isEqualToString:@"COMPLETED"]){
                //push
                MHCustomerServiceVC *vc  = [[MHCustomerServiceVC alloc]init];
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }else if ([model.orderState isEqualToString:@"RETURN_GOOD"]){
                MHOrderDetailViewController *vc = [[MHOrderDetailViewController alloc] init];
                vc.orderId  = model.orderId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }

        
    } forControlEvents:UIControlEventTouchUpInside];
    
    return bgView;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kRealValue(41);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kRealValue(75);
}




@end
