//
//  MHShopViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHShopViewController.h"
#import "MHLevelAssetCell.h"
#import "MHLevelDataCell.h"
#import "MHExtensionCell.h"
#import "MHTaskCell.h"
#import "RichStyleLabel.h"
#import "MHSXYCell.h"
#import "MHMyExtendVC.h"
#import "MHAssetRootVC.h"
#import "MHManagementRootVC.h"
#import "MHTaskVC.h"
#import "MHWithDrawVC.h"
#import "MHShopkeepModel.h"
#import "ZJAnimationPopView.h"
#import "UIControl+BlocksKit.h"
#import "UIImage+Common.h"
#import "HMScannerController.h"
#import "CTUUID.h"
#import "MHNewbeeVC.h"
#import "MHJHCell.h"
#import "MHJFModel.h"
#import "MHjHVC.h"

@interface MHShopViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray            *_titleArr;
}


@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) UIView        *headView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) RichStyleLabel     *moneyLabel;
//头像
@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UIImageView   *levelImageView;

@property (nonatomic, strong) NSMutableArray   *taskArr;
@property (nonatomic, strong) NSArray           *sxyArr;
@property (nonatomic, strong) NSArray           *jhArr;

@property (nonatomic, strong) UIButton   *memberBtn;

@property (nonatomic, strong) UIImageView   *qrImageView;

@property (nonatomic, strong) MHShopkeepModel   *keepModel;

@end

static NSString * const MHLevelAssetCellId = @"MHLevelAssetCell";
static NSString * const MHLevelDataCellId = @"MHLevelDataCell";
static NSString * const MHExtensionCellId = @"MHExtensionCellId";
static NSString * const MHTaskCellId = @"MHTaskCell";
static NSString * const MHSXYCellId = @"MHSXYCell";

@implementation MHShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _titleArr = @[@"当前资产",@"经营数据",@"我的推广",@"进阶任务",@"未来商视商学院"];
     _qrImageView = [[UIImageView alloc] init];
    _taskArr = [NSMutableArray array];
     [self.view addSubview:self.contentTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([GVUserDefaults standardUserDefaults].accessToken == nil) {
        return;
    }
    [[MHUserService sharedInstance]initwithShopkeeperCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            _keepModel  =   [MHShopkeepModel baseModelWithDic:response[@"data"]];
            _nameLabel.text = _keepModel.shopName;
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:_keepModel.shopAvatar] placeholderImage:kGetImage(@"user_pic") completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
                [HMScannerController cardImageWithCardName:[[MHBaseClass sharedInstance]createParamUrl:self.keepModel.shopkeeperQRCode param:@{@"userCode":self.keepModel.shopkeeperYQCode,@"urlType":@"invite-user",@"seqNo":[CTUUID getTimeStamp]}] avatar:image scale:0.2 completion:^(UIImage *image) {
                    self.qrImageView.image = image;
                }];
            }];
            
            [_moneyLabel setAttributedText:[NSString stringWithFormat:@"%@ 陌币",_keepModel.availableBalance] withRegularPattern:@"[0-9.,]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"ffffff"],NSFontAttributeName : [UIFont fontWithName:kPingFangMedium size:kFontValue(21)]}];
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

            [_contentTableView reloadData];
        }
    }];
    

    
    [[MHUserService sharedInstance]initwithShopTaskCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSArray *dataArr =  response[@"data"];
            [_taskArr removeAllObjects];
            [dataArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj[@"taskStatus"] intValue] == 1) {
                    [_taskArr addObject:obj];
                }
            }];
            [UIView performWithoutAnimation:^{
                [_contentTableView reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
            }];
           
        }
    }];
    [[MHUserService sharedInstance]initWithPageComponent:@"6" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSArray *dataArr =  response[@"data"];
            _sxyArr = dataArr[0][@"result"];
            [UIView performWithoutAnimation:^{
                [_contentTableView reloadSection:4 withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }];
    
    //获取列表
    [[MHUserService sharedInstance]initwithJihuoListPageIndex:1 pageSize:10 completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.jhArr =  [MHJFModel baseModelWithArr:response[@"data"]];
            [UIView performWithoutAnimation:^{
                [_contentTableView reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }];
    
}

-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kTabBarHeight -kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHLevelAssetCell class] forCellReuseIdentifier:MHLevelAssetCellId];
        [_contentTableView registerClass:[MHLevelDataCell class] forCellReuseIdentifier:MHLevelDataCellId];
        [_contentTableView registerClass:[MHExtensionCell class] forCellReuseIdentifier:MHExtensionCellId];
         [_contentTableView registerClass:[MHTaskCell class] forCellReuseIdentifier:MHTaskCellId];
        [_contentTableView registerClass:[MHSXYCell class] forCellReuseIdentifier:MHSXYCellId];
        [_contentTableView registerClass:[MHJHCell class] forCellReuseIdentifier:NSStringFromClass([MHJHCell class])];
        _contentTableView.tableHeaderView = self.headView;
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        if ([_taskArr count]>=3) {
            return 3;
        }else{
           return _taskArr.count;
        }
   
    }
    
    if (section  == 2) {
        //         return kRealValue(40);
        
        
        if ([_jhArr count] > 5) {
            return  6;
        }else{
            return  [_jhArr count] + 1;
        }
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MHLevelAssetCell *cell = [tableView dequeueReusableCellWithIdentifier:MHLevelAssetCellId];
        if (_keepModel) {
            cell.shopModel = _keepModel;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        MHLevelDataCell *cell = [tableView dequeueReusableCellWithIdentifier:MHLevelDataCellId];
        if (_keepModel) {
            cell.shopModel = _keepModel;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){

       
        if (indexPath.row  ==  0) {
            MHExtensionCell *cell = [tableView dequeueReusableCellWithIdentifier:MHExtensionCellId];
            if (_keepModel) {
                cell.shopModel = _keepModel;
            }
            cell.superVC = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
             //加上激活
            MHJHCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHJHCell class])];
            MHJFModel  *model  =  _jhArr[indexPath.row -1];
            cell.jfModel = model;
//            if (_keepModel) {
//                cell.shopModel = _keepModel;
//            }
//            cell.superVC = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        
    }else if (indexPath.section == 3){
        
        MHTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:MHTaskCellId];
        cell.titleLabel.text = _taskArr[indexPath.row][@"taskName"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 4){
        
        MHSXYCell *cell = [tableView dequeueReusableCellWithIdentifier:MHSXYCellId];
        cell.MHfuliArr = _sxyArr;
        cell.cellVC = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kRealValue(187);
    }else if (indexPath.section == 1){
        return kRealValue(155);
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            return kRealValue(96);
        }else{
            return kRealValue(60);
        }
        
    }else if (indexPath.section == 3){
        return kRealValue(54);
    }else if (indexPath.section == 4){
        return kRealValue(103);
    }
    return 0;
}

// header
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kRealValue(46);
}





-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(46))];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(16),0,kScreenWidth/2,kRealValue(46))];
    titleLabel.text = _titleArr[section];
    titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(17)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLabel];
    UIButton *descBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth -kRealValue(80), 0, kRealValue(80), kRealValue(46))];
    descBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [descBtn setImage:[UIImage imageNamed:@"leve_desc_arrow"] forState:UIControlStateNormal];
    [descBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    descBtn.tag = 3100+section;
    [descBtn addTarget:self action:@selector(descPush:) forControlEvents:UIControlEventTouchUpInside];
    [descBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [descBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - descBtn.imageView.image.size.width +kRealValue(3), 0, descBtn.imageView.image.size.width)];
    [descBtn setImageEdgeInsets:UIEdgeInsetsMake(0, descBtn.titleLabel.bounds.size.width-kRealValue(3), 0, -descBtn.titleLabel.bounds.size.width+kRealValue(3))];
    [headerView addSubview:descBtn];
    if (section == 4) {
        descBtn.hidden = YES;
    }else{
        descBtn.hidden = NO;
    }

    return headerView;
}

-(void)descPush:(UIButton *)sender{
    
    if (sender.tag == 3102) {
        MHMyExtendVC  *vc = [[MHMyExtendVC alloc]init];
        vc.keepModel = self.keepModel;
        [self.navigationController pushViewController: vc animated:YES];
    }
    
    if (sender.tag == 3100) {
       MHAssetRootVC *vc = [[MHAssetRootVC alloc]init];
        [self.navigationController pushViewController: vc animated:YES];
    }
    
    if (sender.tag == 3101) {
        MHManagementRootVC *vc = [[MHManagementRootVC alloc]init];
        [self.navigationController pushViewController: vc animated:YES];
    }
    if (sender.tag == 3103) {
        MHTaskVC *vc = [[MHTaskVC alloc]init];
        [self.navigationController pushViewController: vc animated:YES];
    }
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section  == 2) {
//         return kRealValue(40);
        
        
        if ([_jhArr count] > 5) {
            return kRealValue(40);
        }else{
            return CGFLOAT_MIN;
        }
    }
    return CGFLOAT_MIN;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    
    
    if (section  == 2) {
        
    
        
        if ([_jhArr count] > 5) {
            UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(40))];
            contentView.backgroundColor = [UIColor clearColor];
            
            
            UIButton *bgView = [[UIButton alloc]initWithFrame:CGRectMake(kRealValue(16),0, kRealValue(343), kRealValue(40))];
            bgView.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(13)];
            [bgView setTitle:@"查看更多" forState:UIControlStateNormal];
            [bgView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bgView.backgroundColor = [UIColor colorWithHexString:@"#F2F3F5"];
            [contentView addSubview:bgView];
            [bgView addTarget:self action:@selector(showAllJF) forControlEvents:UIControlEventTouchUpInside];
            return contentView;



        }else{
            return nil;
        }
    }
    return nil;
}

-(void)showAllJF{
    
    MHjHVC *vc = [[MHjHVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(188))];
        UIImageView *backgroudImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kRealValue(343), kRealValue(158))];
        backgroudImageView.layer.masksToBounds = YES;
        backgroudImageView.layer.cornerRadius = kRealValue(8);
        backgroudImageView.image = kGetImage(@"exTend_head");
        backgroudImageView.userInteractionEnabled = YES;
        [_headView addSubview:backgroudImageView];
        backgroudImageView.centerX = _headView.centerX;
        backgroudImageView.centerY = _headView.centerY;
        
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
        [backgroudImageView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(54), kRealValue(54)));
            make.left.equalTo(backgroudImageView.mas_left).with.offset(kRealValue(15));
            make.top.equalTo(backgroudImageView.mas_top).with.offset(kRealValue(15));
        }];
        
        //提现
        UIButton *withDrawBtn = [[UIButton alloc]init];
        withDrawBtn.titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        [withDrawBtn setTitle:@"提现" forState:UIControlStateNormal];
        [withDrawBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        withDrawBtn.backgroundColor = [UIColor clearColor];
        [withDrawBtn addTarget:self action:@selector(withDraw) forControlEvents:UIControlEventTouchUpInside];
        [backgroudImageView addSubview:withDrawBtn];
        ViewBorderRadius(withDrawBtn, kRealValue(12), 1, [UIColor whiteColor]);
        [withDrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kRealValue(48), kRealValue(24)));
            make.right.equalTo(backgroudImageView.mas_right).with.offset(-kRealValue(15));
            make.bottom.equalTo(backgroudImageView.mas_bottom).with.offset(-kRealValue(15));
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"可提现资产";
        label.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(13)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        [backgroudImageView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroudImageView.mas_left).with.offset(kRealValue(15));
            make.bottom.equalTo(backgroudImageView.mas_bottom).with.offset(-kRealValue(41));
        }];
        
        _nameLabel = [[UILabel alloc] init];
//        _nameLabel.text = @"爱过痛过个麻球";
        _nameLabel.font = [UIFont fontWithName:kPingFangMedium size:kFontValue(14)];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [backgroudImageView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headImageView.mas_right).with.offset(kRealValue(10));
            make.top.equalTo(backgroudImageView.mas_top).with.offset(kRealValue(22));
        }];
        
        
        
        _moneyLabel = [[RichStyleLabel alloc] init];
        _moneyLabel.numberOfLines = 1;
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        _moneyLabel.textColor = [UIColor colorWithHexString:@"ffffff"] ;
        [backgroudImageView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(kNavBarHeight, kNavBarHeight));
            make.left.equalTo(backgroudImageView.mas_left).with.offset(kRealValue(15));
            make.top.equalTo(backgroudImageView.mas_top).with.offset( kRealValue(125));
        }];

        
        _levelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(79), kRealValue(51), kRealValue(12), kRealValue(12))];
        _levelImageView.backgroundColor = kRandomColor;
        [backgroudImageView addSubview:_levelImageView];
        
        _memberBtn = [[UIButton alloc]initWithFrame:CGRectMake(kRealValue(96), kRealValue(47), kRealValue(65), kRealValue(25))];
        _memberBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
//        [_memberBtn setImage:[UIImage imageNamed:@"level_arrow"] forState:UIControlStateNormal];
        [_memberBtn setTitle:@"狐会员" forState:UIControlStateNormal];
//        [_memberBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - _memberBtn.imageView.image.size.width +kRealValue(8), 0, _memberBtn.imageView.image.size.width)];
//        [_memberBtn setImageEdgeInsets:UIEdgeInsetsMake(0, _memberBtn.titleLabel.bounds.size.width-kRealValue(8), 0, -_memberBtn.titleLabel.bounds.size.width+kRealValue(8))];
        [backgroudImageView addSubview:_memberBtn];
        _memberBtn.centerY =  _levelImageView.centerY;
        

    }
    return _headView;
}


-(void)withDraw{
    MHWithDrawVC *vc = [[MHWithDrawVC alloc]init];
    vc.withDrawMoney = _keepModel.availableBalance;
    [self.navigationController pushViewController:vc animated:YES];
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
    label.frame = CGRectMake(0, kRealValue(130), kRealValue(270), kRealValue(33));
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



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        MHNewbeeVC *vc = [[MHNewbeeVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
