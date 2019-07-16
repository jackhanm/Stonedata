//
//  MHFansVC.m
//  mohu
//
//  Created by AllenQin on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHNomalFansVC.h"
#import "MHFansCell.h"
#import "RichStyleLabel.h"
#import "MHManagementCell.h"
#import "MHNewbeeVC.h"

@interface MHNomalFansVC ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) UIView        *headView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *moneyLabel;
//头像
@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UIImageView   *levelImageView;
@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UIButton   *memberBtn;

@property (nonatomic, strong) NSMutableDictionary  *sumArr1;


@property (nonatomic, strong) NSMutableArray  *dingdanArr;

@property (nonatomic, assign) NSInteger  rightIndex;


@end
static NSString * const MHFansCellId = @"MHFansCell";

@implementation MHNomalFansVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"粉丝详情";
     _rightIndex = 1;
    _dingdanArr =  [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
    [self.view addSubview:self.contentTableView];
    [[MHUserService  sharedInstance]initwithfansorder:self.model.userId completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)){
            self.sumArr1 =  response[@"data"];
            [self.contentTableView reloadData];
        }
    }];

    [self requireDingdan];
}


- (void)requireDingdan{
    
    [[MHUserService  sharedInstance]initwithShopdingdan:self.model.userId pageIndex:_rightIndex completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [self.dingdanArr  addObjectsFromArray:[MHMyOrderListModel baseModelWithArr:response[@"data"][@"list"]]];
            [self.contentTableView reloadData];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
    }];
}

-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight -kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _rightIndex ++;
            [self requireDingdan];
        }];
        [_contentTableView registerClass:[MHFansCell class] forCellReuseIdentifier:MHFansCellId];
        [_contentTableView registerClass:[MHManagementCell class] forCellReuseIdentifier:NSStringFromClass([MHManagementCell class])];
        _contentTableView.tableHeaderView = self.headView;
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}

-(void)endRefresh{
    [_contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [_contentTableView.mj_footer endRefreshingWithNoMoreData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dingdanArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHManagementCell class])];
    MHMyOrderListModel *model =   _dingdanArr[indexPath.row];
    [cell createModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //91
    return kRealValue(192);
    
}



// header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kRealValue(151);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *titleArr1 = @[@"订单数",@"成交额",@"佣金"];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(151))];
    headerView.backgroundColor = [UIColor clearColor];
    
    UIView *headerView1 = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(16), 0, kRealValue(343), kRealValue(151))];
    headerView1.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:headerView1];
    //    //圆角
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:headerView1.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = headerView1.bounds;
    maskLayer.path = maskPath.CGPath;
    headerView1.layer.mask = maskLayer;
    
    [headerView1 addSubview:_segment];
    //
    for (int i = 0; i<3; i++) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10) + (kRealValue(101)*i) + (kRealValue(10)*(i)),kRealValue(55), kRealValue(101), kRealValue(81))];
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
        bgView.layer.cornerRadius = kRealValue(5);
        [headerView1 addSubview:bgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(15), kRealValue(90), kRealValue(17))];
        titleLabel.text =titleArr1[i];
        
        titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:titleLabel];
        
        RichStyleLabel *descLabel = [[RichStyleLabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(40), kRealValue(90), kRealValue(32))];
        descLabel.textAlignment = NSTextAlignmentLeft;
        descLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        descLabel.textColor = [UIColor colorWithHexString:@"#000000"] ;
        descLabel.tag = 4600 + i;
        [bgView addSubview:descLabel];
    }
    
    if (_sumArr1) {
        RichStyleLabel *label1 =  [headerView viewWithTag:4600];
        RichStyleLabel *label2 =  [headerView viewWithTag:4601];
        RichStyleLabel *label3 =  [headerView viewWithTag:4602];
        [label1 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",_sumArr1[@"orderCount"]]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
        [label2 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",_sumArr1[@"summaryTurnover"]]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
        [label3 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",_sumArr1[@"summaryMoney"]]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
    }
    
    
    
    
    return headerView;
    
}

- (NSString *)fixString:(NSString *)str{
    if (str) {
        if ([str doubleValue] > 10000) {
            return [NSString stringWithFormat:@"%.2f万",[str doubleValue]/10000];
        }else{
            return str;
        }
    }else{
        return @"";
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}




-(UIView *)headView{
    if (!_headView) {
        //188
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(143))];
        _headView.backgroundColor = [UIColor whiteColor];
        UIImageView *backgroudImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kRealValue(15), kRealValue(343), kRealValue(98))];
        backgroudImageView.layer.masksToBounds = YES;
        backgroudImageView.layer.cornerRadius = kRealValue(8);
        [backgroudImageView shadowPathWith:[UIColor colorWithHexString:@"756A4B" andAlpha:.15] shadowOpacity:1 shadowRadius:kRealValue(5) shadowSide:MHShadowPathMohu shadowPathWidth:2];
        backgroudImageView.backgroundColor = [UIColor whiteColor];
        
        backgroudImageView.userInteractionEnabled = YES;
        [_headView addSubview:backgroudImageView];
        
        backgroudImageView.centerX = _headView.centerX;
        
        UIButton *qrCode = [[UIButton alloc]init];
        [qrCode setBackgroundImage:kGetImage(@"ic_share_grey") forState:UIControlStateNormal];
        [qrCode addTarget:self action:@selector(showQR) forControlEvents:UIControlEventTouchUpInside];
        [backgroudImageView addSubview:qrCode];
        [qrCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(22), kRealValue(22)));
            make.right.equalTo(backgroudImageView.mas_right).with.offset(-kRealValue(15));
            make.top.equalTo(backgroudImageView.mas_top).with.offset(kRealValue(35));
        }];
        
        //头像
        _headImageView = [[UIImageView alloc]init];
        ViewBorderRadius(_headImageView, kRealValue(27), 1, [UIColor whiteColor]);
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:self.model.userImage] placeholderImage:kGetImage(@"user_pic")];;
        [backgroudImageView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(54), kRealValue(54)));
            make.left.equalTo(backgroudImageView.mas_left).with.offset(kRealValue(15));
            make.top.equalTo(backgroudImageView.mas_top).with.offset(kRealValue(15));
        }];
        
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = self.model.userNickName;
        _nameLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [backgroudImageView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).with.offset(kRealValue(10));
            make.top.equalTo(backgroudImageView.mas_top).with.offset(kRealValue(22));
        }];
        
        
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(79), kRealValue(68), kScreenWidth/2, kRealValue(20))];
        _moneyLabel.numberOfLines = 1;
        _moneyLabel.text = [NSString stringWithFormat:@"手机号 %@",_model.userPhone];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"#666666"] ;
        [backgroudImageView addSubview:_moneyLabel];
        
        _levelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(79), kRealValue(51), kRealValue(12), kRealValue(12))];
        [backgroudImageView addSubview:_levelImageView];
        
        _memberBtn = [[UIButton alloc]initWithFrame:CGRectMake(kRealValue(96), kRealValue(47), kRealValue(50), kRealValue(25))];
        _memberBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        [_memberBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backgroudImageView addSubview:_memberBtn];
        _memberBtn.centerY =  _levelImageView.centerY;
        
        if (_model.userRole == 0) {
            [_memberBtn setTitle:@"内部员工" forState:UIControlStateNormal];
            _levelImageView.image = kGetImage(@"ic_store_member_white");
        }else if (_model.userRole == 1){
            [_memberBtn setTitle:@"普通会员" forState:UIControlStateNormal];
            _levelImageView.image  = kGetImage(@"ic_store_member_white");
        }else if (_model.userRole == 2){
            [_memberBtn setTitle:@"店主" forState:UIControlStateNormal];
            _levelImageView.image  = kGetImage(@"ic_store_store_white");
        }else if (_model.userRole == 3){
            [_memberBtn setTitle:@"掌柜子" forState:UIControlStateNormal];
            _levelImageView.image  = kGetImage(@"ic_data_manager_white");
        }else if (_model.userRole == 4){
            [_memberBtn setTitle:@"分舵主" forState:UIControlStateNormal];
            _levelImageView.image  = kGetImage(@"ic_data_rudder_white");
        }
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(128), kScreenWidth, kRealValue(15))];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [_headView addSubview:lineView];
    }
    return _headView;
}



- (void)showQR{
    
    MHNewbeeVC *vc = [[MHNewbeeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
