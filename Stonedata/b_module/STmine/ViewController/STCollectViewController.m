//
//  STCollectViewController.m
//  Stonedata
//
//  Created by yuhao on 2019/7/15.
//  Copyright © 2019 hf. All rights reserved.
//

#import "STCollectViewController.h"
#import "SGPagingView.h"
#import "STCollectPageOne.h"
@interface STCollectViewController ()<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;
@property (nonatomic, strong) NSMutableArray *cateArr;
@property (nonatomic, strong) NSMutableArray *titleArr;

@end

@implementation STCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColorFromRGB(0xffffff);
    [self createview];
    self.title =@"我的收藏";
    
    // Do any additional setup after loading the view.
}
-(void)createview
{
    self.titleArr = [NSMutableArray arrayWithObjects:@"新闻",@"社区",@"观点", nil];
    NSMutableArray *childArr =[NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        
            STCollectPageOne *vc = [[STCollectPageOne alloc]init];
            [childArr addObject:vc];
        
    }
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.indicatorStyle = SGIndicatorStyleDynamic;
    configure.titleAdditionalWidth = 25;
    configure.showBottomSeparator = NO;
    configure.indicatorCornerRadius = 3;
    configure.titleColor = [UIColor colorWithHexString:@"000000"];
    configure.titleFont = [UIFont fontWithName:kPingFangRegular size:14];
    configure.titleSelectedColor = KColorFromRGB(kThemecolor);
    configure.indicatorColor = KColorFromRGB(kThemecolor);
    configure.indicatorHeight = 2;
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(kRealValue(80), kRealValue(0), kScreenWidth-kRealValue(160), 40) delegate:self titleNames:self.titleArr configure:configure];
    self.pageTitleView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.view addSubview:_pageTitleView];
    
    /// pageContentCollectionView
    CGFloat ContentCollectionViewHeight = kScreenHeight- CGRectGetMaxY(_pageTitleView.frame);
    self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), kScreenWidth, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
    _pageContentCollectionView.delegatePageContentCollectionView = self;
    [self.view addSubview:_pageContentCollectionView];
}
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
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
