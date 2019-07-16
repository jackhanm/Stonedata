//
//  MHMyExtendVC.m
//  mohu
//
//  Created by AllenQin on 2018/9/28.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMyExtendVC.h"
#import "MHFansCell.h"
#import "RichStyleLabel.h"
#import "MHShopFansModel.h"
#import "MHFansVC.h"
#import "ZJAnimationPopView.h"
#import "UIControl+BlocksKit.h"
#import "UIImage+Common.h"
#import "HMScannerController.h"
#import "CTUUID.h"
#import "MHNewbeeVC.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"
#import "MHNomalFansVC.h"
#import "FLAnimatedImageView+WebCache.h"

@interface MHMyExtendVC ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) UIView        *headView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *moneyLabel;
//头像
@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UIImageView   *levelImageView;

@property (nonatomic, strong) UIImageView   *qrImageView;


@property (nonatomic, strong) FLAnimatedImageView   *sectionImageView;

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UIButton   *memberBtn;

@property (nonatomic, strong) NSMutableDictionary  *sumArr;

@property (nonatomic, strong) NSMutableArray  *fanArr;

@property (nonatomic, assign) NSInteger  leftIndex;

@property (nonatomic, assign) NSInteger  rightIndex;


@end
static NSString * const MHFansCellId = @"MHFansCell";

@implementation MHMyExtendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的推广";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
    [self.view addSubview:self.contentTableView];
    _leftIndex = 1;
    _rightIndex = 1;
    _fanArr = [NSMutableArray array];
    NSArray *array = [NSArray arrayWithObjects:@"专属粉丝",@"普通粉丝", nil];
    _segment = [[UISegmentedControl alloc]initWithItems:array];
    _segment.frame = CGRectMake(0, kRealValue(10), kRealValue(220), kRealValue(29));
    [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    _segment.selectedSegmentIndex = 0;
    _segment.centerX = kRealValue(343)/2;
    _segment.tintColor = [UIColor colorWithHexString:@"#FF5100"];
    [[MHUserService sharedInstance]initWithFansSummary:0 relationLevel:0 CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            _sumArr =  response[@"data"];
            [self getData];

        }
    }];
    [[MHUserService sharedInstance]initWithPageComponent:@"7" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
              [self.sectionImageView   sd_setImageWithURL:[NSURL URLWithString:response[@"data"][0][@"result"][0][@"sourceUrl"]]];

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
        [_contentTableView registerClass:[MHFansCell class] forCellReuseIdentifier:MHFansCellId];
        _contentTableView.tableHeaderView = self.headView;
        self.contentTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (_segment.selectedSegmentIndex == 0) {
                _leftIndex ++;
            }else{
                _rightIndex ++;
            }
            [self getData];
        }];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fanArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHFansCell *cell = [tableView dequeueReusableCellWithIdentifier:MHFansCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellVC = self;
    [cell createModel:_fanArr[indexPath.row]];
    return cell;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //91
    MHShopFansModel *model  =   _fanArr[indexPath.row];
    if (model.userRole == 1) {
        return kRealValue(91);
    }else{
        return kRealValue(69);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_segment.selectedSegmentIndex == 0) {
        MHFansVC *vc = [[MHFansVC alloc] init];
        MHShopFansModel *model =  _fanArr[indexPath.row];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        MHNomalFansVC *vc = [[MHNomalFansVC alloc] init];
        MHShopFansModel *model =  _fanArr[indexPath.row];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }

}


// header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kRealValue(151);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *titleArr = @[@"总数",@"店主",@"普通用户"];
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
        titleLabel.text = titleArr[i];
        titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:titleLabel];

        RichStyleLabel *descLabel = [[RichStyleLabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(40), kRealValue(90), kRealValue(32))];
        descLabel.textAlignment = NSTextAlignmentLeft;
        descLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        descLabel.textColor = [UIColor colorWithHexString:@"#000000"] ;
        descLabel.tag = 4500 + i;
        [bgView addSubview:descLabel];

    }
    if (_sumArr) {
        RichStyleLabel *label1 =  [headerView viewWithTag:4500];
        RichStyleLabel *label2 =  [headerView viewWithTag:4501];
        RichStyleLabel *label3 =  [headerView viewWithTag:4502];
        [label1 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",_sumArr[@"total"]]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
        [label2 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",_sumArr[@"shopkeeper"]]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
        [label3 setAttributedText:[self fixString:[NSString stringWithFormat:@"%@",_sumArr[@"normal"]]] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"000000"],NSFontAttributeName : [UIFont fontWithName:@"DINCondensed-Bold" size:kFontValue(32)]}];
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
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(287))];
        _headView.backgroundColor = [UIColor whiteColor];
        UIImageView *backgroudImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kRealValue(15), kRealValue(343), kRealValue(158))];
        backgroudImageView.layer.masksToBounds = YES;
        backgroudImageView.layer.cornerRadius = kRealValue(8);
        backgroudImageView.image = kGetImage(@"exTend_head");
        backgroudImageView.userInteractionEnabled = YES;
        [_headView addSubview:backgroudImageView];
        backgroudImageView.centerX = _headView.centerX;
        
        UIButton *qrCode = [[UIButton alloc]init];
        [qrCode setBackgroundImage:kGetImage(@"level_shop_qr") forState:UIControlStateNormal];
        [qrCode addTarget:self action:@selector(showQR) forControlEvents:UIControlEventTouchUpInside];
        [backgroudImageView addSubview:qrCode];
        [qrCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(30), kRealValue(30)));
            make.right.equalTo(backgroudImageView.mas_right).with.offset(-kRealValue(15));
            make.top.equalTo(backgroudImageView.mas_top).with.offset(kRealValue(15));
        }];
        
        //头像
        _headImageView = [[UIImageView alloc]init];
        ViewBorderRadius(_headImageView, kRealValue(27), 1, [UIColor whiteColor]);
//        _headImageView.backgroundColor = kRandomColor;
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_keepModel.shopAvatar] placeholderImage:kGetImage(@"user_pic")];
        [backgroudImageView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(54), kRealValue(54)));
            make.left.equalTo(backgroudImageView.mas_left).with.offset(kRealValue(15));
            make.top.equalTo(backgroudImageView.mas_top).with.offset(kRealValue(15));
        }];
        
        //提现
        UIButton *withDrawBtn = [[UIButton alloc]init];
        withDrawBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        [withDrawBtn setTitle:@"复制" forState:UIControlStateNormal];
        [withDrawBtn addTarget:self action:@selector(copyYqm) forControlEvents:UIControlEventTouchUpInside];
        [withDrawBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        withDrawBtn.backgroundColor = [UIColor clearColor];
        [backgroudImageView addSubview:withDrawBtn];
        ViewBorderRadius(withDrawBtn, kRealValue(12), 1, [UIColor whiteColor]);
        [withDrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(48), kRealValue(24)));
            make.right.equalTo(backgroudImageView.mas_right).with.offset(-kRealValue(15));
            make.bottom.equalTo(backgroudImageView.mas_bottom).with.offset(-kRealValue(15));
        }];
        
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = _keepModel.shopName;
        _nameLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [backgroudImageView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).with.offset(kRealValue(10));
            make.top.equalTo(backgroudImageView.mas_top).with.offset(kRealValue(22));
        }];
        
        
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(15), kRealValue(125), kScreenWidth/2, kRealValue(20))];
        _moneyLabel.numberOfLines = 1;
        _moneyLabel.text = [NSString stringWithFormat:@"我的邀请码：%@",_keepModel.shopkeeperYQCode];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"ffffff"] ;
        [backgroudImageView addSubview:_moneyLabel];
        
        _levelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(79), kRealValue(51), kRealValue(12), kRealValue(12))];
//        _levelImageView.backgroundColor = kRandomColor;
        [backgroudImageView addSubview:_levelImageView];
        
        _memberBtn = [[UIButton alloc]initWithFrame:CGRectMake(kRealValue(96), kRealValue(47), kRealValue(65), kRealValue(25))];
        _memberBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
//        [_memberBtn setImage:[UIImage imageNamed:@"level_arrow"] forState:UIControlStateNormal];
        [_memberBtn setTitle:@"狐会员" forState:UIControlStateNormal];
//        [_memberBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _memberBtn.imageView.image.size.width +kRealValue(8), 0, _memberBtn.imageView.image.size.width)];
//        [_memberBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _memberBtn.titleLabel.bounds.size.width-kRealValue(8), 0, -_memberBtn.titleLabel.bounds.size.width+kRealValue(8))];
        [backgroudImageView addSubview:_memberBtn];
        _memberBtn.centerY =  _levelImageView.centerY;
        
        
        _sectionImageView = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake(0, kRealValue(188), kScreenWidth, kRealValue(80))];
        _sectionImageView.userInteractionEnabled = YES;
        [_headView addSubview:_sectionImageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(newbee)];
        [_sectionImageView addGestureRecognizer:tap];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(272), kScreenWidth, kRealValue(15))];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F1F2F4"];
        [_headView addSubview:lineView];
        if ([_keepModel.userRole integerValue] == 0) {
            [_memberBtn setTitle:@"内部员工" forState:UIControlStateNormal];
            _levelImageView.image = kGetImage(@"ic_store_member_white");
        }else if ([_keepModel.userRole integerValue] == 1){
            [_memberBtn setTitle:@"普通会员" forState:UIControlStateNormal];
            _levelImageView.image  = kGetImage(@"ic_store_member_white");
        }else if ([_keepModel.userRole integerValue] == 2){
            [_memberBtn setTitle:@"店主" forState:UIControlStateNormal];
            _levelImageView.image  = kGetImage(@"ic_store_store_white");
        }else if ([_keepModel.userRole integerValue] == 3){
            [_memberBtn setTitle:@"掌柜子" forState:UIControlStateNormal];
            _levelImageView.image  = kGetImage(@"ic_data_manager_white");
        }else if ([_keepModel.userRole integerValue] == 4){
            [_memberBtn setTitle:@"分舵主" forState:UIControlStateNormal];
            _levelImageView.image  = kGetImage(@"ic_data_rudder_white");
        }
        
        _qrImageView = [[UIImageView alloc] init];
        [HMScannerController cardImageWithCardName:[[MHBaseClass sharedInstance]createParamUrl:self.keepModel.shopkeeperQRCode param:@{@"userCode":self.keepModel.shopkeeperYQCode,@"urlType":@"invite-user",@"seqNo":[CTUUID getTimeStamp]}] avatar:_headImageView.image scale:0.2 completion:^(UIImage *image) {
            self.qrImageView.image = image;
        }];
    }
    return _headView;
}


-(void)newbee{
    
    MHNewbeeVC *vc = [[MHNewbeeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)copyYqm{
    UIPasteboard *copy = [UIPasteboard generalPasteboard];
    [copy setString:_keepModel.shopkeeperYQCode];
    KLToast(@"复制成功");
}

-(void)segmentValueChanged:(UISegmentedControl *)seg{
    [_fanArr removeAllObjects];
    _leftIndex = 1;
    _rightIndex = 1;
    [[MHUserService sharedInstance]initWithFansSummary:0 relationLevel:seg.selectedSegmentIndex CompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            _sumArr =  response[@"data"];
            [self getData];
           
        }
    }];
}


- (void)getData{
    [[MHUserService  sharedInstance]initwithShopFans:_segment.selectedSegmentIndex userId:0 pageIndex:(_segment.selectedSegmentIndex == 0)?self.leftIndex:self.rightIndex pageSize:20 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            [_fanArr  addObjectsFromArray:[MHShopFansModel baseModelWithArr:response[@"data"][@"list"]]];
            [self.contentTableView reloadData];
            if ([ response[@"data"][@"list"] count] > 0) {
                [self endRefresh];
            }else{
                [self endRefreshNoMoreData];
            }
        }
    }];
}


-(void)endRefresh{
    [_contentTableView.mj_footer endRefreshing];
}

-(void)endRefreshNoMoreData{
    [_contentTableView.mj_footer endRefreshingWithNoMoreData];
}


- (void)showQR{
    //level_qrcode
    MHLog(@"qrcode");
    
    
    // 1.Get custom view【获取自定义控件】
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(270), kRealValue(410))];
    
    //图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(270), kRealValue(360))];
    imageView.image = [UIImage imageNamed:@"level_qrcode"];
    [customView addSubview:imageView];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.frame = CGRectMake(0, kRealValue(100), kRealValue(270), kRealValue(25));
    label1.textColor = [UIColor colorWithHexString:@"282828"];
    label1.text = @"您的邀请码为";
    [imageView addSubview:label1];
    
    
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(23)];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, kRealValue(125), kRealValue(270), kRealValue(33));
    label.textColor = [UIColor colorWithHexString:@"fc6f29"];
    label.text = [NSString stringWithFormat:@"%@",_keepModel.shopkeeperYQCode];
    [imageView addSubview:label];
    
    UIImageView *qrcode = [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(65), kRealValue(185), kRealValue(140), kRealValue(140))];
    qrcode.image = _qrImageView.image;
    [imageView addSubview:qrcode];
    
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.frame = CGRectMake(0, kRealValue(323), kRealValue(270), kRealValue(20));
    label2.textColor = [UIColor colorWithHexString:@"898989"];
    label2.text = @"扫描二维码加入未来商视";
    [imageView addSubview:label2];
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(10), kRealValue(380), kRealValue(108), kRealValue(30))];
    leftBtn.backgroundColor = [UIColor whiteColor];
    leftBtn.layer.cornerRadius = kRealValue(15);
    [leftBtn bk_addEventHandler:^(id sender) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [[MHBaseClass sharedInstance]createParamUrl:self.keepModel.shopkeeperQRCode param:@{@"userCode":self.keepModel.shopkeeperYQCode,@"urlType":@"invite-user",@"seqNo":[CTUUID getTimeStamp]}];
        KLToast(@"复制成功");
    } forControlEvents:UIControlEventTouchUpInside];
    
    leftBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [leftBtn setBackgroundColor:[UIColor colorWithHexString:@"fe7c2d"]];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setTitle:@"复制邀请链接" forState:UIControlStateNormal];
    leftBtn.layer.masksToBounds = YES;
    [customView addSubview:leftBtn];
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(150), kRealValue(380), kRealValue(108), kRealValue(30))];
    rightBtn.backgroundColor = [UIColor colorWithHexString:@"f83c16"];
    rightBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"保存二维码" forState:UIControlStateNormal];
    rightBtn.layer.cornerRadius = kRealValue(15);
    [rightBtn bk_addEventHandler:^(id sender) {
        UIImage *image =  [UIImage imageFromView:imageView];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
        
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    rightBtn.layer.masksToBounds = YES;
    [customView addSubview:rightBtn];
    
    
    // 2.Init【初始化】
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:customView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
    // 3.1 显示时点击背景是否移除弹框
    popView.isClickBGDismiss = YES;
    // 3.2 显示时背景的透明度
    popView.popBGAlpha = 0.5f;
    // 3.3 显示时是否监听屏幕旋转
    popView.isObserverOrientationChange = YES;
    // 3.4 显示时动画时长
    popView.popAnimationDuration = 0.3f;
    // 3.5 移除时动画时长
    popView.dismissAnimationDuration = 0.3f;
    
    // 3.6 显示完成回调
    popView.popComplete = ^{
        MHLog(@"显示完成");
    };
    // 3.7 移除完成回调
    popView.dismissComplete = ^{
        MHLog(@"移除完成");
    };
    [popView pop];
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    KLToast(@"保存成功");
    MHLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
