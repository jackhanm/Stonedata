//
//  MHSignViewController.m
//  mohu
//
//  Created by AllenQin on 2019/1/7.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHSignViewController.h"
#import "MHSignTableViewCell.h"
#import "MHSignRecordRootVC.h"
#import "UIControl+BlocksKit.h"
#import "MHOtherStoreVC.h"


@interface MHSignViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) UIImageView   *headerView;
@property (nonatomic, strong) UILabel        *nameLabel;
@property(strong,nonatomic)   UILabel *integralLabel;
@property(copy,nonatomic)      NSString *integralstrs;
@property(strong,nonatomic)   UILabel *footLabel;
@property(strong,nonatomic)  NSDictionary  *reposeDict;

@property(strong,nonatomic)   UILabel *moLabel;

@end

@implementation MHSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到有礼";
    UIButton *moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setTitle:@"积分记录" forState:UIControlStateNormal];
    [moreBtn setFrame:CGRectMake(5,0,kRealValue(70),kRealValue(30))];
    [moreBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [moreBtn.titleLabel setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [moreBtn addTarget:self action:@selector(withDrawListClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];
    
    
    
    [[MHUserService sharedInstance]initGetSignCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.reposeDict  = response;
             [self.view addSubview:self.contentTableView];
             [self.headerView sd_setImageWithURL:[NSURL URLWithString:response[@"data"][@"user"][@"userImage"]] placeholderImage:kGetImage(@"img_bitmap_white")];
            self.nameLabel.text = response[@"data"][@"user"][@"userNickName"];
            //积分
            NSMutableAttributedString *integralStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",response[@"data"][@"user"][@"availableIntegral"],response[@"data"][@"user"][@"integral"]]];
            
             [integralStr addAttribute:NSForegroundColorAttributeName value:  [UIColor colorWithHexString:@"ff6583"] range:NSMakeRange(0,[response[@"data"][@"user"][@"availableIntegral"] length])];
            self.integralstrs =  response[@"data"][@"user"][@"availableIntegral"];
            self.integralLabel.attributedText = integralStr;
            //陌币
            NSMutableAttributedString *mobiStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",response[@"data"][@"user"][@"availableBalance"],response[@"data"][@"user"][@"balance"]]];
            
            [mobiStr addAttribute:NSForegroundColorAttributeName value:  [UIColor colorWithHexString:@"ffae45"] range:NSMakeRange(0,[response[@"data"][@"user"][@"availableBalance"] length])];
            self.moLabel.attributedText = mobiStr;
            
            [[MHUserService sharedInstance]initIntegralsCompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    self.footLabel.text = response[@"data"];
                }
            }];
//
        }
    }];
  
}

-(void)withDrawListClick{
    //积分记录
    MHSignRecordRootVC *VC = [[MHSignRecordRootVC alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight  -kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor colorWithHexString:@"ff6583"];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
//        [_contentTableView registerClass:[MHSignTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MHSignTableViewCell class])];
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(150))];
        headView.backgroundColor = [UIColor colorWithHexString:@"ff6583"];
        UIView *headContentView = [[UIView alloc] initWithFrame:CGRectMake(kRealValue(10), kRealValue(15), kScreenWidth - kRealValue(20), kRealValue(120))];
        headContentView.backgroundColor = [UIColor whiteColor];
        [headContentView.layer setCornerRadius:kRealValue(3)];
        [headContentView.layer setMasksToBounds:YES];
        [headView addSubview:headContentView];
        
        //头像
        self.headerView =  [[UIImageView alloc] initWithFrame:CGRectMake(kRealValue(14), kRealValue(8), kRealValue(34), kRealValue(34))];
        [self.headerView.layer setCornerRadius:kRealValue(17)];
        [self.headerView.layer setMasksToBounds:YES];
//        self.headerView.backgroundColor = kRandomColor;
        [headContentView addSubview:self.headerView];
        //名字
        self.nameLabel = [[UILabel alloc] init];
//        self.nameLabel.text = @"试试的的";
        self.nameLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
        self.nameLabel.textColor = [UIColor colorWithHexString:@"000033"];
        [headContentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headerView.mas_centerY).offset(0);
            make.left.equalTo(self.headerView.mas_right).offset(kRealValue(6));
        }];

        UILabel *jifenLabel = [[UILabel alloc] init];
        jifenLabel.text = @"积分";
        jifenLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        jifenLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [headContentView addSubview:jifenLabel];
        [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headContentView.mas_top).offset(kRealValue(65));
            make.left.equalTo(headContentView.mas_left).offset(kRealValue(52));
        }];
        
        //积分
        self.integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(80), (kScreenWidth - kRealValue(20))/2, kRealValue(47))];
//        self.integralLabel.text = @"50/6555";
        self.integralLabel.textAlignment = NSTextAlignmentCenter;
        self.integralLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(20)];
        self.integralLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [headContentView addSubview:self.integralLabel];
        self.integralLabel.centerX = (kScreenWidth - kRealValue(20))/4;
        
        
        
        
        
        
        UILabel *mobiLabel = [[UILabel alloc] init];
        mobiLabel.text = @"陌币";
        mobiLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
        mobiLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [headContentView addSubview:mobiLabel];
        [mobiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headContentView.mas_top).offset(kRealValue(65));
            make.left.equalTo(headContentView.mas_left).offset(kRealValue(252));
        }];
        
        
        
        //陌币
        self.moLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(80), (kScreenWidth - kRealValue(20))/2, kRealValue(47))];
//        self.moLabel.text = @"5/65";
        self.moLabel.textAlignment = NSTextAlignmentCenter;
        self.moLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(20)];
        self.moLabel.textColor = [UIColor colorWithHexString:@"333333"];
        [headContentView addSubview:self.moLabel];
        self.moLabel.centerX = (kScreenWidth - kRealValue(20))*3/4;
        
        
        UILabel *lineView = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(177), kRealValue(65), 1/kScreenScale, kRealValue(34))];
        lineView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        [headContentView addSubview:lineView];
        
        UIButton *shopBtn = [[UIButton alloc] init];
        [shopBtn setImage:kGetImage(@"shop_enter") forState:UIControlStateNormal];
        [headContentView addSubview:shopBtn];
        [shopBtn addTarget:self action:@selector(shopClick) forControlEvents:UIControlEventTouchUpInside];
        [shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headContentView.mas_top).offset(kRealValue(9));
            make.right.equalTo(headContentView.mas_right).offset(-kRealValue(16));
        }];
        
        
        UIButton *jihuoBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(86), kRealValue(67), kRealValue(46), kRealValue(17))];
        jihuoBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
        [jihuoBtn setTitle:@"激活" forState:UIControlStateNormal];
        [jihuoBtn setTitleColor:[UIColor colorWithHexString:@"f83737"] forState:UIControlStateNormal];
        [jihuoBtn addTarget:self action:@selector(jihuoClick) forControlEvents:UIControlEventTouchUpInside];
        [headContentView addSubview:jihuoBtn];
        ViewBorderRadius(jihuoBtn, kRealValue(8), 1, [UIColor colorWithHexString:@"f83737"]);
        
        
        //bottom
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(248))];
        bottomView.backgroundColor = [UIColor clearColor];
        
        _contentTableView.tableHeaderView = headView;
        _contentTableView.tableFooterView = bottomView;

        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kRealValue(20), kScreenWidth, kRealValue(228))];
        imageView.image = kGetImage(@"sign_bg");
        [bottomView addSubview:imageView];
        
        
        UILabel *lineViews = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(10), 0, kRealValue(3) , kRealValue(16))];
        lineViews.layer.cornerRadius = kRealValue(3);
        lineViews.layer.masksToBounds = YES;
        lineViews.backgroundColor = [UIColor whiteColor];
        [imageView  addSubview:lineViews];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"签到积分规则";
        titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(16)];
        titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        [imageView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(lineViews.mas_centerY).offset(0);
            make.left.equalTo(lineViews.mas_right).offset(kRealValue(10));
        }];
        
        self.footLabel = [[UILabel alloc] init];
//        self.footLabel.text = @"签到积分规则";
        self.footLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        self.footLabel.numberOfLines = 0;
        self.footLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        [imageView addSubview:self.footLabel];
        [self.footLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_left).offset(0);
            make.width.mas_equalTo(kRealValue(330));
            make.top.equalTo(titleLabel.mas_bottom).offset(kRealValue(5));
        }];
        if ([self.reposeDict[@"data"][@"user"][@"userRole"] integerValue]  == 1) {
            
            shopBtn.hidden = NO;
            jihuoBtn.hidden = NO;
        }else{
            shopBtn.hidden = YES;
            jihuoBtn.hidden = YES;
            [jifenLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headContentView.mas_top).offset(kRealValue(65));
                make.left.equalTo(headContentView.mas_left).offset(kRealValue(78));
            }];
        }
        
        
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


-(void)jihuoClick{

    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(29), kRealValue(315), kRealValue(228))];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.masksToBounds = YES;
    contentView.layer.cornerRadius = kRealValue(5);
    
    UILabel  *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(27), kRealValue(315), kRealValue(20))];
    titleLabel.font = [UIFont fontWithName:kPingFangMedium size:kRealValue(16)];
    titleLabel.text = @"积分激活";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [contentView addSubview:titleLabel];
    
    
    UILabel *textLabel = [UILabel new];
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont fontWithName:kPingFangLight size:kRealValue(14)];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    textLabel.text =  @"您可以邀请您的直属店主帮助您将积分兑换为陌币，陌币可在店主店铺兑换商品";
    [contentView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView.mas_centerX).offset(0);
        make.width.mas_equalTo(kRealValue(265));
        make.top.equalTo(contentView.mas_top).offset(kRealValue(73));
    }];
    

    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:contentView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
    // 3.2 显示时背景的透明度
    popView.popBGAlpha = 0.5f;
    // 3.3 显示时是否监听屏幕旋转
    popView.isObserverOrientationChange = YES;
    // 3.4 显示时动画时长
    popView.popAnimationDuration = 0.3f;
    // 3.5 移除时动画时长
    popView.dismissAnimationDuration = 0.3f;
    popView.isClickBGDismiss = YES;
    
    // 3.6 显示完成回调
    popView.popComplete = ^{
        MHLog(@"显示完成");
    };
    // 3.7 移除完成回调
    popView.dismissComplete = ^{
        MHLog(@"移除完成");
    };
    [popView pop];
    
    
    
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(20), kRealValue(133), kRealValue(111), kRealValue(34))];
    leftBtn.backgroundColor = [UIColor colorWithHexString:@"#ff6683"];
    leftBtn.layer.cornerRadius = kRealValue(17);
    [leftBtn bk_addEventHandler:^(id sender) {
        [popView dismiss];
        //激活接口
        [[MHUserService sharedInstance]initwithJifenActive:self.integralstrs completionBlock:^(NSDictionary *response, NSError *error) {
              KLToast(response[@"message"]);
            if (ValidResponseDict(response)) {
                
                NSMutableAttributedString *integralStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",response[@"data"][@"availableIntegral"],response[@"data"][@"integral"]]];
                
                [integralStr addAttribute:NSForegroundColorAttributeName value:  [UIColor colorWithHexString:@"ff6583"] range:NSMakeRange(0,[response[@"data"][@"availableIntegral"] length])];
                self.integralLabel.attributedText = integralStr;
                self.integralstrs =  response[@"data"][@"availableIntegral"];
                //陌币
                NSMutableAttributedString *mobiStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",response[@"data"][@"availableBalance"],response[@"data"][@"balance"]]];
                
                [mobiStr addAttribute:NSForegroundColorAttributeName value:  [UIColor colorWithHexString:@"ffae45"] range:NSMakeRange(0,[response[@"data"][@"availableBalance"] length])];
                self.moLabel.attributedText = mobiStr;
                
            }
        }];
        
        
    } forControlEvents:UIControlEventTouchUpInside];
    leftBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [leftBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"确认激活" forState:UIControlStateNormal];
    leftBtn.layer.masksToBounds = YES;
    [contentView addSubview:leftBtn];
    leftBtn.centerX  = kRealValue(158);
    
    
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(20), kRealValue(173), kRealValue(111), kRealValue(34))];
    rightBtn.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    rightBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"ff6683"] forState:UIControlStateNormal];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"暂不激活"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ff6683"] range:NSMakeRange(0, [str length])];
    [rightBtn setAttributedTitle:str forState:UIControlStateNormal];
    
    
    [rightBtn bk_addEventHandler:^(id sender) {
        [popView dismiss];

        
    } forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:rightBtn];
    rightBtn.centerX  =  kRealValue(158);
    
    
}

- (void)shopClick{
    MHOtherStoreVC *vc = [[MHOtherStoreVC alloc] init];
    vc.shopId = [NSString stringWithFormat:@"%@",self.reposeDict[@"data"][@"user"][@"parentId"]];
    vc.name = [NSString stringWithFormat:@"%@",self.reposeDict[@"data"][@"user"][@"parentShopName"]];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHSignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHSignTableViewCell class])];

    if (!cell) {
        cell =[[MHSignTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([MHSignTableViewCell class]) withArr:self.reposeDict[@"data"][@"integrals"] withIndex: [self.reposeDict[@"data"][@"userIntegral"][@"days"] integerValue] - 1 withState:[self.reposeDict[@"data"][@"userIntegral"][@"signIn"] integerValue]];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.openClick= ^(NSDictionary *response) {
        //积分
        NSMutableAttributedString *integralStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",response[@"data"][@"user"][@"availableIntegral"],response[@"data"][@"user"][@"integral"]]];
        
        [integralStr addAttribute:NSForegroundColorAttributeName value:  [UIColor colorWithHexString:@"ff6583"] range:NSMakeRange(0,[response[@"data"][@"user"][@"availableIntegral"] length])];
        self.integralLabel.attributedText = integralStr;
        self.integralstrs =  response[@"data"][@"user"][@"availableIntegral"];
        //陌币
        NSMutableAttributedString *mobiStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",response[@"data"][@"user"][@"availableBalance"],response[@"data"][@"user"][@"balance"]]];
        
        [mobiStr addAttribute:NSForegroundColorAttributeName value:  [UIColor colorWithHexString:@"ffae45"] range:NSMakeRange(0,[response[@"data"][@"user"][@"availableBalance"] length])];
        self.moLabel.attributedText = mobiStr;
        
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(246);
    
}



@end
