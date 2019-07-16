//
//  MHNoviceViewController.m
//  mohu
//
//  Created by AllenQin on 2018/9/10.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHNoviceViewController.h"
#import "MHNoviceTableViewCell.h"

@interface MHNoviceViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UILabel            *_titleLabel;
}

@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) UIView        *naviView;//自定义导航栏

@end

@implementation MHNoviceViewController

static NSString * const MHNoviceViewCellId = @"MHNoviceViewCellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self.view addSubview:self.contentTableView];
    [self.view addSubview:self.naviView];
}



-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = [UIColor whiteColor];
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kBottomHeight, 0);
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(221))];
        headView.backgroundColor = [UIColor colorWithHexString:@"F7F8FA"];
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(211))];
        headImageView.backgroundColor = [UIColor redColor];
        [headView addSubview:headImageView];
        _contentTableView.tableHeaderView = headView;
        [_contentTableView registerClass:[MHNoviceTableViewCell class] forCellReuseIdentifier:MHNoviceViewCellId];
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
   return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHNoviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MHNoviceViewCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(130);
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
        _titleLabel.text = @"新人专享";
        _titleLabel.frame = CGRectMake(5, 25 + kTopHeight - 64, kScreenWidth/1.5, 25);
        _titleLabel.centerX = _naviView.centerX;
        _titleLabel.centerY = backButton.centerY;
        [_naviView addSubview:_titleLabel];
    }
    return _naviView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //当前偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    //第一部分：
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
