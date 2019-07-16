//
//  MHSignRecordRootVC.m
//  mohu
//
//  Created by AllenQin on 2019/1/8.
//  Copyright © 2019 AllenQin. All rights reserved.
//

#import "MHSignRecordRootVC.h"
#import "SGPagingView.h"
#import "MHSignRecordVC.h"

@interface MHSignRecordRootVC ()<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;

@end


@implementation MHSignRecordRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分记录";
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDefault;
    configure.titleAdditionalWidth = 20;
    configure.showBottomSeparator = NO;
    configure.titleFont = [UIFont fontWithName:kPingFangRegular size:14];
    configure.titleSelectedFont =[UIFont fontWithName:kPingFangRegular size:14];
    configure.indicatorCornerRadius = 2.5;
    configure.titleColor = [UIColor colorWithHexString:@"333333"];
    configure.titleSelectedColor = [UIColor colorWithHexString:@"#ff6371"];
    configure.indicatorColor = [UIColor colorWithHexString:@"#ff6371"];
    configure.indicatorHeight = 1.5;
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) delegate:self titleNames:@[@"待激活",@"已激活",@"获得积分"] configure:configure];
    self.pageTitleView.backgroundColor = [UIColor colorWithHexString:@"FAFBFC"];
    MHSignRecordVC *one  = [[MHSignRecordVC alloc]initWithId:@"EXPENSE_FREEZE"];
    MHSignRecordVC *two  = [[MHSignRecordVC alloc]initWithId:@"EXPENSE"];
    MHSignRecordVC *three  = [[MHSignRecordVC alloc]initWithId:@"INCOME"];
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
