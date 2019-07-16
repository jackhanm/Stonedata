

//
//  MHPriceMoreViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHPriceMoreViewController.h"
#import "MHHuGuesscell.h"
#import "MHProDetailViewController.h"
#import "MHPriceMoreDetailViewController.h"
#import "MHHucaiRuleView.h"
#import "MHPriceMoreOrderViewController.h"
#import "MHPriceMoreListModel.h"
#import "MHLoginViewController.h"
#import "MHWebviewViewController.h"
#define kTopViewHeight kRealValue(0)

#define headViewHeight kScreenWidth

#define iPhone5s ([[UIScreen mainScreen] bounds].size.height == 568)

#define iPhone6 ([[UIScreen mainScreen] bounds].size.height == 667)

#define iPhone6Plus ([[UIScreen mainScreen] bounds].size.height == 736)

#define iPhoneX ([[UIScreen mainScreen] bounds].size.height == 812)
@interface MHPriceMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIView * tipLine;

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) UIView * naviView;

@property(nonatomic,strong) UILabel * titleLabel;

@property(nonatomic,strong) UIImageView * headImageView;

@property(nonatomic,strong) UIScrollView * topView;

@property(nonatomic,strong) UIButton *previousBtn;

@property(nonatomic,strong) NSMutableArray *titlesButtons;

@property(nonatomic,strong)MHHucaiRuleView *ruleView;

@property(nonatomic,strong)NSMutableArray *listArr;
@end

@implementation MHPriceMoreViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getnetwork];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden =YES;
    [self createview];
    self.view.backgroundColor = KColorFromRGB(0xFF644D);
    // Do any additional setup after loading the view.
}
-(void)getnetwork
{
    self.listArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initWithPriceMorepageSize:@"10" pageIndex:@"1" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.listArr = [MHPriceMoreListModel baseModelWithArr:response[@"data"]];
            if (self.listArr.count > 0) {
                [self.tableView reloadData];
            }
        }
    }];
}
-(void)createview
{
    [self setHeadImage];
    [self setNav];
    [self setTableView];
    UIButton *myhucai = [UIButton buttonWithType:UIButtonTypeCustom];
    [myhucai setImage:kGetImage(@"prizemore") forState:UIControlStateNormal];
    [myhucai addTarget:self action:@selector(MYhucaiAct) forControlEvents:UIControlEventTouchUpInside];
    myhucai.frame= CGRectMake(kScreenWidth -kRealValue(75),kScreenHeight- kRealValue(85), kRealValue(67), kRealValue(59));
    [self.view addSubview:myhucai];
    
    
    
}
-(void)MYhucaiAct
{
    
    if (!klStringisEmpty([GVUserDefaults standardUserDefaults].userRole)){
        MHPriceMoreOrderViewController *vc = [[MHPriceMoreOrderViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
       
        
    
   
    
    
}

- (void)setHeadImage{
    
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headViewHeight)];
    headImage.image = [UIImage imageNamed:@"poster_prize_home_head"];
    headImage.userInteractionEnabled = YES;
    [self.view addSubview:headImage];
    self.headImageView = headImage;
    self.headImageView.userInteractionEnabled = YES;
    

}
-(void)labelAct
{
    
    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://wap.mohuyoupin.com/jdd_rule.html" comefrom:@"prizemore"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)setNav{
    UIView *naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopHeight)];
    self.naviView = naviView;
    naviView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:naviView];
    //左上角返回按钮
    UIView *leftView = [[UIImageView alloc] init];
    leftView.userInteractionEnabled = YES;
    leftView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    leftView.layer.cornerRadius = 15.0f;
    leftView.clipsToBounds = YES;
    [naviView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(naviView.mas_left).offset(12);
        if (iPhoneX) {
            make.top.equalTo(naviView.mas_top).offset(53);
        }else{
            make.top.equalTo(naviView.mas_top).offset(29);
        }
        make.width.height.offset(30);
    }];
    UIButton *leftBtn = [[UIButton alloc] init];
    
    UIImage *reftImage = [[UIImage imageNamed:@"ic_status_return_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [leftBtn setImage:reftImage forState:UIControlStateNormal];
    [leftBtn setImage:reftImage forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        [make edges];
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.text = @"奖多多活动";
    titleLabel.alpha = 0;
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(naviView.mas_centerX).offset(0);
        make.centerY.equalTo(leftView.mas_centerY).offset(0);
        make.left.equalTo(naviView).offset(50);
        make.right.equalTo(naviView).offset(-50);
    }];
    
}



- (void)setTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kTopHeight + kTopViewHeight, kScreenWidth, kScreenHeight -kTopHeight-kTopViewHeight) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[MHHuGuesscell class] forCellReuseIdentifier:NSStringFromClass([MHHuGuesscell class])];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    UIView *labelbg = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth -kRealValue(50), 0, kRealValue(70), kRealValue(22))];
    labelbg.layer.masksToBounds =YES;
    labelbg.layer.cornerRadius = kRealValue(11);
    //    labelbg.layer.borderWidth = 1/ kScreenScale;
    labelbg.userInteractionEnabled = YES;
    labelbg.backgroundColor = KColorFromRGBA(0xFF644D, 1);
    //    labelbg.layer.borderColor = [UIColor blackColor].CGColor;
    [self.tableView addSubview:labelbg];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kRealValue(15), kRealValue(0), kRealValue(50), kRealValue(22))];
    label.text = @"规则";
    label.textColor = KColorFromRGB(0xffffff);
    label.textAlignment = NSTextAlignmentLeft;
    label.userInteractionEnabled = YES;
    label.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(11)];
    [labelbg addSubview:label];
    
    UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelAct)];
    [labelbg addGestureRecognizer:tapAct];
    UITapGestureRecognizer *tapAct1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelAct)];
    [label addGestureRecognizer:tapAct1];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(135);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return headViewHeight - kTopHeight - kTopViewHeight;;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.listArr.count > 0) {
        return self.listArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHHuGuesscell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHHuGuesscell class]) forIndexPath:indexPath];
    cell.backgroundColor = KColorFromRGB(0xFF664F);
    cell.selectionStyle=UITableViewCellEditingStyleNone;
    if (self.listArr.count > 0) {
        MHPriceMoreListModel *model = [self.listArr objectAtIndex:indexPath.row];
        [cell.img sd_setImageWithURL:[NSURL URLWithString:model.productSmallImage] placeholderImage:kGetImage(kfailImage)];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.productName];
        cell.pricelabel.text = [NSString stringWithFormat:@"¥%@", model.productPrice];
        cell.Originpricelabel.hidden = YES;
        cell.salenumlabel.text = @"";
        cell.Buybtn.backgroundColor = KColorFromRGB(0xFF644C);
        NSString *Str = [NSString stringWithFormat:@"活动场次%@场",[NSString stringWithFormat:@"%@",model.shareCount]];
        NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
        [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xe20909) range:NSMakeRange(4, [NSString stringWithFormat:@"%@",model.shareCount].length)];
        [attstring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontValue(12)] range:NSMakeRange(4, [NSString stringWithFormat:@"%@",model.shareCount].length)];
        cell.Originpricelabel.attributedText = attstring;
        cell.PriceMoregotodetal = ^{
            MHPriceMoreListModel *model = [self.listArr objectAtIndex:indexPath.row];
            MHPriceMoreDetailViewController *vc= [[MHPriceMoreDetailViewController alloc]initWithdrawId:[NSString stringWithFormat:@"%@", model.drawId] comefrom:@"list"];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        };
        if (!klStringisEmpty([GVUserDefaults standardUserDefaults].userRole)) {
            if ([[GVUserDefaults standardUserDefaults].userRole integerValue ]< 2) {
                //普通用户
                [cell.Buybtn setTitle:@"发起活动" forState:UIControlStateNormal];
            }else{
                //店主用户
                if ([model.status isEqualToString:@"PENDING"]) {
                    [cell.Buybtn setTitle:@"暂不可用" forState:UIControlStateNormal];
                    cell.Buybtn.backgroundColor = [UIColor lightGrayColor];
                }
                if ([model.status isEqualToString:@"INITIATE"]) {
                    [cell.Buybtn setTitle:@"发起活动" forState:UIControlStateNormal];
                }
                if ([model.status isEqualToString:@"ACTIVE"]) {
                    [cell.Buybtn setTitle:@"继续邀请" forState:UIControlStateNormal];
                }
                if ([model.status isEqualToString:@"UNOPENED"]) {
                    [cell.Buybtn setTitle:@"立即开奖" forState:UIControlStateNormal];
                }
                
                
                
            }
        }else{
             [cell.Buybtn setTitle:@"发起活动" forState:UIControlStateNormal];
        }
        
    
        
    }
    
    //    cell.textLabel.text = [NSString stringWithFormat:@"商品%zd",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat Offset = (scrollView.contentOffset.y - headViewHeight) / self.tableView.frame.size.height;
    if(yOffset <  0) {
        CGRect f = self.headImageView.frame;
        //上下放大
        f.origin.y = 0;
        f.origin.x = yOffset / 2.0;
        f.size.height =  headViewHeight - yOffset;
        f.size.width = kScreenWidth - yOffset;
        //改变头部视图的frame
        self.headImageView.frame = f;
    }else{
        CGRect f = self.headImageView.frame;
        //上下放大
        f.origin.y = - yOffset / 2.0;
        f.origin.x = 0;
        //改变头部视图的frame
        self.headImageView.frame = f;
    }
    
    if (iPhone5s) {
        self.naviView.backgroundColor =KColorFromRGBA(0xFF664F,(Offset+0.230978) *7.5 );
        self.topView.alpha = (Offset+0.230978) *8.5;
    }else if (iPhone6) {
        self.naviView.backgroundColor = KColorFromRGBA(0xFF664F,(Offset+0.230978) *7.5 );
        self.topView.alpha = (Offset+0.230978) *7.5;
    }else if (iPhone6Plus) {
        self.naviView.backgroundColor = KColorFromRGBA(0xFF664F,(Offset+0.230978) *7.5 );
        self.topView.alpha = (Offset+0.230978) *7.0;
    }else {
        self.naviView.backgroundColor = KColorFromRGBA(0xFF664F,(Offset+0.230978) *7.5 );
        self.topView.alpha = (Offset+0.230978) *7.5;
    }
    self.titleLabel.alpha = (Offset+0.254873) *7;
    

    
    
}

- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHPriceMoreListModel *model = [self.listArr objectAtIndex:indexPath.row];
    if ([model.status isEqualToString:@"PENDING"]) {
        
    }
    if ([model.status isEqualToString:@"INITIATE"]) {
        MHPriceMoreDetailViewController *vc= [[MHPriceMoreDetailViewController alloc]initWithdrawId:[NSString stringWithFormat:@"%@", model.drawId] comefrom:@"list"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([model.status isEqualToString:@"ACTIVE"]) {
        MHPriceMoreDetailViewController *vc= [[MHPriceMoreDetailViewController alloc]initWithdrawId:[NSString stringWithFormat:@"%@", model.drawId] comefrom:@"list"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([model.status isEqualToString:@"UNOPENED"]) {
        MHPriceMoreDetailViewController *vc= [[MHPriceMoreDetailViewController alloc]initWithdrawId:[NSString stringWithFormat:@"%@", model.drawId] comefrom:@"list"];
        [self.navigationController pushViewController:vc animated:YES];
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
