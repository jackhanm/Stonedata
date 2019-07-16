//
//  MHAssetRootVC.m
//  mohu
//
//  Created by AllenQin on 2018/9/30.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAssetRootVC.h"
#import "SGPagingView.h"
#import "MHAssetDetailVC.h"

@interface MHAssetRootVC ()<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;

@end

@implementation MHAssetRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资产明细";
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDynamic;
//    configure.titleAdditionalWidth = 35;
    configure.showBottomSeparator = NO;
    configure.titleFont = [UIFont fontWithName:kPingFangRegular size:14];
    configure.titleSelectedFont =[UIFont fontWithName:kPingFangRegular size:14];
    configure.indicatorCornerRadius = 2.5;
    configure.titleColor = [UIColor colorWithHexString:@"666666"];
    configure.titleSelectedColor = [UIColor colorWithHexString:@"FF5100"];
    configure.indicatorColor = [UIColor colorWithHexString:@"FF5100"];
    configure.indicatorHeight = 1.5;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) delegate:self titleNames:@[@"全部",@"推广奖励",@"佣金收益",@"提现",@"消费",@"转卖"] configure:configure];
    self.pageTitleView.backgroundColor = [UIColor colorWithHexString:@"FAFBFC"];
    MHAssetDetailVC *one  = [[MHAssetDetailVC alloc]initWithId:@""];
    MHAssetDetailVC *two  = [[MHAssetDetailVC alloc]initWithId:@"SPREAD_AWARD"];
    MHAssetDetailVC *three  = [[MHAssetDetailVC alloc]initWithId:@"PRODUCT_PROFIT"];
    MHAssetDetailVC *four  = [[MHAssetDetailVC alloc]initWithId:@"WITHDRAW"];
    MHAssetDetailVC *fifth  = [[MHAssetDetailVC alloc]initWithId:@"EXPENSE_BALANCE"];
    MHAssetDetailVC *sixth  = [[MHAssetDetailVC alloc]initWithId:@"RECOVER"];
    
    NSArray *childArr = @[one,two,three,four,fifth,sixth];
    CGFloat ContentCollectionViewHeight = kScreenHeight- CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), kScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
    [self.view addSubview:_pageTitleView];
    
}

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
