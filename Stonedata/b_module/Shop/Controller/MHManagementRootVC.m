//
//  MHAssetRootVC.m
//  mohu
//
//  Created by AllenQin on 2018/9/30.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHManagementRootVC.h"
#import "SGPagingView.h"
#import "MHManagementDetailVC.h"

@interface MHManagementRootVC ()<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;

@end

@implementation MHManagementRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"经营数据";
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    configure.titleAdditionalWidth = 20;
    configure.showBottomSeparator = NO;
    configure.titleFont = [UIFont fontWithName:kPingFangRegular size:14];
    configure.titleSelectedFont =[UIFont fontWithName:kPingFangRegular size:14];
    configure.indicatorCornerRadius = 2.5;
    configure.titleColor = [UIColor colorWithHexString:@"666666"];
    configure.titleSelectedColor = [UIColor colorWithHexString:@"FF5100"];
    configure.indicatorColor = [UIColor colorWithHexString:@"FF5100"];
    configure.indicatorHeight = 1.5;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) delegate:self titleNames:@[@"进行中",@"退换货",@"已完成"] configure:configure];
    self.pageTitleView.backgroundColor = [UIColor colorWithHexString:@"FAFBFC"];
    MHManagementDetailVC *one  = [[MHManagementDetailVC alloc]initWithId:@"ON_GOING"];
    MHManagementDetailVC *two  = [[MHManagementDetailVC alloc]initWithId:@"RETURN_GOOD"];
    MHManagementDetailVC *three  = [[MHManagementDetailVC alloc]initWithId:@"COMPLETED"];
    NSArray *childArr = @[one,two,three];
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
