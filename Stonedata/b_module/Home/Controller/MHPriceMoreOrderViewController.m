//
//  MHPriceMoreOrderViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHPriceMoreOrderViewController.h"
#import "SGPagingView.h"
#import "MHPriceMoreOderOneViewController.h"
#import "MHPriceMoreOderTwoViewController.h"
@interface MHPriceMoreOrderViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentCollectionView;


@end

@implementation MHPriceMoreOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的奖多多";
    [self setupPageView];
    // Do any additional setup after loading the view.
}
- (void)setupPageView {
    
    
    NSArray *titleArr = @[@"我的奖品", @"奖多多订单"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    configure.titleAdditionalWidth = 52;
    configure.showBottomSeparator = NO;
    configure.indicatorCornerRadius = 2.5;
    configure.titleColor = [UIColor colorWithHexString:@"000000"];
    configure.titleSelectedColor = [UIColor colorWithHexString:@"FF5100"];
    configure.indicatorColor = [UIColor colorWithHexString:@"FF5100"];
    configure.indicatorHeight = 1.5;
    configure.titleFont = [UIFont systemFontOfSize:15];
    //    configure.indicatorFixedWidth = 50;
    
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) delegate:self titleNames:titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor colorWithHexString:@"FAFBFC"];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    MHPriceMoreOderOneViewController *oneVC = [[MHPriceMoreOderOneViewController alloc] init];
    MHPriceMoreOderTwoViewController *twoVC = [[MHPriceMoreOderTwoViewController alloc] init];
    
    NSArray *childArr = @[oneVC, twoVC];
    /// pageContentCollectionView
    CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:childArr];

    _pageContentCollectionView.delegatePageContentScrollView = self;
    [self.view addSubview:_pageContentCollectionView];
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {

   
     [self.pageContentCollectionView setPageContentScrollViewCurrentIndex:selectedIndex];
    
}

- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
