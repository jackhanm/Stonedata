//
//  MHWithDrawVC.m
//  mohu
//
//  Created by AllenQin on 2018/10/6.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHWithDrawVC.h"
#import "MHWithDrawTitleCell.h"
#import "MHWithDrawMoneyCell.h"
#import "MHWithDrawPayCell.h"
#import "MHWithDrawListModel.h"
#import "MHAddWithDrawVC.h"
#import "CYPasswordView.h"
#import "MHRecordPresentViewController.h"
#import "MHRecordPresentStatuController.h"
#import "MHSetPsdVC.h"
#import "MHWithDrawRecordModel.h"


@interface MHWithDrawVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSArray       *listArr;
@property (nonatomic, assign) NSInteger     selectIndex;
@property (nonatomic, strong) NSMutableDictionary    *mobiDict;
@property (nonatomic, strong) CYPasswordView *passwordView;
@property (nonatomic, assign) BOOL          editState;
@end

@implementation MHWithDrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
    _selectIndex = -1;
    _editState  = NO;
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancel) name:@"CYPasswordViewCancleButtonClickNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPWD) name:@"CYPasswordViewForgetPWDButtonClickNotification" object:nil];
    [self.view addSubview:self.contentTableView];
    UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(16), kScreenHeight - kTopHeight - kRealValue(64)-kBottomHeight, kScreenWidth - kRealValue(32), kRealValue(44))];
    [btn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF8F00"],[UIColor colorWithHexString:@"FF5100"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    btn.titleLabel.font =[UIFont fontWithName:kPingFangMedium size:kFontValue(16)];
    [btn addTarget:self action:@selector(withDraw) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"确认提现" forState:UIControlStateNormal];
    ViewRadius(btn, 5);
    [self.view addSubview:btn];
    
    UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"提现记录" forState:UIControlStateNormal];
    [moreBtn setFrame:CGRectMake(5,0,kRealValue(70),kRealValue(30))];
    [moreBtn setTitleColor:[UIColor colorWithHexString:@"000000"] forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [moreBtn addTarget:self action:@selector(withDrawListClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
}



- (void)withDrawListClick{
    MHRecordPresentViewController *vc= [[MHRecordPresentViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[MHUserService sharedInstance]initwithShopWithDrawListCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.listArr = [MHWithDrawListModel baseModelWithArr:response[@"data"]];
            if ([self.listArr count]>0) {
                self.selectIndex = 0;
            }else{
                self.selectIndex = - 1;
            }
            [UIView performWithoutAnimation:^{
                [self.contentTableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                
            }];
            
        }
    }];
}

-(void)withDraw{
    
    if (_selectIndex == -1) {
        KLToast(@"请添加提现方式");
        return;
    }
    UITextField *textfield  =    [_contentTableView viewWithTag:6666];
    if (!ValidStr(textfield.text) ) {
        KLToast(@"请输入金额");
        return;
    }
    if ([textfield.text doubleValue]<=0 ) {
        KLToast(@"提现金额须大于0");
        return;
    }
    
    if ([textfield.text doubleValue]> [self.withDrawMoney doubleValue] ) {
        KLToast(@"余额不足");
        return;
    }
    
    [[MHUserService sharedInstance] initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.mobiDict  = response[@"data"];
            if ([[NSString stringWithFormat:@"%@",self.mobiDict [@"modifyPayPassword"]] isEqualToString:@"0"]) {
                MHSetPsdVC *vc = [[MHSetPsdVC alloc] init];
                vc.navtitle =@"设置资金密码";
                vc.dic = self.mobiDict;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                
                MHWithDrawListModel *model  =    _listArr[_selectIndex];
                self.passwordView = [[CYPasswordView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) WithMoneyStr:@"123"];
                self.passwordView.loadingText = @"陌币支付中...";
                self.passwordView.moneyStr = [NSString stringWithFormat:@"%@陌币",textfield.text];
                self.passwordView.title = @"陌币提现";
                [self.passwordView showInView:self.view.window];
                kWeakSelf(self);
                self.passwordView.finish = ^(NSString *password) {
                    [weakself.passwordView hideKeyboard];
//                    [weakself.passwordView startLoading];
                    //        CYLog(@"cy ========= 发送网络请求  pwd=%@", password);
                    
                    
                    [[MHUserService sharedInstance]initwithWithdraw:textfield.text cardId:[NSString stringWithFormat:@"%ld",(long)model.cardId] payPassword:password completionBlock:^(NSDictionary *response, NSError *error) {
                        if (ValidResponseDict(response)) {
//                            [weakself.passwordView requestComplete:YES message:@"支付成功"];
//                            [weakself.passwordView stopLoading];
                             KLToast(@"提现成功");
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                //push
                                MHRecordPresentStatuController *vc = [[MHRecordPresentStatuController alloc]init];
                                vc.rootStr = @"root";
                                MHWithDrawRecordModel *model = [[MHWithDrawRecordModel alloc] init];
                                model.status = 0;
                                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                                NSDate *datenow = [NSDate date];
                                NSString *currentTimeString = [formatter stringFromDate:datenow];
                                
                                model.progress = @[@{@"state": @"提现申请提交成功",@"msg": @"请等待后台审核",@"stateTime": currentTimeString},@{@"state": @"审核通过",@"msg": @"",@"stateTime": @""}];
                                vc.model = model;
                                [self.navigationController pushViewController:vc animated:YES];
                                [weakself.passwordView hide];
                            });
                        }else{
//                            [weakself.passwordView requestComplete:NO message:response[@"message"]];
//                            [weakself.passwordView stopLoading];
                             KLToast(response[@"message"]);
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [weakself.passwordView hide];
                            });
                        }
                    }];
                    
                };
            }
            
        }
    }];
    
}

-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight  -kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor clearColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kRealValue(60), 0);
        [_contentTableView registerClass:[MHWithDrawTitleCell class] forCellReuseIdentifier:NSStringFromClass([MHWithDrawTitleCell class])];
        [_contentTableView registerClass:[MHWithDrawMoneyCell class] forCellReuseIdentifier:NSStringFromClass([MHWithDrawMoneyCell class])];
        [_contentTableView registerClass:[MHWithDrawPayCell class] forCellReuseIdentifier:NSStringFromClass([MHWithDrawPayCell class])];
//        [_contentTableView registerClass:[MHTaskCell class] forCellReuseIdentifier:MHTaskCellId];
//        [_contentTableView registerClass:[MHSXYCell class] forCellReuseIdentifier:MHSXYCellId];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16), kRealValue(15), kScreenWidth-kRealValue(32), kRealValue(52))];
        label.text = @"温馨提示\n本次提现预计在次月5日前完成打款流程。";
        label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        label.textColor = [UIColor colorWithHexString:@"#FB3131"];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        _contentTableView.tableFooterView =  label;
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return  _listArr.count;
    }
    return 1;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MHWithDrawTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHWithDrawTitleCell class])];
        cell.moneyLabel.text = self.withDrawMoney;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }else if (indexPath.section == 1){
        MHWithDrawMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHWithDrawMoneyCell class])];
        cell.maxString = self.withDrawMoney;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        MHWithDrawPayCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHWithDrawPayCell class])];
        [cell createModel:_listArr[indexPath.row]];
        cell.editBtn.tag = 7100 + indexPath.row;
        [cell.editBtn addTarget:self action:@selector(deleteWithDraw:) forControlEvents:UIControlEventTouchUpInside];
        if (_editState) {
            cell.selectBtn.hidden = YES;
            cell.editBtn.hidden = NO;
        }else{

            cell.selectBtn.hidden = NO;
            cell.editBtn.hidden = YES;
            if (indexPath.row == _selectIndex) {
                cell.selectBtn.selected = YES;
            }else{
                cell.selectBtn.selected = NO;
            }
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    return nil;
    
}


- (void)deleteWithDraw:(UIButton *)sender{

    if ([_listArr count] == 0) {
        return;
    }
    MHWithDrawListModel *model =  _listArr[sender.tag - 7100];
    [[MHUserService sharedInstance]initwithDeleWithdraw:[NSString stringWithFormat:@"%ld",(long)model.cardId] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [[MHUserService sharedInstance]initwithShopWithDrawListCompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    self.listArr = [MHWithDrawListModel baseModelWithArr:response[@"data"]];
                    if ([self.listArr count]>0) {
                        self.selectIndex = 0;
                    }else{
                        self.selectIndex = - 1;
                    }
                    [UIView performWithoutAnimation:^{
                        [self.contentTableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
                        
                    }];
                    
                }
            }];
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        _selectIndex = indexPath.row;
        [_contentTableView reloadData];
    }
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return kRealValue(40);
    }else{
        return CGFLOAT_MIN;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(40))];
        headerView.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), 0, kScreenWidth - kRealValue(32), kRealValue(40))];
        bgView.backgroundColor = [UIColor whiteColor];
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerBottomRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        bgView.layer.mask = maskLayer;
        [headerView addSubview:bgView];
//
        UIImageView *leftView = [[UIImageView alloc]initWithImage:kGetImage(@"ic_play_plus")];
        [bgView addSubview:leftView];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
            make.centerX.equalTo(bgView.mas_centerX).with.offset(-kRealValue(50));
        }];
        
        UILabel *titlesLabel = [[UILabel alloc]init];
        titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        titlesLabel.textColor =[UIColor colorWithHexString:@"000000"];
        titlesLabel.text  = @"添加提现方式";
        [bgView addSubview:titlesLabel];
        [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.centerX.equalTo(bgView.mas_centerX).with.offset(kRealValue(5));
        }];
        
        bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addWithDraw)];
        [bgView addGestureRecognizer:tap];
        
        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - kRealValue(32), 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [bgView addSubview:lineView];
        
        return headerView;
    }
    return nil;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 2) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(40))];
        headerView.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), 0, kScreenWidth - kRealValue(32), kRealValue(40))];
        bgView.backgroundColor = [UIColor whiteColor];
        UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerTopLeft cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = bgView.bounds;
        maskLayer.path = maskPath.CGPath;
        bgView.layer.mask = maskLayer;
        [headerView addSubview:bgView];
        UILabel *titlesLabel = [[UILabel alloc]init];
        titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        titlesLabel.textColor =[UIColor colorWithHexString:@"000000"];
        titlesLabel.text  = @"提现方式";
        [bgView addSubview:titlesLabel];
        [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.left.equalTo(bgView.mas_left).with.offset(kRealValue(15));
        }];
        
        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(39), kScreenWidth - kRealValue(32), 1/kScreenScale)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [bgView addSubview:lineView];
        
        UIButton  *editBtn = [[UIButton alloc]init];
        [editBtn setImage:kGetImage(@"addwithDraw_right") forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
        [editBtn setImage:kGetImage(@"addwithDraw_compelet") forState:UIControlStateSelected];
        editBtn.selected = _editState;
        [bgView addSubview:editBtn];
        if ([_listArr count] == 0) {
            editBtn.hidden = YES;
        }else{
            editBtn.hidden = NO;
        }
        [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView.mas_centerY).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(kRealValue(50), kRealValue(50)));
            make.right.equalTo(bgView.mas_right).with.offset(0);
        }];
        
        return headerView;
    }
    return nil;
}


-(void)changeState:(UIButton *)sender{
    _editState = !_editState;
    sender.selected = _editState;
    [UIView performWithoutAnimation:^{
        [self.contentTableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return kRealValue(40);
    }else{
        return kRealValue(10);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
      return kRealValue(81);
    }else if (indexPath.section == 1){
      return kRealValue(81);
    }else{
      return kRealValue(64);
    }
}


-(void)addWithDraw{
    MHAddWithDrawVC *VC = [[MHAddWithDrawVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
