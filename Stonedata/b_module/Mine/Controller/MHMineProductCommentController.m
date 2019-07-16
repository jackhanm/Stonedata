//
//  MHMineProductCommentController.m
//  mohu
//
//  Created by yuhao on 2018/10/10.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHMineProductCommentController.h"
#import "MHMineUserCommentCell.h"
#import "MHOrderCommentList.h"
#import "MHOrderCommenetSingerModel.h"
@interface MHMineProductCommentController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView   *contentTableView;
@property (nonatomic, strong) NSMutableArray *listArr;

@end

@implementation MHMineProductCommentController
- (instancetype)initWithorderId:(NSString *)orderId ;
{
    self = [super init];
    if (self) {
        self.oderdID = orderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价商品";
    self.view.backgroundColor = KColorFromRGB(0xEDEFF0);
    [self createview];
    [self getdata];
    // Do any additional setup after loading the view.
}
-(void)getdata
{
    self.listArr = [NSMutableArray array];
    [[MHUserService sharedInstance]initorderCommentListorderId:self.oderdID completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            NSMutableArray *Arr = [response valueForKey:@"data"];
            for (int i = 0; i < Arr.count; i++) {
                MHOrderCommentList *orderList = [[MHOrderCommentList alloc]init];
                orderList.orderId = [NSString stringWithFormat:@"%@",[Arr[i] valueForKey:@"orderId"]];
                orderList.productCount = [NSString stringWithFormat:@"%@",[Arr[i] valueForKey:@"productCount"]];
                orderList.productId = [NSString stringWithFormat:@"%@",[Arr[i] valueForKey:@"productId"]];
                orderList.productSmallImage = [NSString stringWithFormat:@"%@",[Arr[i] valueForKey:@"productSmallImage"]];
                orderList.productName = [NSString stringWithFormat:@"%@",[Arr[i] valueForKey:@"productName"]];
                 orderList.productStandard = [NSString stringWithFormat:@"%@",[Arr[i] valueForKey:@"productStandard"]];
                 orderList.skuId = [NSString stringWithFormat:@"%@",[Arr[i] valueForKey:@"skuId"]];
                orderList.productPrice = [NSString stringWithFormat:@"%@",[Arr[i] valueForKey:@"productPrice"]];
                 orderList.scrollnum = @"5";
                NSMutableArray *arr =[Arr[i] valueForKey:@"comments"];
                 NSMutableArray *brr =[NSMutableArray array];
                brr = [MHOrderCommenetSingerModel baseModelWithArr:arr];
                orderList.comments = brr;
                [self.listArr addObject:orderList];
            }
            [self.contentTableView reloadData];
        }
        
    }];
   
}
-(void)createview
{
    [self.view addSubview:self.contentTableView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"立即发布" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startPublish) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:KColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage buttonImageFromColors:@[[UIColor colorWithHexString:@"FF7A66"],[UIColor colorWithHexString:@"FF644C"]] ByGradientType:leftToRight withViewSize:CGSizeMake(kRealValue(90), kRealValue(28))] forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = kRealValue(22);
    btn.frame = CGRectMake(kRealValue(16), kScreenHeight- kRealValue(54) - kBottomHeight-kTopHeight,  kScreenWidth-kRealValue(32), kRealValue(40) );
    [self.view addSubview:btn];
}
-(void)startPublish
{
    for (int i = 0; i < self.listArr.count; i++) {
        MHOrderCommentList *listmodel = [self.listArr objectAtIndex:i];
        NSMutableArray *commentArr = [listmodel comments];
        NSString *conternt = @"";
        for (int i = 0; i< commentArr.count; i++) {
            MHOrderCommenetSingerModel *signermodel = [commentArr objectAtIndex:i];
            if (signermodel.isselelct == YES) {
                conternt = signermodel.msg;
            }
            
        }
        if (klStringisEmpty(conternt)) {
            KLToast(@"请完成评价后再提交!");
            return;
        }
    }
    for (int i = 0; i < self.listArr.count; i++) {
        NSMutableArray *arr =[NSMutableArray array];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        MHOrderCommentList *listmodel = [self.listArr objectAtIndex:i];
        NSMutableArray *commentArr = [listmodel comments];
        NSString *conternt = @"";
        for (int i = 0; i< commentArr.count; i++) {
            MHOrderCommenetSingerModel *signermodel = [commentArr objectAtIndex:i];
            if (signermodel.isselelct == YES) {
                conternt = signermodel.msg;
            }
            
        }
        [dic setValue:conternt forKey:@"content"];
        [dic setValue:listmodel.scrollnum forKey:@"score"];
        [dic setValue:listmodel.productId forKey:@"productId"];
        [dic setValue:listmodel.productStandard forKey:@"productStandard"];
        [dic setValue:@"" forKey:@"images"];
        [arr addObject:dic];
        [[MHUserService sharedInstance] initAddComment:arr orderId:self.oderdID completionBlock:^(NSDictionary *response, NSError *error) {
            
            if (ValidResponseDict(response)) {
                KLToast(@"评价成功!");
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
        
        
    }
    
   
   
}


-(UITableView *)contentTableView{
    
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentTableView.frame = CGRectMake(0, 0,kScreenWidth, kScreenHeight-kTopHeight);
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
        _contentTableView.backgroundColor = KColorFromRGB(0xEDEFF0);
        _contentTableView.estimatedRowHeight = 0;
        _contentTableView.sectionHeaderHeight= 0;
        _contentTableView.estimatedSectionFooterHeight = 0;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        _contentTableView.showsVerticalScrollIndicator = NO;
        [_contentTableView registerClass:[MHMineUserCommentCell class] forCellReuseIdentifier:NSStringFromClass([MHMineUserCommentCell class])];
        if (@available(iOS 11.0, *)) {
            _contentTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _contentTableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRealValue(365);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MHMineUserCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MHMineUserCommentCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor =KColorFromRGB(0xEDEFF0);
    cell.Choosetext = ^(NSInteger index) {
      MHOrderCommentList *listmodel = [self.listArr objectAtIndex:indexPath.row];
     
        for (int i = 0; i < listmodel.comments.count; i++) {
             MHOrderCommenetSingerModel *signermodel = [listmodel.comments objectAtIndex:i];
            if (i == index) {
                signermodel.isselelct = YES;
            }else{
                signermodel.isselelct = NO;
            }
            
        }
        [self.contentTableView reloadData];
        
    };
    cell.Choosescrollnum = ^(NSInteger count) {
        MHOrderCommentList *listmodel = [self.listArr objectAtIndex:indexPath.row];
        listmodel.scrollnum = [NSString stringWithFormat:@"%ld",count];
        
        
    };
    if (self.listArr.count > 0 ) {
        cell.model = [self.listArr objectAtIndex:indexPath.row];
    }
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (void)backBtnClicked{
    MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"当前信息已编辑，是否退出评价" ];
    alertVC.messageAlignment = NSTextAlignmentCenter;
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消评价" handler:^(CKAlertAction *action) {
        [alertVC showDisappearAnimation];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"继续评价" handler:^(CKAlertAction *action) {
        [alertVC showDisappearAnimation];
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
