
//
//  MHHucaiGuessOrderViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/11.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHHucaiGuessOrderViewController.h"
#import "SGPagingView.h"
#import "MHHucaiGuessChrildOneViewController.h"
#import "MHHucaiGuessChrldTwoViewController.h"

@interface MHHucaiGuessOrderViewController ()<SGPageTitleViewDelegate, SGPageContentScrollViewDelegate>
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentScrollView *pageContentCollectionView;

@end

@implementation MHHucaiGuessOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的狐猜";
    [self setupPageView];
    // Do any additional setup after loading the view.
}
- (void)setupPageView {

    
    NSArray *titleArr = @[@"我的奖品", @"狐猜订单"];
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
    self.pageTitleView.backgroundColor =[UIColor colorWithHexString:@"FAFBFC"];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    MHHucaiGuessChrildOneViewController *oneVC = [[MHHucaiGuessChrildOneViewController alloc] init];
    MHHucaiGuessChrldTwoViewController *twoVC = [[MHHucaiGuessChrldTwoViewController alloc] init];
  
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
- (void)pageContentScrollView:(SGPageContentScrollView *)pageContentScrollView index:(NSInteger)index {
    if (index == 0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
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
