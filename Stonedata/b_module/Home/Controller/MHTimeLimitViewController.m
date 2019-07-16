//
//  MHTimeLimitViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/12.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHTimeLimitViewController.h"
#import "SGPagingView.h"
#import "MHChildOrderViewController.h"
#import "MHBaseTableView.h"

@interface MHTimeLimitViewController ()<UITableViewDataSource,UITableViewDelegate,SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>{
    UILabel            *_titleLabel;
}

@property (nonatomic, strong) MHBaseTableView   *contentTableView;
@property (nonatomic, strong) UIView        *naviView;//自定义导航栏
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) SGPageContentCollectionView *pageContentCollectionView;

@end

@implementation MHTimeLimitViewController

static NSString * const MHNoviceViewCellId = @"MHNoviceViewCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.canScroll = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptTimeLimtMsg) name:KNotificationFatherSrcoll object:nil];
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.naviView];
}


- (void)acceptTimeLimtMsg{
    self.canScroll = YES;
    [self changeChildCanScroll:NO];
}

-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[MHBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor whiteColor];
//        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kBottomHeight, 0);
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
//
        _contentTableView.showsVerticalScrollIndicator = NO;
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(211))];
        headImageView.backgroundColor = [UIColor redColor];
        _contentTableView.tableHeaderView = headImageView;
        [self.view addSubview:_contentTableView];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //添加
    [cell.contentView addSubview:self.pageTitleView];
    [cell.contentView addSubview:self.pageContentCollectionView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return kScreenHeight-kTopHeight;
}

- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kTopHeight)];
        _naviView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];//该透明色设置不会影响子视图
        //添加返回按钮
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setImage:[UIImage imageNamed:@"left_back"] forState:(UIControlStateNormal)];
        backButton.frame = CGRectMake(5, 25 + kTopHeight - 64, 33, 33);
        backButton.adjustsImageWhenHighlighted = NO;
        [backButton addTarget:self action:@selector(backBtnClicked) forControlEvents:(UIControlEventTouchUpInside)];
        [_naviView addSubview:backButton];
        
        _titleLabel= [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:kPingFangMedium size:16];
        _titleLabel.textColor = [UIColor colorWithHexString:@"000000" andAlpha:0];
        _titleLabel.text = @"限时抢购";
        _titleLabel.frame = CGRectMake(5, 25 + kTopHeight - 64, kScreenWidth/1.5, 25);
        _titleLabel.centerX = _naviView.centerX;
        _titleLabel.centerY = backButton.centerY;
        [_naviView addSubview:_titleLabel];
    }
    return _naviView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _contentTableView) {
        //当前偏移量
        CGFloat yOffset  = scrollView.contentOffset.y;
        MHLog(@"%f",yOffset);

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
        self.naviView.backgroundColor = [UIColor colorWithHexString:@"ffffff" andAlpha:alpha];
        if (yOffset >= kRealValue(211) - kTopHeight ) {

            scrollView.contentOffset = CGPointMake(0, kRealValue(211) - kTopHeight);
            if (self.canScroll) {
                self.canScroll = NO;
                [self changeChildCanScroll:YES];
            }
        }else{
            if (!self.canScroll) {//子视图没到顶部
                scrollView.contentOffset = CGPointMake(0, kRealValue(211) - kTopHeight);
            }
        }
    }
}

-(SGPageContentCollectionView *)pageContentCollectionView{
    if (!_pageContentCollectionView) {

        MHChildOrderViewController *oneVC = [[MHChildOrderViewController alloc] init];
        MHChildOrderViewController *twoVC = [[MHChildOrderViewController alloc] init];
        MHChildOrderViewController *threeVC = [[MHChildOrderViewController alloc] init];
        MHChildOrderViewController *fourVC = [[MHChildOrderViewController alloc] init];
        MHChildOrderViewController *fiveVC = [[MHChildOrderViewController alloc] init];
        NSArray *childArr = @[oneVC, twoVC, threeVC, fourVC, fiveVC];
        /// pageContentCollectionView
        CGFloat ContentCollectionViewHeight = self.view.frame.size.height - CGRectGetMaxY(_pageTitleView.frame);
        self.pageContentCollectionView = [[SGPageContentCollectionView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, ContentCollectionViewHeight) parentVC:self childVCs:childArr];
        _pageContentCollectionView.delegatePageContentCollectionView = self;
    }
    return _pageContentCollectionView;
}

-(void)changeChildCanScroll:(BOOL)canScroll{
//    for (MHChildOrderViewController *VC in _pageContentCollectionView.childViewControllers) {
//        VC.vcCanScroll = canScroll;
//        if (!canScroll) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
//            VC.tableView.contentOffset = CGPointZero;
//        }
//    }
}

-(SGPageTitleView *)pageTitleView{
    if (!_pageTitleView) {
        NSArray *titleArr = @[@"全部", @"待付款", @"待发货", @"待收货", @"完成"];
        SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
        configure.titleSelectedColor = [UIColor colorWithHexString:@"ffffff"];
        configure.indicatorStyle = SGIndicatorStyleCover;
        configure.indicatorColor = [UIColor colorWithHexString:@"333333"];
        configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
        configure.indicatorHeight = 122; // 说明：不设置，遮盖样式下，默认高度为文字高度 + 5；若设置无限大，则高度为 PageTitleView 高度
        configure.titleGradientEffect = YES;
        /// pageTitleView
        _pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreenWidth, 44) delegate:self titleNames:titleArr configure:configure];
        
    }
    return _pageTitleView;
}


- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentCollectionView setPageContentCollectionViewCurrentIndex:selectedIndex];
}

- (void)pageContentCollectionView:(SGPageContentCollectionView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
