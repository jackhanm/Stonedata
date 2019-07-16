//
//  MHGuessMyPrizeViewController.m
//  mohu
//
//  Created by yuhao on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHGuessMyPrizeViewController.h"
#import "MHRecordPresentCell.h"
#import "MHRecordPresentStatuController.h"
#import "MHSumbitHeadView.h"
#import "MHMineUserInfoAddressViewController.h"
#import "MHHuGuessPrizeProCell.h"
#import "MHMineuserAddress.h"
#import "MHHucaiPersionList.h"
@interface MHGuessMyPrizeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, strong)MHSumbitHeadView *headView ;
@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong)NSString *adressId;
@property (nonatomic, strong) MHHucaiPersionList *alert;
@end

@implementation MHGuessMyPrizeViewController

-(instancetype)initWithwinningId:(NSString *)winningId comefrom:(NSString *)comeform
{
    self = [super init];
    if (self) {
        self.winningId = winningId;
        self.comefrom = comeform;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"领取奖品";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createview];
    [self getdata];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAdress:) name:KNotificationchangeAdress object:nil];
    self.alert = [[MHHucaiPersionList alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.alert.comeform = self.comefrom;
    self.alert.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.alert];
   
}
-(void)changeAdress:(NSNotification *)noti
{
    MHMineuserAddress *adress = [noti object];
    self.headView.addressLabel.hidden = NO;
    self.headView.nameLabel.hidden = NO;
    self.headView.phoneLabel.hidden = NO;
    self.headView.emtyLabel.hidden = YES;
    self.headView.nameLabel.text = adress.userName;
    self.headView.phoneLabel.text =adress.userPhone;
    self.adressId = adress.addressId;
    self.headView.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",adress.province,adress.city,adress.area];
}


-(void)getdata
{
    self.listArr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    [[MHUserService sharedInstance]initorderCommentListwinningId:self.winningId completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            self.dic = [response valueForKey:@"data"];
            [self.contentTableView reloadData];
            
            NSString *drawnumpersion = [NSString stringWithFormat:@"%@",[self.dic valueForKey:@"drawNumber"]] ;
            NSInteger drawnumpersionnum = [drawnumpersion  integerValue];
            
            NSString *alertitle;
           
            if ([[self.dic valueForKey:@"participateUser"] count] == 0 ) {
                alertitle =[NSString stringWithFormat:@"0/%ld",drawnumpersionnum];
            }else
            {
                alertitle =[NSString stringWithFormat:@"%ld/%ld",[[self.dic  valueForKey:@"participateUser"] count],[[self.dic  valueForKey:@"participateUser"] count]];
            }
            
            self.alert.title =alertitle;
            self.alert.dic = self.dic;
        }
        
    }];
}
-(void)createview
{
    [self.view addSubview:self.contentTableView];
    if (false) {
        self.headView.addressLabel.hidden = NO;
        self.headView.nameLabel.hidden = NO;
        self.headView.phoneLabel.hidden = NO;
        self.headView.emtyLabel.hidden = YES;
        self.headView.nameLabel.text = @"jack";
        self.headView.phoneLabel.text = @"13716959617";
        self.headView.addressLabel.text = @"安徽省合肥市肥东县";
    }else{
        self.headView.addressLabel.hidden = YES;
        self.headView.nameLabel.hidden = YES;
        self.headView.phoneLabel.hidden = YES;
        self.headView.emtyLabel.hidden = NO;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"领取奖品" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getprize) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:KColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF7A66"],[UIColor colorWithHexString:@"FF644C"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = kRealValue(22);
    btn.frame = CGRectMake(kRealValue(16), kScreenHeight - kRealValue(55)-kTopHeight-kBottomHeight,  kScreenWidth-kRealValue(32), kRealValue(40));
    [self.view addSubview:btn];
    
}
-(void)getprize
{
    
    if (klObjectisEmpty(self.adressId)) {
        KLToast(@"请先选择地址");
        return;
    }
    [[MHUserService sharedInstance]initorderCommentListwinningId:self.winningId addressId:[NSString stringWithFormat:@"%@",self.adressId] completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            KLToast(@"领取成功");
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            KLToast([response valueForKey:@"message"]);
        }
        
    }];
    
}
-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
        _contentTableView.backgroundColor = KColorFromRGB(0xEDEFF0);
        _headView = [[MHSumbitHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kRealValue(86))];
        
        _headView.userInteractionEnabled =YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAdress)];
        [_headView addGestureRecognizer:tap];
        _contentTableView.tableHeaderView = _headView;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHRecordPresentCell class] forCellReuseIdentifier:NSStringFromClass([MHRecordPresentCell class])];
        [_contentTableView registerClass:[MHHuGuessPrizeProCell class] forCellReuseIdentifier:NSStringFromClass([MHHuGuessPrizeProCell class])];
        
        
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}

-(void)selectAdress{
    MHMineUserInfoAddressViewController *vc = [[MHMineUserInfoAddressViewController alloc]initWithcomeform:@"myprize"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
        return kRealValue(433);
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        MHHuGuessPrizeProCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHHuGuessPrizeProCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =KColorFromRGB(0xffffff);
    cell.seeAll = ^{
        MHLog(@"展示参团好友");
        self.alert.hidden = NO;
    };
     
    if (!klObjectisEmpty(self.dic)) {
        cell.dic = self.dic;
    }
    if ([self.comefrom isEqualToString:@"myprize"]) {
        cell.prizePersonPricelabel.hidden = YES;
    }
    if ([self.comefrom isEqualToString:@"prizemore"]) {
        cell.prizePersonPricelabel.hidden = YES;
    }
        return cell;
    
    

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
