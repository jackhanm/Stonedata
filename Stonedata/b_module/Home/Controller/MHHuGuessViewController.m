//
//  MHHuGuessViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/5.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHHuGuessViewController.h"
#import "MHHuGuesscell.h"
#import "MHProDetailViewController.h"
#import "MHHuGuessDetailViewController.h"
#import "MHHucaiGuessOrderViewController.h"
#import "MHHucaiRuleView.h"
#import "MHPriceMoreListModel.h"
#import "MHHucaiListModel.h"
#import "MHHuGuessDetailViewController.h"
#import "MHLoginViewController.h"
#import "MHWebviewViewController.h"
#define kTopViewHeight kRealValue(40)

#define headViewHeight kScreenWidth

#define iPhone5s ([[UIScreen mainScreen] bounds].size.height == 568)

#define iPhone6 ([[UIScreen mainScreen] bounds].size.height == 667)

#define iPhone6Plus ([[UIScreen mainScreen] bounds].size.height == 736)

#define iPhoneX ([[UIScreen mainScreen] bounds].size.height == 812)

@interface MHHuGuessViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIView * tipLine;

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) UIView * naviView;

@property(nonatomic,strong) UILabel * titleLabel;

@property(nonatomic,strong) UIImageView * headImageView;

@property(nonatomic,strong) UIScrollView * topView;

@property(nonatomic,strong) UIButton *previousBtn;

@property(nonatomic,strong) NSMutableArray *titlesButtons;

@property(nonatomic,strong)MHHucaiRuleView *ruleView;

@property(nonatomic,strong)NSMutableArray *sectionListArr;
@property(nonatomic,assign)BOOL IsClick;
@end

@implementation MHHuGuessViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getdata];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden =YES;
    self.view.backgroundColor = KColorFromRGB(0xFF8745);
    _IsClick =NO;
    // Do any additional setup after loading the view.
}
-(void)getdata
{
    self.sectionListArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initWithHucaipageSize:@"10" pageIndex:@"1" completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSMutableArray *Arr = [response valueForKey:@"data"];
            for (int i = 0; i < Arr.count; i++) {
                MHHucaiListModel *hucaimodel = [[MHHucaiListModel alloc]init];
                hucaimodel.roundName = [NSString stringWithFormat:@"%@人场",[Arr[i] valueForKey:@"roundName"]];
                NSMutableArray *Arr2 =[Arr[i] valueForKey:@"list"];
                for (int j = 0; j < Arr2.count; j++) {
                    NSMutableArray *Arr = [NSMutableArray array];
                    
                    Arr = [MHPriceMoreListModel baseModelWithArr:Arr2];
                    hucaimodel.listrArr = Arr;
                }
                
                [self.sectionListArr addObject:hucaimodel];
            }
            if (self.tableView) {
                [self.tableView reloadData];
            }else{
                [self createview];
            }
            
        }
        
    }];
}
-(void)createview
{
     [self setHeadImage];
     [self setNav];
    [self setTopView];
    [self setTableView];
    UIButton *myhucai = [UIButton buttonWithType:UIButtonTypeCustom];
    [myhucai setImage:kGetImage(@"hucai") forState:UIControlStateNormal];
    [myhucai addTarget:self action:@selector(MYhucaiAct) forControlEvents:UIControlEventTouchUpInside];
    myhucai.frame= CGRectMake(kScreenWidth -kRealValue(75),kScreenHeight- kRealValue(85), kRealValue(67), kRealValue(59));
    [self.view addSubview:myhucai];
    self.ruleView = [[MHHucaiRuleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.ruleView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.ruleView];
}
-(void)MYhucaiAct
{
    
    if (!klStringisEmpty([GVUserDefaults standardUserDefaults].userRole)){
        MHHucaiGuessOrderViewController *vc= [[MHHucaiGuessOrderViewController alloc]init];;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MHLoginViewController *login = [[MHLoginViewController alloc] init];
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:userNav animated:YES completion:nil];
    }
    
    
}
- (void)setHeadImage{
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headViewHeight)];
    headImage.image = [UIImage imageNamed:@"poster _ guess _ home"];
    headImage.userInteractionEnabled = YES;
    [self.view addSubview:headImage];
    self.headImageView = headImage;
    
    UIView *labelbg = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth -kRealValue(50), kTopHeight, kRealValue(70), kRealValue(22))];
    labelbg.layer.masksToBounds =YES;
    labelbg.layer.cornerRadius = kRealValue(11);
//    labelbg.layer.borderWidth = 1/ kScreenScale;
    labelbg.userInteractionEnabled = YES;
    labelbg.backgroundColor = KColorFromRGBA(0xFF8745, 1);
//    labelbg.layer.borderColor = [UIColor blackColor].CGColor;
    [self.headImageView addSubview:labelbg];
    
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
-(void)labelAct
{
    MHWebviewViewController *vc= [[MHWebviewViewController alloc]initWithurl:@"https://wap.mohuyoupin.com/hc_rule.html" comefrom:@"hucai"];
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
    titleLabel.text = @"狐猜拿好礼";
    titleLabel.alpha = 0;
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(naviView.mas_centerX).offset(0);
        make.centerY.equalTo(leftView.mas_centerY).offset(0);
        make.left.equalTo(naviView).offset(kRealValue(50));
        make.right.equalTo(naviView).offset(-kRealValue(50));
    }];
   
}
- (void)setTopView{
    self.topView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kRealValue(50))];
    self.topView.backgroundColor = KColorFromRGB(0xFE8646);
    self.topView.alpha = 0;
//    NSArray *Arr = [NSArray arrayWithObjects:@"10人场\n满10人开奖",@"20人场\n满10人开奖",@"30人场\n满10人开奖",@"40人场\n满10人开奖",@"50人场\n满10人开奖",@"60人场\n满10人开奖",@"70人场\n满10人开奖",@"80人场\n满10人开奖",nil];
   
    NSInteger btnoffset = 0;
    float originX  = 0;
    self.titlesButtons = [NSMutableArray array];
    for (int i = 0; i < self.sectionListArr.count; i++) {
         MHHucaiListModel *hucaimodel =[self.sectionListArr objectAtIndex:i];
        NSString *shotstr = [hucaimodel.roundName substringToIndex:hucaimodel.roundName.length -1];
        NSString *longstr = [NSString stringWithFormat:@"%@\n满%@开奖",hucaimodel.roundName,shotstr];
        originX = btnoffset;
        UIButton *btn = [[UIButton alloc]init];
        //默认样式
        NSMutableAttributedString *normalAttr = [[NSMutableAttributedString alloc] initWithString:longstr];
          NSMutableAttributedString *normalAttr1 = [[NSMutableAttributedString alloc] initWithString:longstr];
        btn.titleLabel.lineBreakMode =0 ;
        btn.titleLabel.textColor = KColorFromRGBA(0xffffff, 0.5);
        btn.titleLabel.font = [UIFont fontWithName:kPingFangRegular size:kRealValue(12)];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        NSDictionary *normalAttrDict = @{
                                         NSFontAttributeName:[UIFont systemFontOfSize:kRealValue(12)],
                                         NSForegroundColorAttributeName :KColorFromRGBA(0xffffff, 0.5)
                                         };
        [normalAttr addAttributes:normalAttrDict range:NSMakeRange(0, 4)];
        NSDictionary *normalAttrDict1 = @{
                                         NSFontAttributeName:[UIFont systemFontOfSize:kRealValue(10)],
                                         NSForegroundColorAttributeName :KColorFromRGBA(0xffffff, 0.5)
                                         };
        [normalAttr1 addAttributes:normalAttrDict1 range:NSMakeRange(4,longstr.length -4)];
        
        [btn setAttributedTitle:normalAttr forState:UIControlStateNormal];
        [btn setAttributedTitle:normalAttr1 forState:UIControlStateNormal];
        
        //选中样式
        NSMutableAttributedString *selectAttr = [[NSMutableAttributedString alloc] initWithString:longstr];
        NSDictionary *selectAttrDict = @{
                                         NSFontAttributeName:[UIFont systemFontOfSize:kRealValue(12)],
                                         NSForegroundColorAttributeName:[UIColor  whiteColor]
                                         };
        NSDictionary *selectAttrDict1 = @{
                                         NSFontAttributeName:[UIFont systemFontOfSize:kRealValue(10)],
                                         NSForegroundColorAttributeName:[UIColor  whiteColor]
                                         };
        [selectAttr addAttributes:selectAttrDict range:NSMakeRange(0,4)];
        [selectAttr addAttributes:selectAttrDict1 range:NSMakeRange(4, longstr.length -4)];
        [btn setAttributedTitle:selectAttr forState:UIControlStateSelected];

        btn.tag = i;
        [btn addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(originX,0 , kScreenWidth/4, kRealValue(40));
        btnoffset = CGRectGetMaxX(btn.frame);
        [self.topView addSubview:btn];
        [self.titlesButtons addObject:btn];
        if (i == 0) {
            btn.selected = YES;
            self.previousBtn = btn;
        }
        
        
    }
     self.topView.contentSize= CGSizeMake(btnoffset+kRealValue(20), kRealValue(50));
    [self.view addSubview:self.topView];

}


- (void)clickTitle:(UIButton *)sender{
    
    MHLog(@"%ld",sender.tag);
    MHLog(@"%ld",self.previousBtn.tag);
    if (sender.tag == self.previousBtn.tag) {
        
    }else{
        self.previousBtn.selected = NO;
        sender.selected = YES;
        self.previousBtn = sender;
        MHLog(@" sender.tag = %ld self.previousBtn.tag %ld",sender.tag,self.previousBtn.tag);
        
        
    }
   
    float offsetX = CGRectGetMinX(self.previousBtn.frame);
    [self.topView scrollRectToVisible:CGRectMake(offsetX, 0, self.topView.frame.size.width, self.topView.frame.size.height) animated:YES];
 
     [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag+1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    _IsClick = YES;
   
    
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(135);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return headViewHeight - kTopHeight - kTopViewHeight;;
    }else{
        return 40;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionListArr.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    if (self.sectionListArr.count > 0) {
        MHHucaiListModel *mdoel = self.sectionListArr[section -1];
        
        return mdoel.listrArr.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    if (section == 0) {
        headerView.backgroundColor = [UIColor clearColor];
    }else{
        
        headerView.backgroundColor = KColorFromRGB(0xff8746);
        UILabel *label = [[UILabel alloc]init];
        NSDictionary *attrDict = @{
                                   NSFontAttributeName:[UIFont systemFontOfSize:16.0f],
                                   NSForegroundColorAttributeName:[UIColor whiteColor]
                                   };
        MHHucaiListModel *hucaimodel ;
       
        if ( self.sectionListArr.count > 0) {
             hucaimodel =[self.sectionListArr objectAtIndex:section-1];
        }
      
        NSString *Str   = [NSString stringWithFormat:@"%@",hucaimodel.roundName];
        NSMutableAttributedString *attr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",Str] attributes:attrDict];

         label.attributedText = attr1;
        
        [headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView);
            make.left.equalTo(headerView.mas_left).offset(kRealValue(16));
        }];
    }
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MHHuGuesscell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHHuGuesscell class]) forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellEditingStyleNone;
    if ([self.sectionListArr count]> 0) {
         MHHucaiListModel *hucaimodel =[self.sectionListArr objectAtIndex:indexPath.section-1];
        NSMutableArray *Arr = hucaimodel.listrArr;
        MHPriceMoreListModel *model = [Arr objectAtIndex:indexPath.row];
        [cell.img sd_setImageWithURL:[NSURL URLWithString:model.productSmallImage] placeholderImage:kGetImage(kfailImage)];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.productName];
        cell.pricelabel.text = [NSString stringWithFormat:@"¥%@", model.productPrice];
        NSString *Str = [NSString stringWithFormat:@"活动场次%@场",[NSString stringWithFormat:@"%@",model.shareCount]];
        NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc]initWithString:Str];
        [attstring addAttribute:NSForegroundColorAttributeName value:KColorFromRGB(0xe20909) range:NSMakeRange(4, [NSString stringWithFormat:@"%@",model.shareCount].length)];
        [attstring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontValue(12)] range:NSMakeRange(4, [NSString stringWithFormat:@"%@",model.shareCount].length)];
        cell.Originpricelabel.attributedText = attstring;
//        cell.salenumlabel.text = @"";
        cell.Buybtn.backgroundColor = KColorFromRGB(0xFF8745);
        cell.PriceMoregotodetal = ^{
            MHHucaiListModel *hucaimodel =[self.sectionListArr objectAtIndex:indexPath.section];
            NSMutableArray *Arr = hucaimodel.listrArr;
            MHPriceMoreListModel *model = [Arr objectAtIndex:indexPath.row];
            MHHuGuessDetailViewController *vc= [[MHHuGuessDetailViewController alloc]initWithdrawId:[NSString stringWithFormat:@"%@", model.drawId] comefrom:@"list"];
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
                    [cell.Buybtn setTitle:@"等待开奖" forState:UIControlStateNormal];
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
        self.naviView.backgroundColor =KColorFromRGBA(0xff8746,(Offset+0.230978) *7.5 );
        self.topView.alpha = (Offset+0.230978) *8.5;
    }else if (iPhone6) {
        self.naviView.backgroundColor = KColorFromRGBA(0xff8746,(Offset+0.230978) *7.5 );
        self.topView.alpha = (Offset+0.230978) *7.5;
    }else if (iPhone6Plus) {
        self.naviView.backgroundColor = KColorFromRGBA(0xff8746,(Offset+0.230978) *7.5 );
        self.topView.alpha = (Offset+0.230978) *7.0;
    }else {
        self.naviView.backgroundColor = KColorFromRGBA(0xff8746,(Offset+0.230978) *7.5 );
        self.topView.alpha = (Offset+0.230978) *7.5;
    }
    self.titleLabel.alpha = (Offset+0.254873) *7;
    
    NSIndexPath *indexPath = [self.tableView indexPathsForVisibleRows].firstObject;
    MHLog(@"indexPath.section == %ld indexPath.row=%ld",indexPath.section, indexPath.row);
    [UIView animateWithDuration:0.4 animations:^{
        self.tipLine.frame = CGRectMake(5 + (indexPath.section * (kScreenWidth / 4.0)), 37, kScreenWidth / 4.0 - 10, 2);
    }];
    
    if (indexPath.section >=1) {
        UIButton *currentButton = self.titlesButtons[indexPath.section-1];
        self.previousBtn.selected = NO;
        currentButton.selected = YES;
        self.previousBtn = currentButton;
        MHLog(@"currentButton == %ld self.previousBtn=%ld",currentButton.tag, self.previousBtn.tag);
    }

    
    [UIView animateWithDuration:0.1 animations:^{

        
            float offsetX = CGRectGetMinX(self.previousBtn.frame);
            
            [self.topView scrollRectToVisible:CGRectMake(offsetX, 0, self.topView.frame.size.width, self.topView.frame.size.height) animated:YES];
        
    }];
    
    
}

- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHHucaiListModel *hucaimodel =[self.sectionListArr objectAtIndex:indexPath.section-1];
    NSMutableArray *Arr = hucaimodel.listrArr;
    MHPriceMoreListModel *model = [Arr objectAtIndex:indexPath.row];
    if ([model.status isEqualToString:@"PENDING"]) {
        
    }
    if ([model.status isEqualToString:@"INITIATE"]) {
        MHHuGuessDetailViewController *vc= [[MHHuGuessDetailViewController alloc]initWithdrawId:[NSString stringWithFormat:@"%@", model.drawId] comefrom:@"list"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([model.status isEqualToString:@"ACTIVE"]) {
        MHHuGuessDetailViewController *vc= [[MHHuGuessDetailViewController alloc]initWithdrawId:[NSString stringWithFormat:@"%@", model.drawId] comefrom:@"list"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([model.status isEqualToString:@"UNOPENED"]) {
        MHHuGuessDetailViewController *vc= [[MHHuGuessDetailViewController alloc]initWithdrawId:[NSString stringWithFormat:@"%@", model.drawId] comefrom:@"list"];
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
