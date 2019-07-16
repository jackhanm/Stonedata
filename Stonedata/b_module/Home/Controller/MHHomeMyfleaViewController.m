//
//  MHHomeMyfleaViewController.m
//  mohu
//
//  Created by yuhao on 2019/1/9.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHHomeMyfleaViewController.h"
#import "SGPagingView.h"
#import "MHHomeMyfleaOneViewController.h"
#import "MHHomeMyfleaTwoViewController.h"
#import "MHAssetRootVC.h"
@interface MHHomeMyfleaViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentCollectionView;
@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong)UILabel *moneylab;
@end
@implementation MHHomeMyfleaViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getnetWork];
}

-(void)getnetWork
{
    self.dict = [NSMutableDictionary dictionary];
    [[MHUserService sharedInstance] initWithUserInfoCompletionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.dict  = [response valueForKey:@"data"];
            self.moneylab.text = self.dict[@"availableBalance"];
        }
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的跳蚤";
    [self createview];
    // Do any additional setup after loading the view.
}
-(void)MyFlealist
{
    MHAssetRootVC *vc = [[MHAssetRootVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)createview
{
    self.view.backgroundColor = KColorFromRGB(0xF2F3F2);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kRealValue(10), kRealValue(30), kRealValue(30));
    btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [btn setTitle:@"明细" forState:UIControlStateNormal];
    [btn setTitleColor:KColorFromRGB(0x333333) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(MyFlealist) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    
    // 头图
    UIImageView *headImagebg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(136))];
    headImagebg.image = kGetImage(@"user_menoy_bg");
    [self.view addSubview:headImagebg];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(33), kScreenWidth, kRealValue(25))];
    titlelab.text = @"我的陌币";
    titlelab.textAlignment = NSTextAlignmentCenter;
    titlelab.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    titlelab.textColor = [UIColor whiteColor];
    [self.view addSubview:titlelab];
    
    self.moneylab = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(62), kScreenWidth, kRealValue(30))];
//    self.moneylab.text = @"0";
    self.moneylab.textAlignment = NSTextAlignmentCenter;
    self.moneylab.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(30)];
    self.moneylab.textColor = [UIColor whiteColor];
    [self.view addSubview:self.moneylab];
    

    
    //左右栏
    NSArray *titleArr = @[@"当前拥有", @"转卖记录"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    configure.titleAdditionalWidth = 52;
    configure.showBottomSeparator = NO;
    configure.indicatorCornerRadius = 2.5;
    configure.titleColor = [UIColor colorWithHexString:@"333333"];
    configure.indicatorAdditionalWidth = kRealValue(62);
    configure.titleSelectedColor = [UIColor colorWithHexString:@"e41d13"];
    configure.indicatorColor = [UIColor colorWithHexString:@"e41d13"];
    configure.indicatorHeight = 1.5;
    configure.titleFont = [UIFont systemFontOfSize:15];
    //    configure.indicatorFixedWidth = 50;
    
    
    
    MHHomeMyfleaOneViewController *oneVC = [[MHHomeMyfleaOneViewController alloc] init];
    MHHomeMyfleaTwoViewController *twoVC = [[MHHomeMyfleaTwoViewController alloc] init];
    
    NSArray *childArr = @[oneVC, twoVC];
    /// pageContentCollectionView
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, kRealValue(160), self.view.frame.size.width, kScreenHeight -kTopHeight - kRealValue(160) ) parentVC:self childVCs:childArr];
    _pageContentCollectionView.delegatePageContentScrollView = self;
     [self.view addSubview:_pageContentCollectionView];
    
    // 标题栏
    UIView *titlebgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(11), kRealValue(116), kRealValue(355),  kRealValue(43))];
    titlebgView.backgroundColor = [UIColor whiteColor];
    titlebgView.layer.cornerRadius =3;
    [self.view addSubview:titlebgView];
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(2, 0, titlebgView.frame.size.width-4, 43) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.backgroundColor =[UIColor colorWithHexString:@"FAFBFC"];
    [titlebgView addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    
}
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentScrollViewCurrentIndex:selectedIndex];
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    if (index == 0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
@end
