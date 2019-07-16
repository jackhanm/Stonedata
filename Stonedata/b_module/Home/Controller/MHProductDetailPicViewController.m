//
//  MHProductDetailPicViewController.m
//  mohu
//
//  Created by 余浩 on 2018/9/22.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHProductDetailPicViewController.h"
#import "MHProductDetailPicView.h"
#import "MHProductPicModel.h"
@interface MHProductDetailPicViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic)UIScrollView *activityScroll;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation MHProductDetailPicViewController

- (instancetype)initWithDic:(NSMutableDictionary *)dic
{
    self = [super init];
    if (self) {
        
        self.dict = dic;
        [self getdata];
    }
    return self;
}
-(void)getdata
{
    self.dataArr = [NSMutableArray array];
    
    self.dataArr = [MHProductPicModel baseModelWithArr:[self.dict valueForKey:@"productBigImage"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self crateview];
    // Do any additional setup after loading the view.
}
-(void)crateview
{
    self.activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,kTopHeight, kScreenWidth, kScreenHeight-kTopHeight -kRealValue(44)-kBottomHeight)];
    self.activityScroll.backgroundColor = [UIColor whiteColor];
    self.activityScroll.showsHorizontalScrollIndicator = NO;
    self.activityScroll.showsVerticalScrollIndicator = NO;
    self.activityScroll.delegate =self;

    
    
    UILabel *labeltitle1 = [[UILabel alloc]init];
    labeltitle1.text = @"简  介";
    labeltitle1.textColor = KColorFromRGB(0x000000);
    labeltitle1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [self.activityScroll addSubview:labeltitle1];
    
    
    UILabel *labeldetail1 = [[UILabel alloc]init];
    labeldetail1.text = [self.dict valueForKey:@"productSubtitle"];
    labeldetail1.textColor = KColorFromRGB(0x333333);
//    labeldetail1.backgroundColor= kRandomColor;
    labeldetail1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    [self.activityScroll addSubview:labeldetail1];
//

    [labeltitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.activityScroll.mas_left).offset(kRealValue(16));
        make.top.equalTo(self.activityScroll.mas_top).offset(kRealValue(15));
        make.width.mas_equalTo(kRealValue(60));
        make.height.mas_equalTo(kRealValue(20));
    }];
    labeldetail1.numberOfLines = 0;
     CGRect rect = [labeldetail1.text boundingRectWithSize:CGSizeMake(kRealValue(264), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:kPingFangRegular size:kFontValue(12)]} context:nil];
    [labeldetail1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labeltitle1.mas_right).offset(kRealValue(19));
        make.top.equalTo(self.activityScroll.mas_top).offset(kRealValue(15));
//        make.right.equalTo(self.activityScroll.mas_right).offset(16);
        make.width.mas_equalTo(kRealValue(264));
    }];
   
    
    NSInteger btnoffset = rect.size.height + kRealValue(50);
    for (int i = 0; i < self.dataArr.count; i++) {
        UIImageView *bgview;
        MHProductPicModel *model = [self.dataArr objectAtIndex:i];
        if (klObjectisEmpty(model.width)) {
            bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,btnoffset ,kScreenWidth, 2* kScreenHeight)];
            [bgview sd_setImageWithURL:[NSURL URLWithString:model.filePath] placeholderImage:kGetImage(@"img_bitmap_white")];
        }else{
            bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0,btnoffset ,kScreenWidth,([model.height integerValue] *kScreenWidth /[model.width integerValue]))];
            [bgview sd_setImageWithURL:[NSURL URLWithString:model.filePath] placeholderImage:kGetImage(@"img_bitmap_white") ];
        }
        btnoffset = btnoffset + ([model.height integerValue] *kScreenWidth /[model.width integerValue]);
        [self.activityScroll addSubview:bgview];
    }
    self.activityScroll.contentSize = CGSizeMake(kScreenWidth,btnoffset);
    [self.view addSubview:self.activityScroll];
    if (@available(iOS 11.0, *)) {
        self.activityScroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        //       self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    [self.ProPicViewDelegate showNavAddtitle:offsetY];
    //禁止左右滑动左右
    self.activityScroll.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
