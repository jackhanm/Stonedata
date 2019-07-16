//
//  MHLevelViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHLevelViewController.h"
#import "MHLevelShopCell.h"
#import "MHLevelDescCell.h"
#import "MHLevelShareCell.h"
#import "MHLevelLabelCell.h"
#import "MHProDetailViewController.h"
#import "MHShopCarProductModel.h"
#import "MHLevelRecordCell.h"
#import "ZJAnimationPopView.h"
#import "MHLevelRecordModel.h"
#import "UIControl+BlocksKit.h"
#import "MHLoginViewController.h"
#import "MHWebviewViewController.h"

@interface MHLevelViewController ()<UITableViewDataSource,UITableViewDelegate>{
     UILabel            *_titleLabel;
     NSArray            *_titleArr;
    NSArray             *_descArr;
}

@property (nonatomic, strong) UIView        *naviView;//自定义导航栏

@property (nonatomic, strong) UITableView   *contentTableView;

@property (nonatomic, strong) NSMutableArray   *listArr;

@property (nonatomic, strong) NSMutableArray   *yaoqingArr;

@property (nonatomic, strong) NSMutableArray   *bangdanArr;

@property (nonatomic, strong) UIButton   *editBtn;

@property (nonatomic, strong) UILabel   *phoneLabel;

@property (nonatomic, strong) NSString  *phoneStr;


@end

@implementation MHLevelViewController

static NSString * const MHLevelShopCellId = @"MHLevelShopCell";
static NSString * const MHLevelDescCellId = @"MHLevelDescCell";
static NSString * const MHLevelShareCellId = @"MHLevelShareCell";
- (void)viewDidLoad {
    [super viewDidLoad];
     self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#d8011f"];
    _titleArr = @[@"超值大礼包 任选一款",@"分享赚钱 自购省钱",@"四大优势 让你轻松做老板",@"活动规则"];
    _descArr = @[@"成功购买后，即可升级店主",@"邀请好友购物开店，可获佣金奖励",@"低风险 低投入 好货低价 下品保证",@""];
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.naviView];
    

    
    [[MHUserService sharedInstance]initwithYaoqingrecordCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.yaoqingArr = [MHLevelRecordModel baseModelWithArr:response[@"data"][@"list"]];
            [[MHUserService sharedInstance]initwithBangdanCompletionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    self.bangdanArr = [MHLevelRecordModel baseModelWithArr:response[@"data"][@"list"]];
                    [self.contentTableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
                    
                }
            }];
        }
    }];
    


    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[MHUserService sharedInstance]initwithVipProductCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.listArr  =   [MHShopCarProductModel baseModelWithArr:response[@"data"][@"list"]];
            [self.contentTableView reloadData];
        }
    }];
    
    
    if ([GVUserDefaults standardUserDefaults].accessToken ) {
        [[MHUserService sharedInstance]initwithShopManagetCompletionBlock:^(NSDictionary *response, NSError *error) {
            if (ValidResponseDict(response)) {
                self.phoneStr = response[@"data"];
            }
        }];
    }
}


- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kTopHeight)];
        _naviView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];//该透明色设置不会影响子视图
        _titleLabel= [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:kPingFangMedium size:16];
        _titleLabel.textColor = [UIColor colorWithHexString:@"000000" andAlpha:0];
        _titleLabel.text = @"升级店主";
        _titleLabel.frame = CGRectMake(5, 25 + kTopHeight - 64, kScreenWidth/1.5, 25);
        _titleLabel.centerX = _naviView.centerX;
//        _titleLabel.centerY = backButton.centerY;
        [_naviView addSubview:_titleLabel];
        
         _editBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kRealValue(71), 25 + kTopHeight - 64, kRealValue(71), kRealValue(25))];
        _editBtn.userInteractionEnabled = YES;
        [_editBtn addTarget:self action:@selector(changeDesc) forControlEvents:UIControlEventTouchUpInside];
        [_editBtn setBackgroundImage:[UIImage imageNamed:@"dianpuguanjia"] forState:UIControlStateNormal];
        [_naviView addSubview:_editBtn];
        
        
    }
    return _naviView;
}

-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight - kTabBarHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor colorWithHexString:@"#d8011f"];
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
         _contentTableView.sectionFooterHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHLevelShopCell class] forCellReuseIdentifier:MHLevelShopCellId];
        [_contentTableView registerClass:[MHLevelDescCell class] forCellReuseIdentifier:MHLevelDescCellId];
        [_contentTableView registerClass:[MHLevelShareCell class] forCellReuseIdentifier:MHLevelShareCellId];
        [_contentTableView registerClass:[MHLevelLabelCell class] forCellReuseIdentifier:NSStringFromClass([MHLevelLabelCell class])];
        [_contentTableView registerClass:[MHLevelRecordCell class] forCellReuseIdentifier:NSStringFromClass([MHLevelRecordCell class])];
        //
        
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(293))];
        headImageView.image = kGetImage(@"level_header");
        headImageView.userInteractionEnabled = YES;
        UIImageView *footer = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(84))];
        footer.backgroundColor = [UIColor colorWithHexString:@"#d8011f"];
        footer.userInteractionEnabled = YES;
        
        
  

        
        UIButton *footerImageView = [[UIButton alloc]initWithFrame:CGRectMake(kRealValue(10), kRealValue(10), kRealValue(355), kRealValue(44))];
        [footerImageView setBackgroundImage: kGetImage(@"level_footer") forState:UIControlStateNormal];
        [footer addSubview:footerImageView];
        footerImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gotogradetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotograde)];
        [footerImageView addGestureRecognizer:gotogradetap];
        
        _contentTableView.tableHeaderView = headImageView;
        _contentTableView.tableFooterView = footer;
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}



- (void)gotograde{
    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://wap.mohuyoupin.com/campus/product_talk.html" comefrom:@"LauchImage"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)changeDesc{
    
    // 2.Init【初始化】
    if ([GVUserDefaults standardUserDefaults].accessToken  == nil) {
        
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
        
    }else{
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(295), kRealValue(212))];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = kRealValue(8);
        bgView.layer.masksToBounds = YES;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(30), kRealValue(295), kRealValue(16))];
        titleLabel.text = @"【未来商视】用心选好货";
        titleLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(16)];
        titleLabel.textColor = [UIColor colorWithHexString:@"000000"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:titleLabel];
        
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(55), kRealValue(295), kRealValue(17))];
        descLabel.text = @"联系您的店铺管家 获得更多开店帮助";
        descLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(13)];
        descLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        descLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:descLabel];
        
        _phoneLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(91), kRealValue(245), kRealValue(35))];
        _phoneLabel.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        _phoneLabel.text = self.phoneStr ;
        _phoneLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(21)];
        _phoneLabel.textColor = [UIColor colorWithHexString:@"#d8011f"];
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.centerX = descLabel.centerX;
        [bgView addSubview:_phoneLabel];
        
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(24), kRealValue(153), kRealValue(113), kRealValue(32))];
        leftBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
        [leftBtn setTitle:@"以后再说" forState:UIControlStateNormal];
        [leftBtn setBackgroundColor:[UIColor colorWithHexString:@"#d7d7d7"]];
        [bgView addSubview:leftBtn];
        leftBtn.layer.cornerRadius = kRealValue(16);
        leftBtn.layer.masksToBounds = YES;
        
        
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kRealValue(157),kRealValue(153), kRealValue(113), kRealValue(32))];
        rightBtn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(14)];
        [rightBtn setTitle:@"立即联系" forState:UIControlStateNormal];
        [rightBtn setBackgroundColor:[UIColor colorWithHexString:@"#d8011f"]];
        [bgView addSubview:rightBtn];
        rightBtn.layer.cornerRadius = kRealValue(16);
        rightBtn.layer.masksToBounds = YES;

        
        
        
        
        ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView:bgView popStyle:ZJAnimationPopStyleScale dismissStyle:ZJAnimationDismissStyleScale];
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
        
        
        [leftBtn bk_addEventHandler:^(id sender) {
            [popView dismiss];
        } forControlEvents:UIControlEventTouchUpInside];
        
        [rightBtn bk_addEventHandler:^(id sender) {
            [popView dismiss];
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.phoneStr];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    
  
  
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _contentTableView) {
        //当前偏移量
        CGFloat yOffset  = scrollView.contentOffset.y;
        //更改导航栏的背景图的透明度
        CGFloat alpha = 0;
        if (yOffset<=0) {
            alpha = 0;
        } else if(yOffset < (kTopHeight+50)){
            alpha = yOffset/(kTopHeight+50);
        }else if(yOffset >= (kTopHeight+50)){
            alpha = 1;
        }else{
            alpha = 0;
        }
        
        _titleLabel.textColor = [UIColor colorWithHexString:@"000000" andAlpha:alpha];
        self.naviView.backgroundColor = [UIColor colorWithHexString:@"0xF9FBFB" andAlpha:alpha];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _listArr.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MHLevelShopCell *cell = [tableView dequeueReusableCellWithIdentifier:MHLevelShopCellId];
        cell.ProductModel = _listArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 1){
        MHLevelShareCell *cell = [tableView dequeueReusableCellWithIdentifier:MHLevelShareCellId];
        if ([self.bangdanArr count]>0) {
            cell.bangdanArr = self.bangdanArr;
            cell.yaoqingArr = self.yaoqingArr;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
      
    }else if (indexPath.section == 2){
        MHLevelDescCell *cell = [tableView dequeueReusableCellWithIdentifier:MHLevelDescCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else if (indexPath.section == 3){
        MHLevelLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHLevelLabelCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    return nil;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kRealValue(228);
    }else if (indexPath.section == 1){
        return kRealValue(400);
    }else if (indexPath.section == 2){
        return kRealValue(339);
    }else if (indexPath.section == 3){
        return kRealValue(559);
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return nil;
    }
    UIView  *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(90))];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#d8011f"];
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10), 0, kScreenWidth - kRealValue(20), kRealValue(90))];
    //设置左上右上的圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:sectionView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kRealValue(5), kRealValue(5))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = sectionView.bounds;
    maskLayer.path = maskPath.CGPath;
    sectionView.layer.mask = maskLayer;
    sectionView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:sectionView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(20), kScreenWidth, kRealValue(22))];
    titleLabel.text = _titleArr[section];
    titleLabel.font = [UIFont fontWithName:kPingFangSemibold size:kFontValue(21)];
    titleLabel.textColor = [UIColor colorWithHexString:@"#d8011f"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.centerX = kScreenWidth/2 - kRealValue(10);
    [sectionView addSubview:titleLabel];
    
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kRealValue(52), kScreenWidth, kRealValue(17))];
    descLabel.text = _descArr[section];
    descLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    descLabel.textColor = [UIColor colorWithHexString:@"#6E6E6E"];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.centerX = kScreenWidth/2 - kRealValue(10);
    [sectionView addSubview:descLabel];

    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return kRealValue(10);
    }
  return  kRealValue(89);
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return kRealValue(20);
    }
    return kRealValue(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView  *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(20))];
        bgView.backgroundColor = [UIColor colorWithHexString:@"#d8011f"];
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10), 0, kScreenWidth-kRealValue(20), kRealValue(10))];
        contentView.backgroundColor = [UIColor whiteColor];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:contentView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(kRealValue(5), kRealValue(5))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = contentView.bounds;
        maskLayer.path = maskPath.CGPath;
        contentView.layer.mask = maskLayer;
        contentView.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:contentView];
        return bgView;
    }
    UIView  *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(10))];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#d8011f"];
    return bgView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MHShopCarProductModel *model = _listArr[indexPath.row];;
        MHProDetailViewController *vc = [[MHProDetailViewController alloc]init];
        vc.comeform = @"vip";
        vc.productId = model.productId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
